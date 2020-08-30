import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:hiring_open/src/models/job_model.dart';
import 'package:hiring_open/src/utils/user_preferences.dart';
import 'package:hiring_open/src/utils/credentials.dart' as credentials;

class JobProvider {

  final _baseurl  = credentials.baseurl;
  final _apikey = credentials.apiKey;

  final _prefs = new UserPreferences();

  //Filter List Variable
  final List<String> _postedDate = ['1','3','7','10','15','30'];
  final List<String> _distance = ['10','25','50','100','150','200'];
  final List<String> _industry = new List();
  final List<String> _employer = new List();
  final List<String> _experience = List.generate(15, (i)=> (i+1).toString());
  final List<String> _jobtype = new List();
  final List<String> _shiftype = new List();

  List<Job> _jobs = new List();
  List<StoredJob> _savedJobs = new List();
  List<String> _filterValue = new List();

  final _jobsController = StreamController<List<Job>>.broadcast();
  final _savedJobsController = StreamController<List<StoredJob>>.broadcast();
  final _filterValueController = StreamController<List<String>>.broadcast();

  Function(List<Job>) get jobSink => _jobsController.sink.add;
  Function(List<StoredJob>) get savedJobSink => _savedJobsController.sink.add;
  Function(List<String>) get filterValueSink => _filterValueController.sink.add;

  Stream<List<Job>> get jobStream => _jobsController.stream;
  Stream<List<StoredJob>> get savedJobStream => _savedJobsController.stream;
  Stream<List<String>> get filterValueStream => _filterValueController.stream;

  void disposeStreams(){
    _jobsController?.close();
    _filterValueController?.close();
    _savedJobsController?.close();
  }

  Future<Map> _requestHttp(Uri url) async {
  
    var resp;
    Map decodedResp = new Map();
    try {
      resp = await http.get(url,
        headers: {
          "Accept": "application/json; charset=UTF-8", 
        },
      );
    } catch (e) {
      print("Error in HTTP Request:");
      print(e.toString());
      return {'responseMessage' : 'ERROR', 'response' : "Couldn't process your request"};
    } 

    if (resp.statusCode == 200) {
      decodedResp = json.decode(resp.body);
    } else {
      print('Error HTTP:'+resp.statusCode.toString());
      return {'responseMessage' : 'ERROR', 'response' : "HTTP Error "+resp.statusCode.toString()};
    }

    return decodedResp;

  }

  Future<List<Job>> searchJob(String title, String location, dynamic k, dynamic v, String lat, String lng) async {

    _jobs.clear();
    final url = Uri.https(_baseurl, 'api/searchjob',
      {
        'title'  : title,
        // 'location' : 'Panchkula%252C+Haryana%252C+India',
        // 'srclat' : '30.6942091',
        // 'srclng' : '76.860565',
        'location' : location,
        'country': location,
        'state'  : "state",
        "city"   : 'city',
        'srclat' : lat,
        'srclng' : lng,
        'k'      : k,
        'v'      : v,
        'apikey' : _apikey,
      }
    );

    print(url);

    final resp = await _requestHttp(url);

    if (resp['responseMessage'] == 'ERROR') {
    _jobsController.addError(resp['response']);
    return [];
    }

    if (resp['responseMessage'] == 'SUCCESS' && resp['response'].length == 0) {
    _jobsController.addError("Jobs not found");
    return [];
    }
    
    final joblist = Jobs.fromJsonList(resp['response']);

    _jobs.clear();
    _jobs.addAll(joblist.jobs);
    jobSink(_jobs);
    return joblist.jobs;

  }  

  Future<List<StoredJob>> savedJobs() async {

    _savedJobs.clear();
    final userid = _prefs.userID;

    final url = Uri.https(_baseurl, 'api/getsavedjoblist/'+userid.toString(),
      {
        'apikey' : _apikey
      }
    );

    print(url);

    final resp = await _requestHttp(url);

    if (resp['responseMessage'] == 'ERROR') {
    _savedJobsController.addError(resp['response']);
    return [];
    }
   
    final joblist = StoredJobs.fromJsonList(resp['response']);
    _savedJobs.addAll(joblist.jobs);
    savedJobSink(_savedJobs);
    return joblist.jobs;
  }

  Future<List<StoredJob>> appliedJobs() async {

    _savedJobs.clear();
    final userid = _prefs.userID;

    final url = Uri.https(_baseurl, 'api/getappliedjoblist/'+userid.toString(),
      {
        'apikey' : _apikey
      }
    );

    print(url);

    final resp = await _requestHttp(url);

    if (resp['responseMessage'] == 'ERROR') {
    _savedJobsController.addError(resp['response']);
    return [];
    }

    final joblist = StoredJobs.fromJsonList(resp['response']);
    _savedJobs.addAll(joblist.jobs);
    savedJobSink(_savedJobs);
    return joblist.jobs;
  }

  Future<List<Job>> shortlistedJobs() async {

    final userid = _prefs.userID;

    final url = Uri.https(_baseurl, 'api/getshortlistedjoblist/'+userid.toString(),
      {
        'apikey' : _apikey
      }
    );

    print(url);

    final resp = await _requestHttp(url);

    if (resp['responseMessage'] == 'ERROR') return [];

    final joblist = Jobs.fromJsonList(resp['response']);
    return joblist.jobs;
  }

  Future<List<Job>> recommendedJobs() async {

    final userid = _prefs.userID;

    final url = Uri.https(_baseurl, 'api/getrecommendedjoblist/'+userid.toString(),
      {
        'apikey' : _apikey
      }
    );

    print(url);

    final resp = await _requestHttp(url);

    if (resp['responseMessage'] == 'ERROR') return [];

    final joblist = Jobs.fromJsonList(resp['response']);
    return joblist.jobs;
  }


  jobFilters(int index) async {

    _filterValue.clear();
    
    

    switch (index) {
      //Posted Date
      case 0: 
        _filterValue.addAll(_postedDate);
        break;
      //Distance
      case 1:
        _filterValue.addAll(_distance);
        break;
      //Industry
      case 2: 
          if (_industry.isNotEmpty) {
            _filterValue.addAll(_industry);
            break;
          }
          final url = Uri.https(_baseurl, 'api/getindustrytypelist',
            {
              'apikey' : _apikey
            }
          );
          final resp = await _requestHttp(url); 

          resp['response'].forEach((i){
            i.forEach((key,value){
              if (key == "name"){
                _industry.add(value);
              }
            });
          });
          _filterValue.addAll(_industry);
          break ;
      //Employer Type
      case 3:
          if (_employer.isNotEmpty){
            _filterValue.addAll(_employer);
            break;
          }
          final url = Uri.https(_baseurl, 'api/getemployertypelist',
            {
              'apikey' : _apikey
            }
          );
          final resp = await _requestHttp(url); 

          resp['response'].forEach((i){
            i.forEach((key,value){
              if (key == "name"){
                _employer.add(value);
              }
            });
          });
          _filterValue.addAll(_employer);
          break ;
      //Experience
      case 4: 
        return _experience;
      
      //Job Type
      case 5:
          if (_jobtype.isNotEmpty){
            _filterValue.addAll(_jobtype);
            break;
          }
          final url = Uri.https(_baseurl, 'api/getjobtypelist',
            {
              'apikey' : _apikey
            }
          );
          final resp = await _requestHttp(url); 

          resp['response'].forEach((i){
            i.forEach((key,value){
              if (key == "name"){
                _jobtype.add(value);
              }
            });
          });
          _filterValue.addAll(_jobtype);
          break;

        //Shift Type
        case 6:
            if (_shiftype.isNotEmpty){
              _filterValue.addAll(_shiftype);
              break;
            }
            final url = Uri.https(_baseurl, 'api/getshifttypelist',
              {
                'apikey' : _apikey
              }
            );
            final resp = await _requestHttp(url); 

            resp['response'].forEach((i){
              i.forEach((key,value){
                if (key == "name"){
                  _shiftype.add(value);
                }
              });
            });
            _filterValue.addAll(_shiftype);
            break ;
      default:
        _filterValue.addAll([]);
        break;
    }

    return _filterValue;
  }

  Future<Map> saveJob( int jobid) async {
    print('in function');
    bool found = false;
    final savedjobs = await savedJobs();
    if (savedjobs.isNotEmpty ){
      savedjobs.forEach((job){
        if (job.job.jobpostid == jobid){
          print('it already exists');
          found = true;
        }
      });
    }
    
    if (found) return {"responseMessage" : "ERROR", "response": "Job is already saved"};
    print('Didnt match');
    final userid = _prefs.userID;

    final url = Uri.https(_baseurl, 'api/addsavedjob',
      {
        'apikey' : _apikey, 
        'jobid'  : jobid.toString(),
        'userid' : userid.toString()
      }
    );

    return await _requestHttp(url);
  }

  Future<Map> deleteSavedJob(int jobid) async {

    final userid = _prefs.userID;

    final url = Uri.https(_baseurl, 'api/deletesavedjob',
      {
        'apikey' : _apikey, 
        'jobid'  : jobid.toString(),
        'userid' : userid.toString()
      }
    );
    print(url);

    return await _requestHttp(url);
    
  }

  Future<Map> applyJob(int jobid)  async {
    final userid = _prefs.userID;
    final info = _prefs.userInformation;
    final userInfo = json.decode(info);

    final url = Uri.https(_baseurl, 'api/applyjob/'+userid.toString(),
      {
        'apikey'     : _apikey, 
        'name'       : userInfo['username'],
        'email'      : userInfo['email'],
        'phone'      : userInfo['phone'],
        'jobpostid'  : jobid.toString(),
        'notifyjobs' : 1.toString(),
        'file'       : 'file'
      }
    );

    print(url);
    return await  _requestHttp(url);
  }
}
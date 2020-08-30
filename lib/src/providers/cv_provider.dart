import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';

import 'package:hiring_open/src/models/cv_model.dart';
import 'package:hiring_open/src/models/education_model.dart';
import 'package:hiring_open/src/models/experience_model.dart';
import 'package:hiring_open/src/utils/user_preferences.dart';
import 'package:hiring_open/src/utils/credentials.dart' as credentials;




class CVProvider {

  final _baseurl  = credentials.baseurl;
  final _apikey = credentials.apiKey;

  final _prefs = new UserPreferences();

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

  Future basicCvUser() async{

    final userid = _prefs.userID;
    final url = Uri.https(_baseurl, 'api/getcvbasicbyuserid/'+userid.toString(),
      {
        'apikey' : _apikey
      }
    );

    final resp = await _requestHttp(url);

    if(resp["responseMessage"] == "ERROR") return ;

    final cv = Cv.fromJson(resp["response"]);
    return cv; 
  }

  Future addBasicCv(Map<String, dynamic> info, PickedFile image ) async {

    final userid = _prefs.userID;
    final url = Uri.https(_baseurl, 'api/addcvbasic',
      {
        'apkikey' : _apikey,
        'userid'  : userid.toString(),
        // 'imgfile' : 'file',
        'name'    : info["name"]??'',
        'email'   : info["email"]??'',
        'phone'   : info["phone"]??'',
        'designation' : info["designation"]??'',
        'address'   : info["address"]??'',
        // 'latitude'  : 'lat',
        // 'longitude' : 'lng',
        // 'country'   : 'country',
        // 'state'     : 'state', 
        'skills'    : info["skills"]??'',
        'totalexp'  : info["experience"]??'',
        'currentctc': info["annual_ctc"]??'',
        'lastcompany': info["lastcompany"]??'',
        'highestedu': info["highestedu"]??'',
        'noticeperiod': info["notice_period"]??'',
        'description': info["description"]??'',
        // 'cvfile'    : 'file',
        'industry' : info["industry"]??''
      }
    );

    

    final cvUploadRequest = http.MultipartRequest('POST', url);

    if (image != null){
      final mimeType = mime(image.path).split('/');
      final file = await http.MultipartFile.fromPath(
        'imgfile', 
        image.path, 
        contentType: MediaType(mimeType[0], mimeType[1])
      );
    }

    final streamResponse = await cvUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode == 200 ){
      return json.decode(resp.body);

    } else {
      return {'responseMessage' : 'ERROR', 'response' : "Couldn't upload your image"};
    }
  }

  Future updateBasicCv(Map<String, dynamic> info, {File cv, PickedFile image}) async {

    final userid = _prefs.userID;
    final url = Uri.https(_baseurl, 'api/updatecvbasic',
      {
        'apkikey' : _apikey,
        'userid'  : userid.toString(),
        // 'imgfile' : 'file',
        'name'    : info["name"]??'',
        'email'   : info["email"]??'',
        'phone'   : info["phone"]??'',
        'designation' : info["designation"]??'',
        'address'   : info["address"]??'',
        // 'latitude'  : 'lat',
        // 'longitude' : 'lng',
        // 'country'   : 'country',
        // 'state'     : 'state', 
        'skills'    : info["skills"]??'',
        'totalexp'  : info["experience"]??'',
        'currentctc': info["annual_ctc"]??'',
        'lastcompany': info["lastcompany"]??'',
        'highestedu': info["highestedu"]??'',
        'noticeperiod': info["notice_period"]??'',
        'description': info["description"]??'',
        // 'cvfile'    : 'file',
        'industry' : info["industry"]??''
      }
    );

    if (image != null){
        final mimeType = mime(image.path).split('/');
        final file = await http.MultipartFile.fromPath(
          'imgfile', 
          image.path, 
          contentType: MediaType(mimeType[0], mimeType[1])
        );
      }
    

    final cvUploadRequest = http.MultipartRequest('POST', url);

    if (cv != null){
      final mimeType = mime(cv.path).split('/');
      final file = await http.MultipartFile.fromPath(
        'cvfile', 
        cv.path, 
        contentType: MediaType(mimeType[0], mimeType[1])
      );
    }

    final streamResponse = await cvUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode == 200 ){
      return json.decode(resp.body);

    } else {
      return {'responseMessage' : 'ERROR', 'response' : "Couldn't upload your cv: HTTP ERROR "+resp.statusCode.toString()};
    }
  }

  Future educationUser() async {
    final userid = _prefs.userID;
    final url = Uri.https(_baseurl, 'api/getcvedubyuserid/'+userid.toString(),
      {
        "apikey" : _apikey,
      }
    );

    final response =  await _requestHttp(url);

    final educationList = Educations.fromJsonList(response["response"]);

    return educationList.educations;
  }

  Future addEducation(Map<String, dynamic> education ) async {

    final userid = _prefs.userID;
    final url = Uri.https(_baseurl, 'api/addcvedu',
      {
        'apkikey'    : _apikey,
        'userid'     : userid.toString(),
        'education'  : education["education"],
        'college'    : education["college"],
        'studyfield' : education["studyfield"],
        'city'       : education["city"],
        'studyto'    : education["endDate"],
        'studyfrom'  : education["startDate"],
        'ispresent'  : education["currently"]== "true" ? "1" : "0",
      }
    );
   
    return await _requestHttp(url);

  }

  Future updateEducation(Map<String, dynamic> education) async {
    final userid = _prefs.userID;
    final url = Uri.https(_baseurl, 'api/updatecvedu',
      {
        "apikey" : _apikey, 
        "userid" : userid.toString(),
        'education'  : education["education"],
        'college'    : education["college"],
        'studyfield' : education["studyfield"],
        'city'       : education["city"],
        'studyto'    : education["endDate"],
        'studyfrom'  : education["startDate"],
        'ispresent'  : education["currently"]== "true" ? "1" : "0",
        'postcveduid': education["id"]
      }
    );

    return await _requestHttp(url);
  }

  Future experienceUser() async {
    final userid = _prefs.userID;
    final url = Uri.https(_baseurl, 'api/getcvexpbyuserid/'+userid.toString(),
      {
        "apikey" : _apikey,
      }
    );

    final response = await _requestHttp(url);

    final experiencelist = Experiences.fromJsonList(response["response"]);
    
    return experiencelist.experiences;

  }

  Future addExperience(Map<String, dynamic> experience ) async {

    final userid = _prefs.userID;
    final url = Uri.https(_baseurl, 'api/addcvexp',
      {
        'apkikey'    : _apikey,
        'userid'     : userid.toString(),
        'experience' : experience["experience"],
        'company'    : experience["company"],
        'city'       : experience["city"],
        'studyto'    : experience["endDate"],
        'studyfrom'  : experience["startDate"],
        'ispresent'  : experience["currently"] == "true" ? "1" : "0",
      }
    );
    
    return await _requestHttp(url);

  }

  Future updateExperience(Map<String, dynamic> experience ) async {

    final userid = _prefs.userID;
    final url = Uri.https(_baseurl, 'api/updatecvexp',
      {
        'apkikey'    : _apikey,
        'userid'     : userid.toString(),
        'experience' : experience["experience"],
        'company'    : experience["company"],
        'city'       : experience["city"],
        'studyto'    : experience["endDate"],
        'studyfrom'  : experience["startDate"],
        'ispresent'  : experience["currently"]== "true" ? "1" : "0",
        'postcvexpid': experience["id"]
      }
    );

    return await _requestHttp(url);

  }



}
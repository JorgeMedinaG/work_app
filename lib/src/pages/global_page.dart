import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:hiring_open/src/models/job_model.dart';

import 'package:flutter/cupertino.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hiring_open/src/providers/job_provider.dart';
import 'package:hiring_open/src/utils/custom_icons_icons.dart';
import 'package:hiring_open/src/utils/credentials.dart' as credentials;

import 'package:hiring_open/src/values/values.dart';




class GlobalPage extends StatefulWidget {
  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {

  final formKey = GlobalKey<FormState>();

  final jobProvider = JobProvider();

  String _jobTitleString = '';
  String _locationString = '';
  String _k = 'na';
  String _v = 'na';
  String _lat = '';
  String _lng = '';
  String _tempk = 'na';
  String _tempv = 'na';
  bool search ;

  //Filter Selection Variables
  List<bool> _selectedFilter ;
  List<String> options = new List();
  int radiovalue = 0;
  int filtervalue = 0;

  //Google Places 
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: credentials.googleApiKey);

  TextEditingController _locationController = new TextEditingController();
  TextEditingController _titleController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    search = false;
    _selectedFilter = List.generate(8, (i) => false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
  
    if (!search) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SafeArea(
          child: Container(
            constraints: BoxConstraints.expand(),
            margin: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: ListView(
                children: [
                SizedBox(height: 60.0),
                _topText(size),
                SizedBox(height: 40.0,),
                _searchForm()
                ],
                  ),         
          ),
        ),
      );
    } else {
      return Scaffold(
      backgroundColor: AppColors.tertiaryBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, size: 30.0,), 
          onPressed: (){
            setState(() {
              search = false;
            });
          }
          ),
        title: TextFormField(
          initialValue: _jobTitleString+', '+_locationString,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(CustomIcons.filter,
              size: 20.0,
            ),
            onPressed: () => _filter(),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0.0,
        
      ),
      body: SafeArea(
        child: _jobList()             
        ),
    );
    }
  }

  //Methods for Search Screen

  Widget _topText(Size size) {

    double fontsize;
    if (size.width < 400.0){
      fontsize = size.width * 0.048;
    } else {
      fontsize = 20;
    }

    return Container(
      alignment: Alignment.center,
      child: Text('What kind of job you are\n looking for?',
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: fontsize,
        )
      ),
    );
    
  }

  Widget _searchForm() {
    return Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            _jobTitle(),
            SizedBox(height: 30.0,),
            _location(),
            SizedBox(height: 50.0),
            _button()
          ],
        )
      
    );
  }


  Widget _jobTitle(){

    return TextFormField(
      controller: _titleController,
      decoration: InputDecoration(
        labelText: 'Job Title or Keywords',
        labelStyle: GoogleFonts.poppins()
      ),
      onSaved: (value){ 
        _jobTitleString = value;
        _titleController.text = value;
        },
    );

  }

  Widget _location() {
    return TextFormField(
      controller: _locationController,
      decoration: InputDecoration(
        labelText: 'City, State or Zip Code',
        labelStyle: GoogleFonts.poppins()
      ),
      onTap: () async {
        final p = await PlacesAutocomplete.show(
          context: context, 
          apiKey: credentials.googleApiKey, 
          // mode: Mode.overlay,
        );
        if (p != null) {
          // get detail (lat/lng)
          // PlacesDetailsResponse 
          final detail = await _places.getDetailsByPlaceId(p.placeId);
          final lat = detail.result.geometry.location.lat;
          final lng = detail.result.geometry.location.lng;

          print("${p.description} - $lat/$lng");
          _locationController.text = p.description;
          _locationString = p.description;
          _lat = lat.toString();
          _lng = lng.toString();
        }
      }
    );
  }

  Widget _button(){
    return Container(
      width: double.infinity,
      height: 62.0,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text('SEARCH FOR JOB', 
          style: GoogleFonts.poppins(
            fontSize: 20.0
          ),
        ),
        disabledColor: Colors.grey,
        color: AppColors.primaryBackground,
        textColor: Color.fromARGB(255, 255, 255, 255),
        onPressed: () async {
          print('press search');

          formKey.currentState.save();
          
          jobProvider.searchJob(_jobTitleString, _locationString, _k, _v, _lat, _lng);
          setState(() {
            search = true;
          });
          // Navigator.pushNamed(context, 'map');
        },
      ),
    );
  }

  //Methods for SearchResults

  void _filter() async {

    final height =  MediaQuery.of(context).size.height;
    final width =  MediaQuery.of(context).size.width;
    final fontsize = 16.0;

    final List filters = ['Posted Date', 'Distance', 'Industry','Employer Type','Experience', 'Job Type','Shift'];
    final List keys = ['lastupdate', 'radius','industry','employer','experience','job','shift'];

    await showModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (BuildContext context){
        return StatefulBuilder(builder: (BuildContext context, StateSetter setModalState) {
            
            
            Widget _filterOptions(){
              
              String _comText(){
                if (filtervalue == 0) return ' Days';
                if (filtervalue == 1) return ' Miles';
                if (filtervalue == 4) return ' Years';
                return '';
              }
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index){
                        return RadioListTile(
                          dense: true,
                          activeColor: AppColors.primaryColor,
                          title: Text(options[index]+_comText()),
                          value: index, 
                          groupValue: radiovalue, 
                          onChanged: (value){
                            setModalState((){
                              radiovalue = value;
                              _tempv = options[value]; 
                            });
                          }
                        );
                      }
                    )
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.35,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      color: AppColors.primaryColor,
                      child: Text('Apply', style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16.0
                      ),),
                      onPressed: (){
                        print(_tempk);
                        print(_tempv);
                        setState(() {
                          _k = _tempk;
                          _v = _tempv;
                          jobProvider.searchJob(_jobTitleString, _locationString, _k, _v, _lat, _lng);
                          Navigator.pop(context);
                        });
                        
                      }
                      ),
                  )
                ],
              );
            }



            void _selectFilter(int i) async {
              if (filtervalue == i) return; //If it's the same option
              options = await jobProvider.jobFilters(i);
              _selectedFilter = List.generate(8, (i) => false);
              setModalState(() {
                _selectedFilter[i] = true;
                filtervalue = i;
                _tempk = keys[i];
              });
            }

            List<Widget> _filterList(){

              List<Widget> items = new List();

              filters.forEach((item){
                
                final tempwidget = ListTile(
                  title: Text(item, style: GoogleFonts.poppins(fontSize:fontsize),), 
                  dense: true, 
                  selected: _selectedFilter[filters.indexOf(item)], 
                  onTap: () => _selectFilter(filters.indexOf(item)),
                );

                items.add(tempwidget);
              });

              return items;
            }

          return Container(        
            height: height * 0.50,
            child: Column(
              children: <Widget>[
                //Top Section
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    children: <Widget>[
                      Text("Filter", style: GoogleFonts.poppins(fontSize: fontsize),),
                      Spacer(),
                      InkWell(
                        child: Text("Clear all", style: GoogleFonts.poppins(fontSize: fontsize, color: AppColors.primaryColor),),
                        onTap: () {
                          setModalState((){
                            radiovalue = 0;
                            filtervalue = 0;
                            _selectedFilter = List.generate(8, (i) => false);
                            options = new List();
                            _tempk = 'na';
                            _tempv = 'na';
                          });
                        },
                      )
                    ],
                  ),
                ),
                //Body
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: width * 0.45,
                        color: AppColors.tertiaryBackground,
                        child: ListView(
                         children: _filterList()
                        ),
                      ),
                      Container(
                        width: width * 0.55,
                        color: Colors.white,
                        child: _filterOptions(),
                      ),
                    ],
                  ),
                ),

              ],
            )
          );
        }
        
        );

      }
    );
  }

  Widget _jobList() {

    return StreamBuilder(
      stream: jobProvider.jobStream ,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index){
              return _card(snapshot.data[index]);
            }
            );        
        } else {
          if (snapshot.hasError){
            return Center(
              child: Text(snapshot.error,
                style: GoogleFonts.poppins(
                  fontSize: 18.0,
                ),
              )
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }

      },
    );
  
  }
  Widget _card(Job job){

    final size = MediaQuery.of(context).size;
    double fontsize;
    if (size.width < 400.0){
      fontsize = size.width * 0.048;
    } else {
      fontsize = 20;
    }
    return GestureDetector(
      onTap: () {Navigator.of(context).pushNamed('jobdetail', arguments: job);},
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        borderOnForeground: true,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left:20.0, top:20.0, bottom: 7.0),
              alignment: Alignment.centerLeft,
              child: Text(job.title, style: GoogleFonts.poppins(
                fontSize: fontsize,
                fontWeight: FontWeight.w500
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right:10.0),
                    child: Image.asset('assets/icons/location-icon.png',height: 20.0,),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Text(job.city+', '+job.state+', '+job.country, 
                      style: GoogleFonts.poppins(
                        fontSize: fontsize - 6
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right:10.0),
                    child: Image.asset('assets/icons/job-skills.png',height: 20.0,),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Html(data: job.jobsummary, 
                      defaultTextStyle: TextStyle(
                        
                      ),
                    )
                    // Text(job.jobsummary, 
                    //   style: GoogleFonts.poppins(
                    //     fontSize: fontsize - 6,
                    //   ),
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0, bottom: 10.0, right: 25.0),
              child: Row(
               children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.only(right:10.0),
                   child: Image.asset('assets/icons/experience.png',height: 20.0,),
                 ),
                 Container(
                   width: MediaQuery.of(context).size.width * 0.30,
                   child: Text(job.expyear+' years Exp.', 
                    style: GoogleFonts.poppins(
                      fontSize: fontsize - 6,
                    ),
                    overflow: TextOverflow.ellipsis,
                   ),
                 ),
                 Spacer(),
                 Padding(
                   padding: const EdgeInsets.only(right:10.0),
                   child: Image.asset('assets/icons/post-date.png',height: 20.0,),
                 ),
                 Container(
                   width: MediaQuery.of(context).size.width * 0.35,
                   child: Text('Posted: '+job.createddatetime.toString().substring(0,10), 
                    style: GoogleFonts.poppins(
                      fontSize: fontsize - 6,
                    ),
                    overflow: TextOverflow.ellipsis,
                   ),
                 )
               ],
              ),
            ),
           Divider(),
           Padding(
             padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
             child: Row(
               children: <Widget>[
                 CircleAvatar(
                   radius: 15.0,
                 ),
                 Container(
                   width: MediaQuery.of(context).size.width * 0.7,
                   child: Text('  '+job.company, style: GoogleFonts.poppins(
                     fontWeight: FontWeight.w500,
                     fontSize: fontsize - 6,
                    ),
                    overflow: TextOverflow.ellipsis,
                   ),
                 )
               ],
             ),
           ),

          ],
        ),
      ),
    );
  }
}
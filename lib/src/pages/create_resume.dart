import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flat_segmented_control/flat_segmented_control.dart';
import 'package:image_picker/image_picker.dart';

import 'package:hiring_open/src/widgets/errordialog.dart';
import 'package:hiring_open/src/widgets/loading.dart';
import 'package:hiring_open/src/models/cv_model.dart';
import 'package:hiring_open/src/providers/cv_provider.dart';
import 'package:hiring_open/src/values/values.dart';


Map<String, dynamic> profileData = new Map();
Map experience = {
  0 : {
      'title' : '',
      'company' : '',
      'city' : '',
      'startDate' : '',
      'endDate' : '',
      'currently' : '',
      'id'       : ''
    },
  1 : {
      'title' : '',
      'company' : '',
      'city' : '',
      'startDate' : '',
      'endDate' : '',
      'currently' : '', 
      'id' :''
    },
  2 : {
      'title' : '',
      'company' : '',
      'city' : '',
      'startDate' : '',
      'endDate' : '',
      'currently' : '',
      'id' :''
    },
  3 : {
      'title' : '',
      'company' : '',
      'city' : '',
      'startDate' : '',
      'endDate' : '',
      'currently' : '',
      'id' :''
    },
  4 : {
      'title' : '',
      'company' : '',
      'city' : '',
      'startDate' : '',
      'endDate' : '',
      'currently' : '',
      'id' :''
    },
};
Map education = {
  0 : {
      'education' : '',
      'college' : '',
      'fieldStudy' : '',
      'city' : '',
      'startDate' : '',
      'endDate' : '',
      'currently' : '',
      'id' :''
    },
  1 : {
      'education' : '',
      'college' : '',
      'fieldStudy' : '',
      'city' : '',
      'startDate' : '',
      'endDate' : '',
      'currently' : '',
      'id' :''
    },
  2 : {
      'education' : '',
      'college' : '',
      'fieldStudy' : '',
      'city' : '',
      'startDate' : '',
      'endDate' : '',
      'currently' : '',
      'id' :''
    },
  3 : {
      'education' : '',
      'college' : '',
      'fieldStudy' : '',
      'city' : '',
      'startDate' : '',
      'endDate' : '',
      'currently' : '',
      'id' :''
    },
  4 : {
      'education' : '',
      'college' : '',
      'fieldStudy' : '',
      'city' : '',
      'startDate' : '',
      'endDate' : '',
      'currently' : '',
      'id' :''
    }
};

  

class CreateResume extends StatefulWidget {
  @override
  _CreateResumeState createState() => _CreateResumeState();
}

class _CreateResumeState extends State<CreateResume> {

  final formKey     = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final infoMap    = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Navigator.canPop(context) ? IconButton(
          icon: Icon(Icons.keyboard_arrow_left, size: 30.0,), 
          onPressed: () => Navigator.pop(context)
          ) : Container(),

        title: Text('Create Resume', style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
        ),),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: FlatSegmentedControl(
          indicatorColor: AppColors.primaryColor,
          tabChildren: [
            Container(
            height: 50.0,
            child: Center(child: Text("Profile")),
            ),
            Container(
            height: 50.0,
            child: Center(child: Text("Education")),
            ),
            Container(
            height: 50.0,
            child: Center(child: Text("Experience")),
            ),
          ],
          childrenHeight: MediaQuery.of(context).size.height * 0.78,
          children: <Widget>[
            ProfileForm(formKey: formKey, map: infoMap),
            EducationForm(formKey: formKey, map: infoMap),
            ExperienceForm(formKey: formKey, map: infoMap)
          ],
        ),
      ),
    );
  }

}

//TODO: Profile Form 
class ProfileForm extends StatefulWidget {

  final Function onSubmit;
  final GlobalKey<FormState> formKey;
  final Map map;
  ProfileForm( {this.formKey, this.onSubmit, this.map});

  @override
  _ProfileFormState createState() => _ProfileFormState();
}
PickedFile pickedFile;

class _ProfileFormState extends State<ProfileForm> {

  final picker = ImagePicker();
  Map info = new Map();
  @override
  void initState() { 
    super.initState();
    info = widget.map;
    if (info["hasCv"]){
      profileData = cvToMap(info["cv"]);
    }
  }
  
  @override
  Widget build(BuildContext context) {

    final cv = widget.map["cv"];

    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical:10.0),
          child: Column(
            children: <Widget>[
              _image(),
              _name(cv),
              _email(cv),
              _phone(cv),
              _designation(cv),
              _address(cv),
              _skills(cv),
              _ctc(cv),
              _lastCompany(cv),
              _experience(cv),
              _education(cv),
              _noticePeriod(cv),
              _industry(cv),
              _summary(cv),
            ],
          ),
        ),
      ),
    );
  }

  Widget _image(){

    String imageurl = '';
    print(imageurl);
    return GestureDetector(
      child: CircleAvatar(
        backgroundImage: AssetImage(pickedFile?.path ??  'assets/img/default-user.png'),
        radius: 70.0,
      ),
      onTap: () async {
        print('tapped');
        
        pickedFile = await picker.getImage(source: ImageSource.gallery);
        if (pickedFile == null) return;
        setState(() {
          
        });
        print(pickedFile.path);

      },
    );
  }

  Widget _name(Cv cv) {
    return TextFormField(
      initialValue: cv.name ?? '',
      decoration: InputDecoration(
        labelText: 'NAME',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['name'] =  value,
    );
  }

  Widget _email(Cv cv) {
    return TextFormField(
      initialValue: cv.email ?? '',
      decoration: InputDecoration(
        labelText: 'EMAIL ADDRESS',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['email'] =  value,
    );
  }

  Widget _phone(Cv cv) {
    return TextFormField(
      initialValue: cv.phone ?? '',
      decoration: InputDecoration(
        labelText: 'PHONE NO.',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['phone'] =  value,
    );
  }

  Widget _designation(Cv cv) {
    return TextFormField(
      initialValue: cv.designation ?? '',
      decoration: InputDecoration(
        labelText: 'DESIGNATION',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['designation'] =  value,
    );
  }

  Widget _address(Cv cv) {
    return TextFormField(
      initialValue: cv.address??'',
      decoration: InputDecoration(
        labelText: 'ADDRESS',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['address'] =  value,
    );
  }

  Widget _skills(Cv cv) {
    return TextFormField(
      initialValue: cv.skills??'',
      decoration: InputDecoration(
        labelText: 'SKILLS',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['skills'] =  value,
    );
  }

  Widget _ctc(Cv cv) {
    return TextFormField(
      initialValue: cv.currentctc??'',
      decoration: InputDecoration(
        labelText: 'ANNUAL CTC',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['annual_ctc'] =  value,
    );
  }

  Widget _lastCompany(Cv cv) {
    return TextFormField(
      initialValue: cv.lastcompany??'',
      decoration: InputDecoration(
        labelText: 'LAST COMPANY',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['last_company'] =  value,
    );
  }

  Widget _experience(Cv cv) {
    return TextFormField(
      initialValue: cv.totalexp??'',
      decoration: InputDecoration(
        labelText: 'TOTAL EXPERIENCE',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['experience'] =  value,
    );
  }

  Widget _education(Cv cv) {
    return TextFormField(
      initialValue: cv.highestedu??'',
      decoration: InputDecoration(
        labelText: 'HIGHEST EDUCATION',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['education'] =  value,
    );
  }

  Widget _noticePeriod(Cv cv) {
    return TextFormField(
      initialValue: cv.noticeperiod??'',
      decoration: InputDecoration(
        labelText: 'NOTICE PERIOD',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['notice_period'] =  value,
    );
  }

  Widget _industry(Cv cv) {
    return TextFormField(
      initialValue: cv.industry??'',
      decoration: InputDecoration(
        labelText: 'INDUSTRY',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['industry'] =  value,
    );
  }

  Widget _summary(Cv cv) {
    return TextFormField(
      initialValue: cv.description??'',
      decoration: InputDecoration(
        labelText: 'PROFILE SUMMARY',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['profile_summary'] =  value
    );
  }

  
}


//TODO:Education Form
class EducationForm extends StatefulWidget {

  // int _studyCounter = 1;
  final Function onSubmit;
  final GlobalKey<FormState> formKey;
  final Map map;
  EducationForm({this.formKey, this.onSubmit, this.map});

  @override
  _EducationFormState createState() => _EducationFormState();
}

class _EducationFormState extends State<EducationForm> {

  List<TextEditingController> startDateController = [TextEditingController()];
  List<TextEditingController> endDateController = [TextEditingController()];
  List<bool> currently = [false];
  int  _studyCounter = 1;

  List<Widget> widgets = new List();
  Map info;
  @override
  void initState() { 
    super.initState();
    info = widget.map;

    if (info["hasEdu"]){
      _studyCounter = info["education"].length;
      for (var i = 0; i < info["education"].length; i++) {
        education[i]['education'] = info["education"][i].education; 
        education[i]['college'] = info["education"][i].college;
        education[i]['fieldStudy'] = info["education"][i].studyfield;
        education[i]['city'] = info["education"][i].city;
        education[i]['startDate'] = info["education"][i].studyfrom;
        education[i]['endDate'] = info["education"][i].studyto;
        education[i]['currently'] = info["education"][i].ispresent == 1 ? "true" : "false";
        education[i]['id'] = info["education"][i].postcveduid.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded( child: _formBody(context)),
        ]
        ),
    );
  }

  Widget _formBody(BuildContext context){
    return SingleChildScrollView(
      child: Form(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _registers(context)
        ),
      ),
    );
  }

  List<Widget> _registers(BuildContext context){

    if (widgets.length == _studyCounter) {
      return widgets;
    } else {
      widgets = new List();
    }


    for (var i = 0; i < _studyCounter; i++) {
      widgets.addAll(_formFields(context, i));
      if (currently.length < _studyCounter) currently.add(false);
      // if (education.length < _studyCounter) education.add(values);
      if (startDateController.length < _studyCounter) startDateController.add(TextEditingController());
      if (endDateController.length < _studyCounter) endDateController.add(TextEditingController());
    }

    widgets.add(SizedBox(height:10.0));
    widgets.add(RaisedButton(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.add, color:Colors.white),
                Text('Add Education', style: GoogleFonts.poppins(color:Colors.white),),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0)
            ),
            color: AppColors.primaryColor,
            onPressed: (){
              setState(() {
                if (_studyCounter <= 4){
                  _studyCounter++;
                }
              });
            },
          ));
    return widgets;
  }

  List<Widget> _formFields(BuildContext context, int i) {
    bool initial = false;
    if (i < info["education"].length){
      initial = true;
      education[i]["id"] = info["education"][i].postcveduid.toString();
    }
    
    final widgetlist = [
      SizedBox(height: 25.0),
      _education(i,initial),
      _college(i, initial),
      _fieldStudy(i, initial),
      _city(i, initial),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(top:30.0),
        child: Text('STUDY TIME PERIOD',
          style: GoogleFonts.poppins(
            fontSize: 20.0,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
      _studyTimes(context, i, initial)
    ];
    return widgetlist;
  }

  Widget _education(int i, bool initial) {
    return TextFormField(
      initialValue: initial ? info["education"][i].education : '',
      decoration: InputDecoration(
        labelText: 'EDUCATION',
        labelStyle: GoogleFonts.poppins(),
      ),
      onChanged: (value) => education[i]["education"] = value,
    );
  }

  Widget _college(int i, bool initial) {
    return TextFormField(
      initialValue: initial ? info["education"][i].college : '',
      decoration: InputDecoration(
        labelText: 'COLLEGE OR UNIVERISTY',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => education[i]["college"] = value,
    );
  }

  Widget _fieldStudy(int i, bool initial) {
    return TextFormField(
      initialValue: initial ? info["education"][i].studyfield : '',
      decoration: InputDecoration(
        labelText: 'FIELD OF STUDY',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => education[i]["education"] = value,
    );
  }

  Widget _city(int i, bool initial) {
    return TextFormField(
      initialValue: initial ? info["education"][i].city : '',
      decoration: InputDecoration(
        labelText: 'CITY',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => education[i]["city"] = value,
    );
  }

  Widget _studyTimes(BuildContext context, int i, bool initial){

    if (initial) {
        currently[i] = info["education"][i].ispresent == "1" ? true : false;
        
        if (info["education"][i].studyfrom != null){
          startDateController[i].text = info["education"][i].studyfrom;
        }
        if (info["education"][i].studyto != null){
          endDateController[i].text = info["education"][i].studyto;
        }
      }
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Checkbox(
              activeColor: AppColors.primaryColor,
              value: currently[i], 
              onChanged: (value){
                setState(() {
                  print(value);
                  print(education);
                  currently[i] = value;
                  education[i]["currently"] = value;
                });
              }
            ),
            Text('I Currently Study here',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300
              ),
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              child: TextFormField(
                // initialValue: '-- -- ----',
                controller: startDateController[i],
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'START DATE',
                  labelStyle: GoogleFonts.poppins(),
                  suffixIcon: Icon(Icons.calendar_today)
                ),
              onTap: () async {
                final date = await showDatePicker(
                  context: context, 
                  initialDate: DateTime.now(), 
                  firstDate: DateTime(1950), 
                  lastDate: DateTime(2050)
                );
                if (date != null) {
                  setState(() {
                    print(DateFormat('dd-MM-yyyy').format(date));
                    startDateController[i].text = DateFormat('MM-dd-yyyy').format(date);
                    education[i]["startDate"] = DateFormat('MM-dd-yyyy').format(date).toString();
                  });
                }
              },
              ),
            ),
            SizedBox(width: 20.0,),
            currently[i] ? Container() : 
            Flexible(
              child: TextFormField(
                // initialValue: '-- -- ----',
                controller: endDateController[i],
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'END DATE',
                  labelStyle: GoogleFonts.poppins(),
                  suffixIcon: Icon(Icons.calendar_today)
                ),
              onTap: () async {
                final date = await showDatePicker(
                  context: context, 
                  initialDate: DateTime.now(), 
                  firstDate: DateTime(1950), 
                  lastDate: DateTime(2050)
                );
                if (date != null) {
                  setState(() {
                    print(DateFormat('dd-MM-yyyy').format(date));
                    endDateController[i].text = DateFormat('MM-dd-yyyy').format(date);
                    education[i]["endDate"] = DateFormat('MM-dd-yyyy').format(date).toString();
                  });
                }
              },
              ),
            ) 
          ],
        )
      ],
    );
  }



}


//TODO:Experience Form 
class ExperienceForm extends StatefulWidget {

  // int _jobCounter = 1;
  final Function onSubmit;
  final GlobalKey<FormState> formKey;
  final Map map;
  ExperienceForm({this.formKey, this.onSubmit, this.map});
  
  @override
  _ExperienceFormState createState() => _ExperienceFormState();
}

class _ExperienceFormState extends State<ExperienceForm> {

  final cvProvider  = new CVProvider();
  List<TextEditingController> startDateController = [TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()];
  List<TextEditingController> endDateController = [TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()];
  List<bool> currently = [false, false, false, false, false];
  int  _jobCounter = 1;

  List<Widget> widgets = new List();
  Map info;
  @override
  void initState() { 
    super.initState();
    info = widget.map;

    if (info["hasExp"]){
      _jobCounter = info["experience"].length;
      for (var i = 0; i < info["experience"].length; i++) {
        experience[i]['title'] = info["experience"][i].jobtitle; 
        experience[i]['company'] = info["experience"][i].company;
        experience[i]['city'] = info["experience"][i].city;
        experience[i]['startDate'] = info["experience"][i].jobfrom;
        experience[i]['endDate'] = info["experience"][i].jobto;
        experience[i]['currently'] = info["experience"][i].ispresent == 1 ? "true" : "false";
        experience[i]['id'] = info["experience"][i].postcvexpid.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded( child: _formBody(context)),
          _button()
        ]
        );
  }

  Widget _formBody(BuildContext context){
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child:Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _registers(context)
          ),
        ),
      ),
    );
  }

  List<Widget> _registers(BuildContext context){

    print('Widget List Lenght: '+widgets.length.toString());
    if (widgets.length == _jobCounter) {
      return widgets;
    } else {
      widgets = new List();
    }

    for (var i = 0; i < _jobCounter; i++) {
      print(i);
      widgets.addAll(_formFields(context, i));
      if (currently.length < _jobCounter) currently.add(false);
      if (startDateController.length < _jobCounter) startDateController.add(TextEditingController());
      if (endDateController.length < _jobCounter) endDateController.add(TextEditingController());
    }

    widgets.add(SizedBox(height:10.0));
    widgets.add(RaisedButton(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.add, color:Colors.white),
                Text('Add Experience', style: GoogleFonts.poppins(color:Colors.white),),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0)
            ),
            color: AppColors.primaryColor,
            onPressed: (){
              setState(() {
                if (_jobCounter <= 4){
                  _jobCounter++;
                }
                
              });
            },
          ));
    return widgets;
  }

  List<Widget> _formFields(BuildContext context, int i) {

    bool initial = false;
    if (i < info["experience"].length){
      initial = true;
      experience[i]["id"] = info["experience"][i].postcvexpid.toString();
    }

    final widgetlist = [
      SizedBox(height: 25.0),
      _jobTitle(i, initial),
      _company(i, initial),
      _city(i, initial),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(top:30.0),
        child: Text('JOB TIME PERIOD',
          style: GoogleFonts.poppins(
            fontSize: 20.0,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
      _studyTimes(context, i, initial)
    ];
    return widgetlist;
  }

  Widget _jobTitle(int i, bool initial ) {
    return TextFormField(
      // ValueKey('jobtitle'+i.toString()),
      initialValue: initial ? info["experience"][i].jobtitle : '',
      decoration: InputDecoration(
        labelText: 'JOB TITLE',
        labelStyle: GoogleFonts.poppins(),
      ),
      onChanged: (value ) { print(i); experience[i]["title"] = value;},
    );
  }

  Widget _company(int i, bool initial) {
    return TextFormField(
      initialValue: initial ? info["experience"][i].company : '',
      decoration: InputDecoration(
        labelText: 'COMPANY',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value ) { experience[i]["company"] = value;},
    );
  }

  Widget _city(int i, bool initial) {
    return TextFormField(
      initialValue: initial ? info["experience"][i].city : '',
      decoration: InputDecoration(
        labelText: 'CITY',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value ) { 
        print(i);
        experience[i]["city"] = value;
      },
    );
  }

  Widget _studyTimes(BuildContext context, int index, bool initial){
    
      if (initial) {
        currently[index] = info["experience"][index].ispresent == "1" ? true : false;
        
        if (info["experience"][index].jobfrom != null){
          startDateController[index].text = info["experience"][index].jobfrom;
        }
        if (info["experience"][index].jobto != null){
          endDateController[index].text = info["experience"][index].jobto;
        }
      }
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Checkbox(
              activeColor: AppColors.primaryColor,
              value: currently[index], 
              onChanged: (value){
                setState(() {
                  currently[index] = value;
                  experience[index]["currently"] = value.toString();
                });
              }
            ),
            Text('I Currently Work here',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300
              ),
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              child: TextFormField(
                // initialValue: '-- -- ----',
                controller: startDateController[index],
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'START DATE',
                  labelStyle: GoogleFonts.poppins(),
                  suffixIcon: Icon(Icons.calendar_today)
                ),
              onTap: () async {
                final date = await showDatePicker(
                  context: context, 
                  initialDate: DateTime.now(), 
                  firstDate: DateTime(1950), 
                  lastDate: DateTime(2050)
                );
                if (date != null) {
                  setState(() {
                    print(DateFormat('dd-MM-yyyy').format(date));
                    startDateController[index].text = DateFormat('MM-dd-yyyy').format(date);
                    experience[index]["startDate"] = DateFormat('MM-dd-yyyy').format(date).toString();
                    print(index);
                    print(experience[index]);
                    print('ended');
                  });
                }
              },
              ),
            ),
            SizedBox(width: 20.0,),
            currently[index] ? Container() : 
            Flexible(
              child: TextFormField(
                // initialValue: '-- -- ----',
                controller: endDateController[index],
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'END DATE',
                  labelStyle: GoogleFonts.poppins(),
                  suffixIcon: Icon(Icons.calendar_today)
                ),
              onTap: () async {
                final date = await showDatePicker(
                  context: context, 
                  initialDate: DateTime.now(), 
                  firstDate: DateTime(1950), 
                  lastDate: DateTime(2050)
                );
                if (date != null) {
                  setState(() {
                    print(DateFormat('dd-MM-yyyy').format(date));
                    endDateController[index].text = DateFormat('MM-dd-yyyy').format(date);
                    experience[index]["endDate"] = DateFormat('MM-dd-yyyy').format(date).toString();
                  });
                }
              },
              ),
            ) 
          ],
        )
      ],
    );
  }

  Widget _button(){
    return Container(
      width: double.infinity,
      height: 50.0,
      child: FlatButton(
        onPressed: 
        () async {
          print('pressed create');
          
          print(profileData);
          print(experience);
          print(education);

          
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context){
              return LoadingDialog();
            }
          );

          var respProfile;
          var respEdu = {'response' : "Education added/updated succesfully"};
          var respExp = {'response' : "Experience added/updated succesfully"};

          if (info["hasCv"]){
            respProfile = await cvProvider.updateBasicCv(profileData,image:pickedFile);
          } else {
            print("addcv");
            respProfile = await cvProvider.addBasicCv(profileData, pickedFile);
          }
          print(respProfile);

          for (var item in education.entries) {
            var v = item.value;

            if (v["id"] != ''){
              var resp = await cvProvider.updateEducation(v);
              if (resp['responseMessage'] == 'ERROR') respEdu['response'] = 'Error on Education API:'+resp['response'];
            } else if (v["id"] == '' && v["education"]=='' && v["college"]==''){
              print("exclude");
            }else {
              var resp = await cvProvider.addEducation(v);
              if (resp['responseMessage'] == 'ERROR') respEdu['response'] = 'Error on Education API:'+resp['response'];
            }

          }
          
          for (var item in education.entries) {
            var v = item.value;

            if (v["id"] != ''){
              var resp = await cvProvider.updateExperience(v);
              if (resp['responseMessage'] == 'ERROR') respExp['response'] = 'Error on Experience API:'+resp['response'];
            } else if (v["id"] == '' && v["title"]=='' && v["company"]==''){
              print("exclude");
            }else {
              var resp = await cvProvider.addExperience(v);
              if (resp['responseMessage'] == 'ERROR') respExp['response'] = 'Error on Experience API:'+resp['response'];
            }
          }

          Navigator.pop(context);

          await showDialog(
            context: context,
            builder: (BuildContext context){
              return ErrorDialog(message: respProfile['response']+'\n\n'+respEdu['response']+'\n\n'+respExp['response']);
            }
          );

          Navigator.pop(context);
        
        }, 

        child: Text('Create My Resume',
          style: GoogleFonts.poppins(
            fontSize: 20.0
          ),
        ),
        textColor: Colors.white,
        color: AppColors.primaryColor,
      ),
    );
  }
}
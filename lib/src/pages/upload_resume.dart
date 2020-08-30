import 'package:flutter/material.dart';
import 'dart:io';

import 'package:dashed_container/dashed_container.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:hiring_open/src/providers/cv_provider.dart';
import 'package:hiring_open/src/values/values.dart';
import 'package:hiring_open/src/widgets/errordialog.dart';
import 'package:hiring_open/src/widgets/loading.dart';

class UploadResume extends StatefulWidget {
  @override
  _UploadResumeState createState() => _UploadResumeState();
}

class _UploadResumeState extends State<UploadResume> {

  Map<String, dynamic> profileData = new Map();
  final picker = ImagePicker();
  PickedFile pickedFile;
  final cvProvider = new CVProvider();
  File file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Navigator.canPop(context) ? IconButton(
          icon: Icon(Icons.keyboard_arrow_left, size: 30.0,), 
          onPressed: () => Navigator.pop(context)
          ) : Container(),

        title: Text('Upload Resume', style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
        ),),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: _form(),),
          _button()
        ],
      )
    );
  }
  Widget _form() {
    return SingleChildScrollView(
      // controller: controller,
      child: Form(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical:10.0),
          child: Column(
            children: <Widget>[
              _image(),
              _name(),
              _email(),
              _phone(),
              _designation(),
              _address(),
              _skills(),
              _ctc(),
              _lastCompany(),
              _experience(),
              _education(),
              _noticePeriod(),
              _industry(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                alignment: Alignment.centerLeft,
                child: Text('UPLOAD RESUME (IN PDF/DOC ONLY)',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w300
                  ),
                ),
              ),
              _upload(),
              _summary(),
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

  Widget _name() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'NAME',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['name'] =  value,
    );
  }

  Widget _email() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'EMAIL ADDRESS',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['email'] =  value,
    );
  }

  Widget _phone() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'PHONE NO.',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['phone'] =  value,
    );
  }

  Widget _designation() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'DESIGNATION',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['designation'] =  value,
    );
  }

  Widget _address() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'ADDRESS',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['address'] =  value,
    );
  }

  Widget _skills() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'SKILLS',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['skills'] =  value,
    );
  }

  Widget _ctc() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'ANNUAL CTC',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['annual_ctc'] =  value,
    );
  }

  Widget _lastCompany() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'LAST COMPANY',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['last_company'] =  value,
    );
  }

  Widget _experience() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'TOTAL EXPERIENCE',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['experience'] =  value,
    );
  }

  Widget _education() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'HIGHEST EDUCATION',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['education'] =  value,
    );
  }

  Widget _noticePeriod() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'NOTICE PERIOD',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['notice_period'] =  value,
    );
  }

  Widget _industry() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'INDUSTRY',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['industry'] =  value,
    );
  }

  Widget _upload(){
    return GestureDetector(
      onTap: () async {
        file = await FilePicker.getFile(allowedExtensions: ['pdf', 'doc']);
      },
      child: DashedContainer(
        borderRadius: 20.0,
        dashedLength: 3.0,
        blankLength: 2.0,
        strokeWidth: 1,     
        child: Container(
          height: 90.0,
          width: 200.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Image.asset('assets/icons/upload.png'),
          ),
        )
      ),
    );
  }

  Widget _summary() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'PROFILE SUMMARY',
        labelStyle: GoogleFonts.poppins()
      ),
      onChanged: (value) => profileData['profile_summary'] =  value
    );
  }

  Widget _button(){
    return Row(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.498,
          height: 50.0,
          child: FlatButton(
            onPressed: (){}, 
            child: Text('Preview & Download Resume',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14.0
              ),
            ),
            textColor: Colors.white,
            color: AppColors.primaryColor,
          ),
        ),
        Spacer(),
        Container(
          width: MediaQuery.of(context).size.width * 0.498,
          height: 50.0,
          child: FlatButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext context){
                  return LoadingDialog();
                }
              );
              final resp = await cvProvider.updateBasicCv(profileData, cv: file, image: pickedFile );
              Navigator.pop(context);
             
              await showDialog(
                context: context,
                builder: (BuildContext context){
                  return ErrorDialog(message: resp["responseMessage"]);
                }
              );
              Navigator.pop(context);
              
            }, 
            child: Text('Update',
              style: GoogleFonts.poppins(
                fontSize: 20.0
              ),
            ),
            textColor: Colors.white,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }

}
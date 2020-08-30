import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:dashed_container/dashed_container.dart';

import 'package:hiring_open/src/models/education_model.dart';
import 'package:hiring_open/src/models/experience_model.dart';
import 'package:hiring_open/src/providers/cv_provider.dart';
import 'package:hiring_open/src/values/values.dart';
import 'package:hiring_open/src/widgets/loading.dart';


class PostResumePage extends StatelessWidget {

  final cvProvider = new CVProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.tertiaryBackground,
      appBar: AppBar(
        leading: Navigator.canPop(context) ? IconButton(
          icon: Icon(Icons.keyboard_arrow_left, size: 30.0,), 
          onPressed: () => Navigator.pop(context)
          ) : Container(),

        title: Text('Post Resume', style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
        ),),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 40.0),
            Text('Current Resume',
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
              fontSize: 20.0,
              fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height:25.0),
            _currentResume(context),
            SizedBox(height: 40.0),
            Text('Add New Resume',
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
              fontSize: 20.0,
              fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height:5.0),
            _uploadResume(context),
            _createResume(context),
            SizedBox(height:10.0),
          ]
      ),
        ),
    ),
    );
  }

  Widget _currentResume(BuildContext context){
    return FutureBuilder(
      future: cvProvider.basicCvUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final cv = snapshot.data;
          return Container(
              height: 110.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white
               ),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    padding: EdgeInsets.only(top:30.0, left: 15.0),
                    child: Text(cv.name,
                        style: GoogleFonts.poppins(
                          fontSize: 18.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    padding: EdgeInsets.only(left:15.0),
                    child: Text('Last Updated on '+ DateFormat('dd-MMMM-yyyy').format(cv.lastcvdatetime ?? cv.createddatetime).toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w200
                        ),
                        overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            );
        } else {
          return Container(
              height: 110.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white
               ),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    padding: EdgeInsets.only(top:30.0, left: 15.0),
                    child: Text('No CV Found',
                        style: GoogleFonts.poppins(
                          fontSize: 18.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    padding: EdgeInsets.only(left:15.0),
                    child: Text('',
                        style: GoogleFonts.poppins(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w200
                        ),
                        overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            );
        }
      },
    );
  }

  Widget _uploadResume(BuildContext context ){
    return GestureDetector(
      onTap: () async {
        bool hasCv = false;
        final cv = await cvProvider.basicCvUser();
        if (cv == null){
          hasCv = false;
        } else {
          hasCv = true;
        }
        Navigator.pushNamed(context, 'uploadresume', arguments: {"hasCv" : hasCv, "cv": cv});
        },

      child: DashedContainer(
        borderRadius: 20.0,
        dashedLength: 3.0,
        blankLength: 2.0,
        strokeWidth: 1,     
        child: Container(
          height: 90.0,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ImageIcon(AssetImage('assets/icons/upload-icon.png'),size:50.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal:15.0),
                child: Text('Upload Resume',
                  style: GoogleFonts.poppins(
                    fontSize: 16.0
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _createResume(BuildContext context){
    return Container(
      width: double.infinity,
      height: 90,
      margin: EdgeInsets.only(top: 10),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        onPressed: () async{

          showDialog(
            context: context, 
            barrierDismissible: false,
            builder: (BuildContext context) {
              return LoadingDialog();
            }
          );
          bool hasCv = false;
          bool hasEdu = false;
          bool hasExp = false;
          final cv = await cvProvider.basicCvUser();
          if (cv == null){
            hasCv = false;
          } else {
            hasCv = true;
          }

          List<Education> edu = await cvProvider.educationUser();
          if (edu == null || edu.length == 0){
            hasEdu = false;
          } else {
            hasEdu = true;
          }

          List<Experience> exp = await cvProvider.experienceUser();
          if (exp == null || exp.length == 0){
            hasExp = false;
          } else {
            hasExp = true;
          }
          Navigator.pop(context);

          Map info = {
            "hasCv" : hasCv, 
            "cv": cv,
            "hasEdu" : hasEdu,
            "education" : edu, 
            "hasExp"  : hasExp,
            "experience" : exp 
          };

          Navigator.pushNamed(context, 'createresume', arguments: info);
          
        },
        disabledColor: Colors.grey,
        color: AppColors.primaryBackground,
        textColor: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ImageIcon(AssetImage('assets/icons/create-icon.png'),size:50.0),
            Container(
              width: MediaQuery.of(context).size.width*0.45,
              padding: EdgeInsets.symmetric(horizontal:15.0),
              child: Text('Create New with Hiringopen.com',
                style: GoogleFonts.poppins(
                  fontSize: 16.0
                ),
                overflow: TextOverflow.clip,
              )
            )
            ],
        )
      ),
    );
  }
}
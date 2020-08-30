import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:hiring_open/src/models/job_model.dart';
import 'package:hiring_open/src/providers/job_provider.dart';
import 'package:hiring_open/src/values/values.dart';
import 'package:hiring_open/src/widgets/errordialog.dart';
import 'package:hiring_open/src/widgets/loading.dart';



class JobDetailsPage extends StatefulWidget {
  @override
  _JobDetailsPageState createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {


  final jobProvider = JobProvider();

  @override
  Widget build(BuildContext context) {

    final Job job = ModalRoute.of(context).settings.arguments;

    if (job == null) {Navigator.pop(context);} 
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, size: 30.0,), 
          onPressed: () => Navigator.pop(context)
          ),
        title: Text('Job Details', style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
        ),),
        centerTitle: true,
        backgroundColor: AppColors.tertiaryBackground,
        elevation: 0.0,
        
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _title(job),
                  _company(job),
                  _body(job)
                ],
              ),
            )
          ),
          _button(job)
        ],
      )

    );
  }

  Widget _title(Job job) {
    return Container(
      // height: 140.0,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width*0.75,
                padding: EdgeInsets.only(left:20.0, top:20.0, bottom: 20.0),
                alignment: Alignment.centerLeft,
                child: Text(job.title??'', style: GoogleFonts.poppins(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500
                  ),
                  overflow: TextOverflow.clip,
                ),
              ),
              Spacer(),
              IconButton(
                icon: ImageIcon(AssetImage('assets/icons/save-job.png'),
                  color: AppColors.primaryColor,
                ), 
                onPressed: () async {
                  final resp = await jobProvider.saveJob(job.jobpostid);
                  if (resp['responseMessage'] == 'ERROR'){
                    await showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return ErrorDialog(message: resp['response']);
                      }
                    );
                  } else {
    
                    await showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return ErrorDialog(message: "Job Saved!");
                      }
                    );
                  }
                }
              )
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:20.0, right:10.0),
                child: Image.asset('assets/icons/post-date.png',height: 20.0,),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Text('Posted: '+job.createddatetime.toString().substring(0,10)??'', 
                style: GoogleFonts.poppins(),
                overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
  
  Widget _company(Job job){
    return Container(
      color: AppColors.tertiaryBackground,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 15.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text('  '+job.company??'', style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500
            ),
            overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  Widget _body(Job job) {
    return Container(
      color: Colors.white,
      
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left:20.0, top:20.0, bottom: 20.0),
            alignment: Alignment.centerLeft,
            child: Text('Overview', style: GoogleFonts.poppins(
              fontSize: 18.0,
              fontWeight: FontWeight.w500
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left:20.0, bottom: 5.0),
            alignment: Alignment.centerLeft,
            child: Text('Job Summary', style: GoogleFonts.poppins(
              fontSize: 16.0,
              fontWeight: FontWeight.w500
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ), 
          Container(
            padding: EdgeInsets.only(left:20.0, bottom: 15.0),
            alignment: Alignment.centerLeft,
            child: Html(data: job.jobsummary??'')
            // Text(job.jobsummary, style: GoogleFonts.poppins(
            //   fontSize: 16.0,
            //   fontWeight: FontWeight.normal
            //   ),
            //   overflow: TextOverflow.clip,
            // ),
          ), 
          Container(
            padding: EdgeInsets.only(left:20.0, bottom: 15.0),
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                    ),
                children: <TextSpan> [
                  TextSpan(text: 'Industry Type : '),
                  TextSpan(text: job.industrytype??'',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.normal
                    )
                  )
                ]
              )
            )
          ), 
          Container(
            padding: EdgeInsets.only(left:20.0, bottom: 15.0),
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                    ),
                children: <TextSpan> [
                  TextSpan(text: 'Job Type : '),
                  TextSpan(text: job.jobtype??'',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.normal
                    )
                  )
                ]
              )
            )
          ),  
          Container(
            padding: EdgeInsets.only(left:20.0, bottom: 15.0),
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                    ),
                children: <TextSpan> [
                  TextSpan(text: 'Employer Type : '),
                  TextSpan(text: job.employertype??'',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.normal
                    )
                  )
                ]
              )
            )
          ), 
          Container(
            padding: EdgeInsets.only(left:20.0, bottom: 10.0),
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                    ),
                children: <TextSpan> [
                  TextSpan(text: 'Experience : '),
                  TextSpan(text: job.expyear??''+' years(min)',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.normal
                    )
                  )
                ]
              )
            )
          ),          
        ],
      ),
    );
  }

  Widget _button(Job job){
    return Container(
        width: double.infinity,
        height: 50.0,
        child: FlatButton(
          onPressed: () async {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context){
                return LoadingDialog();
              }
            );
            final resp = await jobProvider.applyJob(job.jobpostid);
            Navigator.pop(context);
            await showDialog(
              context: context,
              builder: (BuildContext context){
                return ErrorDialog(message: resp['response']);
              }
            );
            Navigator.pop(context);
          }, 
          child: Text('Apply Now',
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
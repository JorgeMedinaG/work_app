import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:hiring_open/src/models/job_model.dart';
import 'package:hiring_open/src/providers/job_provider.dart';
import 'package:hiring_open/src/values/values.dart';


class AppliedJobsPage extends StatefulWidget {
  @override
  _AppliedJobsPageState createState() => _AppliedJobsPageState();
}

class _AppliedJobsPageState extends State<AppliedJobsPage> {

  final jobProvider = JobProvider();
  @override
  void initState() {
    super.initState();
    jobProvider.appliedJobs();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.tertiaryBackground,
      appBar: AppBar(
        leading: Navigator.canPop(context) ? IconButton(
          icon: Icon(Icons.keyboard_arrow_left, size: 30.0,), 
          onPressed: () => Navigator.pop(context) 
          ) : Container(),
        title: Text('Applied Jobs', style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
        ),),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        
      ),
      body: SafeArea(
        child: _jobList()
      ),
    );
  }

  Widget _jobList(){

    return StreamBuilder(
      stream: jobProvider.savedJobStream,
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

  Widget _card(StoredJob storedJob){

    final size = MediaQuery.of(context).size;
    double fontsize;
    if (size.width < 400.0){
      fontsize = size.width * 0.048;
    } else {
      fontsize = 20;
    }

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'jobdetail', arguments: storedJob.job),
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
              child: Text(storedJob.jobtitle, style: GoogleFonts.poppins(
                fontSize: fontsize,
                fontWeight: FontWeight.w500
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(storedJob.company, style: GoogleFonts.poppins(
                        fontSize: fontsize-4,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right:10.0),
                    child: Image.asset('assets/icons/location-icon.png',height: 20.0,),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Text(storedJob.location, 
                        style: GoogleFonts.poppins(
                          fontSize: fontsize-6,
                        ),
                        overflow: TextOverflow.ellipsis,
                      )  
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.only(right:15.0),
                    height: 25.0,
                    width: 105.0,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ), 
                      child: Text('Applied', style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                      ),),
                      color: AppColors.primaryColor,
                      textColor: Colors.white,
                      onPressed: (){},
                      ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 10.0, right: 25.0),
              child: Row(
               children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.only(right:10.0),
                   child: Image.asset('assets/icons/post-date.png',height: 20.0,),
                 ),
                 Container(
                   width: MediaQuery.of(context).size.width * 0.45,
                   child: Text('Response On: '+storedJob.createddatetime.toString().substring(0,10), 
                      style: GoogleFonts.poppins(
                        fontSize: fontsize-6,
                      ),
                      overflow: TextOverflow.ellipsis,
                   )                
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
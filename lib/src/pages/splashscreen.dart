
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hiring_open/src/providers/user_provider.dart';
import 'package:hiring_open/src/utils/user_preferences.dart';
//import 'dart:async';

class SplashScreen extends StatefulWidget {


  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  final UserPreferences prefs = new UserPreferences();
  final UserProvider userProvider = new UserProvider();

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {

    // final resp = await userProvider.login(prefs.email, prefs.password);

    // if (resp['responseMessage'] == 'SUCCESS'){
    if (prefs.email != '' && prefs.password != '' || prefs.userID != 0){
      Navigator.pushReplacementNamed(context, 'nav');
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }

  @override
  void initState() {
  super.initState();
  startTime();
}
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255) ,
      body: Center (
        child: Container(
          width: MediaQuery.of(context).size.width * 0.70,
          child: Image.asset('assets/img/logo.png')
        ),
        ),
    ); 
  }

}
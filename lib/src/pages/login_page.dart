import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hiring_open/src/bloc/provider.dart';
import 'package:hiring_open/src/providers/user_provider.dart';
import 'package:hiring_open/src/utils/user_preferences.dart';
import 'package:hiring_open/src/values/values.dart';
import 'package:hiring_open/src/widgets/button_widget.dart';
import 'package:hiring_open/src/widgets/errordialog.dart';
import 'package:hiring_open/src/widgets/loading.dart';
import 'package:hiring_open/src/widgets/topbar_widget.dart';


class LoginPage extends StatelessWidget {
  
 @override
  Widget build(BuildContext context) {
  
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;
    final userProvider = UserProvider();
    final prefs = UserPreferences(); 

    print('Height: ${size.height}');
    print('Width: ${size.width}');

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
                  TopBar(title: 'SIGN IN', graybar: true,),
                  SizedBox(height: 50.0),
                  _topText(size),
                  SizedBox(height: 50.0),
                  _emailField(bloc),
                  _passwordField(bloc),
                  _forgotPassword(context, size),
                  _button(context, userProvider, bloc, prefs),
                  SizedBox(height: 30.0),
                  _signWith(size),
                  SizedBox(height: 30.0 ),
                  _socialMediaLogin(),
                  SizedBox(height: 40.0),
                  _bottomText(context, size)
                ],
          ),
        ),
      ),
    );
  }

  Widget _topText(Size size) {

    double fontsize;
    if (size.width < 400.0){
      fontsize = size.width * 0.048;
    } else {
      fontsize = 20;
    }

    return Container(
      alignment: Alignment.center,
      child: Text('Sign in with Hiringopen.com',
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: fontsize
        )
      ),
    );
    
  }

  Widget _emailField(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.emailStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 15.0),
          child: TextField(
            style: GoogleFonts.poppins(),
              decoration: InputDecoration(
                labelText: 'EMAIL ADDRESS',
                // counterText: snapshot.data,
                errorText: snapshot.error 
              ),
              
              onChanged: (value) => bloc.changeEmail(value),
            ),
        );
       },
    );
  }

  Widget _passwordField(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
          return Container(
            margin: EdgeInsets.symmetric(vertical: 15.0),
            child: TextField(
              obscureText: true,
              style: GoogleFonts.poppins(),
              decoration: InputDecoration(
                labelText: 'PASSWORD',
                errorText: snapshot.error
              ),
              onChanged: (value) => bloc.changePassword(value),
            ),
          );
        },
    );


  }

  Widget _forgotPassword(BuildContext context, Size size) {

    double fontsize;
    if (size.width < 400.0){
      fontsize = size.width * 0.048;
    } else {
      fontsize = 20;
    }

    return Container(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, 'forgetpass'),
        child: Text('Forgot Password?',
          style: GoogleFonts.poppins(
            color: AppColors.primaryBackground,
            fontSize: fontsize,
            fontWeight: FontWeight.w500
          )
        )
      ),
    );
  }

  Widget _button(BuildContext context, UserProvider userProvider, LoginBloc bloc, UserPreferences prefs) {
    
    return StreamBuilder(
      stream: bloc.validLogin,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return CustomButton(text: 'SIGN IN', onPressed: snapshot.hasData ? () => _loginButton(context, userProvider, bloc, prefs) : null);
      },
    );
  }

  Widget _signWith(Size size){

    double fontsize;
    if (size.width < 400.0){
      fontsize = size.width * 0.048;
    } else {
      fontsize = 20;
    }

    return Container(
      alignment: Alignment.center,
      child: Text('Or Sign in with',
        style: GoogleFonts.poppins(
          color: AppColors.secondaryText,
          fontWeight: FontWeight.w500,
          fontSize: fontsize         
        ),
      ),
    );
  }

  Widget _socialMediaLogin(){

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 50.0,
          child: MaterialButton(
            child: Image.asset('assets/img/google.png'),
            onPressed: (){}
          )      
        ),
        Container(
          height: 50.0,
          child: MaterialButton(
            child: Image.asset('assets/img/facebook.png'),
            onPressed: (){}
          )         
        ),
        Container(
          height: 50.0,
          child: MaterialButton(
            child: Image.asset('assets/img/linkedin.png'),
            onPressed: (){}
          )  
          
          
        )
      ],
    );

  }

  Widget _bottomText(BuildContext context, Size size){

    double fontsize;
    if (size.width < 400.0){
      fontsize = size.width * 0.048;
    } else {
      fontsize = 20;
    }
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('New to Hiringopen.com ? ',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: fontsize,
              fontWeight: FontWeight.w500
            ),
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, 'signup'),
            child: Text('Join Now',
              style: GoogleFonts.poppins(
                color: AppColors.primaryBackground,
                fontSize: fontsize,
                fontWeight: FontWeight.bold,
              ),
            ),

          )
        ]
    );
  }

  _loginButton(BuildContext context, UserProvider userProvider, LoginBloc bloc, UserPreferences prefs) async {

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoadingDialog();
        }
    );

    final resp = await userProvider.login(bloc.email, bloc.password);
    print(resp);

    if (resp['responseMessage'] == 'SUCCESS'){
      
      prefs.email = bloc.email;
      prefs.password = bloc.password;
      prefs.userID = resp['response']['userid'];
      prefs.userInformation = json.encode(resp['response']);
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, 'nav');

    } else if (resp['responseMessage'] == 'ERROR') {
      Navigator.pop(context);
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ErrorDialog(message: resp['response']);
        }
      );
      
      print('Invalid User');
    }

  }


}
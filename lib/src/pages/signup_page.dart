import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hiring_open/src/bloc/provider.dart';
import 'package:hiring_open/src/providers/user_provider.dart';
import 'package:hiring_open/src/values/values.dart';
import 'package:hiring_open/src/widgets/button_widget.dart';
import 'package:hiring_open/src/widgets/errordialog.dart';
import 'package:hiring_open/src/widgets/loading.dart';
import 'package:hiring_open/src/widgets/topbar_widget.dart';



class SignUpPage extends StatefulWidget {
  
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  String segvalue = 'jobseeker';
  @override
  Widget build(BuildContext context) {
  
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;
    final userProvider = UserProvider();

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
                TopBar(title: 'SIGN UP', graybar: true),
                SizedBox(height: 50.0),
                _segmentControl(),
                SizedBox(height: 10.0),
                _nameField(bloc),
                _emailField(bloc),
                _mobileField(bloc),
                _passwordField(bloc),
                _button(context,userProvider, bloc),
                SizedBox(height: 20.0),
                _signWith(size),
                SizedBox(height: 20.0 ),
                _socialMediaLogin(),
                SizedBox(height: 30.0),
                _bottomText(context, size)

              ],
                ),
        ),
      ),
    );
  }

  Widget _segmentControl(){ 
    return Container(
      padding: EdgeInsets.symmetric(horizontal:50.0),
      child: MaterialSegmentedControl(
          children: {
            'jobseeker' : Text('Job Seeker', style: GoogleFonts.poppins(
              color: segvalue == 'jobseeker' ? Colors.white : Colors.black,
              fontSize: 14.0
            ),),
            'jobfinder' : Text('Job Provider', style: GoogleFonts.poppins(
              color: segvalue == 'jobfinder' ? Colors.white : Colors.black,
              fontSize: 14.0
            ),)
          },
          selectionIndex: segvalue,
          borderColor: Colors.grey,
          selectedColor: AppColors.primaryColor,
          unselectedColor: Colors.grey,
          borderRadius: 32.0,
          // disabledChildren: [
          //   3,
          // ],
          onSegmentChosen: (index) {
            setState(() {
              segvalue = index;
            });
          },
         ),
    );
  }

  Widget _nameField(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.nameStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          child: TextField(
              style: GoogleFonts.poppins(),
              decoration: InputDecoration(
                labelText: 'FULL NAME',
                // counterText: snapshot.data,
                errorText: snapshot.error 
              ),
              
              onChanged: (value) => bloc.changeName(value),
            ),
        );
       },
    );
  }

  Widget _emailField(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.emailStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
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

  Widget _mobileField(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.mobileStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          child: TextField(
              keyboardType: TextInputType.number,
              style: GoogleFonts.poppins(),
              decoration: InputDecoration(
                labelText: 'MOBILE NO.',
                // counterText: snapshot.data,
                errorText: snapshot.error 
              ),
              onChanged: (value) => bloc.changeMobile(value),
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
            margin: EdgeInsets.symmetric(vertical: 5.0),
            child: TextField(
              style: GoogleFonts.poppins(),
              obscureText: true,
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

  Widget _button(BuildContext context, UserProvider userProvider, LoginBloc bloc) {
    
    return StreamBuilder(
      stream: bloc.validSignUp,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return CustomButton(text: 'SIGN UP', onPressed: snapshot.hasData ? () => _signup(context, userProvider, bloc) : null);
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
      child: Text('Or Sign Up with',
        style: GoogleFonts.poppins(
          color: AppColors.secondaryText,
          fontWeight: FontWeight.w500,
          fontSize: fontsize,          
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Already Have an Account ? ',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: fontsize,
            fontWeight: FontWeight.w500
          ),
        ),
        InkWell(
          onTap: () => Navigator.pushNamed(context, 'login'),
          child: Text('Sign In',
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

  void _signup(BuildContext context,UserProvider userProvider, LoginBloc bloc) async {

    print(bloc.emailStream);
    print(bloc.name);
    print(bloc.mobile);
    print(bloc.password);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoadingDialog();
        }
    );

    final otp = await userProvider.emailOtp(bloc.email);
    print(otp);
    Navigator.pop(context); //Closing Dialog

    if (otp['responseMessage'] == 'SUCCESS'){
      final int otpCode = otp['response']['otp'];
      Navigator.pushReplacementNamed(context, 'otp', arguments: {'otpcode' :otpCode,'type' :'verify'});
    } else {
      print('Couldnt sent otp');
      await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ErrorDialog(message: "Couldn't send OTP: "+otp['response']);
        }
      );
    }
    
  }
}
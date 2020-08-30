import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import 'package:hiring_open/src/widgets/errordialog.dart';
import 'package:hiring_open/src/widgets/loading.dart';
import 'package:hiring_open/src/bloc/provider.dart';
import 'package:hiring_open/src/providers/user_provider.dart';
import 'package:hiring_open/src/values/values.dart';
import 'package:hiring_open/src/widgets/button_widget.dart';
import 'package:hiring_open/src/widgets/topbar_widget.dart';


class OTPPage extends StatefulWidget {

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  
    String pinValue ;

    @override
    Widget build(BuildContext context) {

    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;
    final userProvider = UserProvider();
    

    Map<String, dynamic> _otpinfo = ModalRoute.of(context).settings.arguments;

    print(_otpinfo);
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
                TopBar(title: 'VERIFY OTP'),
                SizedBox(height: 50.0),
                _topText(_otpinfo['type'], bloc),
                SizedBox(height: 20.0),
                _pinFields(size),
                SizedBox(height: 10.0),
                CustomButton(text: 'SUBMIT',onPressed: () => _submit(context, _otpinfo, userProvider, bloc),),
                SizedBox(height: 30.0),
                _bottomText(context,userProvider, bloc, _otpinfo),
              ],
                ),         
        ),
      ),
    );
  }

  Widget _topText(String type, LoginBloc bloc) {

    return Container(
      alignment: Alignment.centerLeft,
      child: Text(_text(type,bloc),
      textAlign: TextAlign.left,
      overflow: TextOverflow.clip,
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w400
        )
      ),
    );
    
  }

  String _text(String type, LoginBloc bloc){

    if(type == 'verify'){
      return "We have sent an OTP on ${bloc.email ?? bloc.mobile} to verify your email";
    } else if (type == 'password'){
      return "We have sent an OTP on ${bloc.email ?? bloc.mobile} to change the password";
    }

    return 'There was an error';
  }

  Widget _pinFields(Size size) {

    return OTPTextField(
      length: 4,
      width: size.width * 0.70,
      fieldWidth: 40,
      style: GoogleFonts.poppins(
        fontSize: 28
      ),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        pinValue = pin;
      },
    );
  
  }

  Widget _bottomText(BuildContext context,UserProvider userProvider, LoginBloc bloc, Map<String, dynamic> _otpinfo){

    final size = MediaQuery.of(context).size;
    double fontsize;
    if (size.width < 400.0){
      fontsize = size.width * 0.048;
    } else {
      fontsize = 20;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('If you didn’t receive OTP! ',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: fontsize,
            fontWeight: FontWeight.w400
          ),
        ),
        InkWell(
          onTap: () => _resendOtp(context,userProvider, bloc, _otpinfo),
          child: Text('Resend',
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

  void _submit(BuildContext context, Map<String, dynamic> info, UserProvider userProvider, LoginBloc bloc) async {
    
    print('Submitted');
    if (info['otpcode'].toString() != pinValue) {

        await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return ErrorDialog(message: 'OTP not valid');
          }
        );

      return;

    }

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoadingDialog();
        }
    );
    if (info['type'] == 'verify'){
        
        final resp = await userProvider.signUp(bloc.name, bloc.password, 1, 0, bloc.email, bloc.mobile, 'ROLE_JOBSEEKER');
        Navigator.pop(context);//Closing loading
        if (resp['responseMessage'] == 'SUCCESS'){
          Navigator.pushReplacementNamed(context, 'country');
        } else if (resp['responseMessage'] == 'ERROR') {
          await showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return ErrorDialog(message: resp['response']);
            }
          );
        }

    } else if (info['type'] == 'password'){
        Navigator.pop(context);
        Navigator.pushNamed(context, 'resetpass');

    }



  }

  void _resendOtp(BuildContext context,UserProvider userProvider, LoginBloc bloc, Map<String, dynamic> _otpinfo) async {

    print('Resend');
    if(bloc.email != null){

      final otp = await userProvider.emailOtp(bloc.email);

      print(otp);
      if (otp['responseMessage'] == 'SUCCESS'){
        _otpinfo['otpcode']= otp['response']['otp'];
      } else {
        print('Couldnt send OTP');

        await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return ErrorDialog(message: "Couldn't Send OTP");
          }
        );
      }

    } else if (bloc.mobile != null) {

      final otp = await userProvider.phoneOtp(bloc.mobile);

      print(otp);
      if (otp['responseMessage'] == 'SUCCESS'){
        _otpinfo['otpcode']= otp['response']['otp'];
      } else {
        await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return ErrorDialog(message: "Couldn't Send OTP");
          }
        );
      }

    }


  }
}
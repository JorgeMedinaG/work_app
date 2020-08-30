import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hiring_open/src/bloc/provider.dart';
import 'package:hiring_open/src/providers/user_provider.dart';
import 'package:hiring_open/src/values/values.dart';
import 'package:hiring_open/src/widgets/button_widget.dart';
import 'package:hiring_open/src/widgets/errordialog.dart';
import 'package:hiring_open/src/widgets/loading.dart';
import 'package:hiring_open/src/widgets/topbar_widget.dart';


class ForgetPasswordPage extends StatefulWidget {
  
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
    
    Color _emailColor = AppColors.primaryColor;
    Color _phoneColor = AppColors.primaryElement;
    int _value = 1; 
   
    TextEditingController textcontroller = new TextEditingController();

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
                TopBar(title: 'FORGOT PASSWORD'),
                SizedBox(height: 50.0),
                _topText(),
                SizedBox(height: 15.0),
                _options(),
                SizedBox(height: 5.0),
                _inputField(bloc, textcontroller),
                CustomButton(text: 'SEND',onPressed: () => _send(context,userProvider,bloc ),),
              ],
                ),         
        ),
      ),
    );
  }

  Widget _topText() {

    return Container(
      alignment: Alignment.center,
      child: Text("Enter your email address or phone\nnumber below and we will send you otp\nto change your password",
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w400
        )
      ),
    );
    
  }

  Widget _options() {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          value: 1,
          groupValue: _value, 
          activeColor: AppColors.primaryColor,
          onChanged: (value) {
            setState(() {
              _value = 1;
              _emailColor = AppColors.primaryColor;
              _phoneColor = AppColors.primaryElement;
            });
          }, 
        ),
        Text('EMAIL',
          style: GoogleFonts.poppins(
            color: _emailColor,
          ),
        ),
        Radio(
          value: 2,
          groupValue: _value,            
          activeColor: AppColors.primaryColor,
          onChanged: (value) {
            setState(() {
              _value = 2;
              _emailColor = AppColors.primaryElement;
              _phoneColor = AppColors.primaryColor;
            });
          },
        ),
        Text('PHONE',
          style: GoogleFonts.poppins(
            color: _phoneColor
          ),
        )
      ],
      );

  }

  Widget _inputField(LoginBloc bloc, TextEditingController textcontroller) {

    if (_value == 1) {

      return _emailField(bloc,textcontroller);
    } else {
        
      return _mobileField(bloc,textcontroller);
    } 

  }

  Widget _emailField(LoginBloc bloc, TextEditingController textcontroller) {

    return StreamBuilder(
      stream: bloc.emailStream ,
      // initialData: '',
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 15.0),
          child: TextField(
            // initialValue: '',
            // controller: textcontroller,
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

  Widget _mobileField(LoginBloc bloc, TextEditingController textcontroller) {

    return StreamBuilder(
      stream: bloc.mobileStream ,
      // initialData: '',
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 15.0),
          child: TextField(
              // initialValue: '',
              // controller: textcontroller,
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

  void _send(BuildContext context,UserProvider userProvider, LoginBloc bloc) async {
    
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoadingDialog();
        }
    );
    
    //Using Email
    if (_value == 1) {

      print(bloc.email);
      final otp = await userProvider.emailOtp(bloc.email);
      Navigator.pop(context);//Cloasing Loading

      if (otp['responseMessage'] == 'SUCCESS'){
        final int otpCode = otp['response']['otp'];
        Navigator.pushNamed(context, 'otp', arguments: {'otpcode' :otpCode,'type' :'password'});
      
      } else {

        await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return ErrorDialog(message: "Couldn't Send OTP: "+otp['response']);
          }
        );
      }     
    //Using phone number 
    } else if (_value == 2){

      print(bloc.mobile);
      final otp = await userProvider.phoneOtp(bloc.mobile);
      Navigator.pop(context); //Closing Loading
      if (otp['responseMessage'] == 'SUCCESS'){

        final int otpCode = otp['response']['otp'];
        Navigator.pushNamed(context, 'otp', arguments: {'otpcode' :otpCode,'type' :'password'});
      
      } else {
        print(otp);

        await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return ErrorDialog(message: "Couldn't Send OTP: "+otp['response']);
          }
        );
        
      }   
    }

  }
}

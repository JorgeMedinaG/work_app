import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:hiring_open/src/bloc/provider.dart';
import 'package:hiring_open/src/providers/user_provider.dart';
import 'package:hiring_open/src/widgets/button_widget.dart';
import 'package:hiring_open/src/widgets/errordialog.dart';
import 'package:hiring_open/src/widgets/loading.dart';
import 'package:hiring_open/src/widgets/topbar_widget.dart';


class ResetPasswordPage extends StatelessWidget {
  
  void onViewPressed(BuildContext context) {
  
  }
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
                TopBar(title: 'RESET PASSWORD'),
                SizedBox(height: 70.0),
                _topText(),
                SizedBox(height: 50.0),
                _passwordField(bloc),
                _passwordField2(bloc),
                CustomButton(text: 'SUBMIT', onPressed: () => _submit(context,bloc,userProvider),),
              ],
                ),
              
           
          
        ),
      ),
    );
  }

  Widget _topText() {

    return Container(
      alignment: Alignment.centerLeft,
      child: Text('Please enter the new password',
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 20
        )
      ),
    );
    
  }

  Widget _passwordField(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.newPasswordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: TextField(
              obscureText: true,
              style: GoogleFonts.poppins(),
              decoration: InputDecoration(
                labelText: 'ENTER NEW PASSWORD',
                errorText: snapshot.error
              ),
              onChanged: (value) => bloc.changeNewPassword(value)
            ),
          );
        },
    );


  }

  Widget _passwordField2(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.newPassword2Stream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: TextField(
              obscureText: true,
              style: GoogleFonts.poppins(),
              decoration: InputDecoration(
                labelText: 'RE-ENTER NEW PASSWORD',
                errorText: snapshot.error
              ),
              onChanged: (value) => bloc.changeNewPassword2(value),
            ),
          );
        },
    );


  }

  void _submit(BuildContext context, LoginBloc bloc, UserProvider userProvider) async {

    print(bloc.newPassword);
    print(bloc.newPassword2);

    if (bloc.newPassword == bloc.newPassword2){
      
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return LoadingDialog();
            }
        );

        final resp = await userProvider.changePassword(bloc.email, bloc.newPassword);
        print(resp);

        if (resp['responseMessage'] == 'SUCCESS'){
          
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, 'login');

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

      Navigator.pushReplacementNamed(context, 'home');
    } else {
      await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ErrorDialog(message: "Passwords doesn't match");
        }
      );
    }

  }

}






 
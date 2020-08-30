import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:hiring_open/src/bloc/validators.dart';


class LoginBloc with Validators {

  final _emailController        = BehaviorSubject<String>();
  final _passwordController     = BehaviorSubject<String>();
  final _nameController         = BehaviorSubject<String>();
  final _mobileController       = BehaviorSubject<String>();
  final _newpasswordController  = BehaviorSubject<String>();
  final _newpassword2Controller = BehaviorSubject<String>();
  final _profilecvController        = BehaviorSubject<Map<String, dynamic>>();

  Function(String) get changeEmail        => _emailController.sink.add;
  Function(String) get changePassword     => _passwordController.sink.add;
  Function(String) get changeName         => _nameController.sink.add;
  Function(String) get changeMobile       => _mobileController.sink.add;
  Function(String) get changeNewPassword  => _newpasswordController.sink.add;
  Function(String) get changeNewPassword2 => _newpassword2Controller.sink.add;
  Function(Map<String, dynamic>) get changeProfilecv => _profilecvController.sink.add;

  Stream<String> get emailStream        => _emailController.stream.transform(emailValidate); 
  Stream<String> get passwordStream     => _passwordController.stream.transform(passwordValidate);
  Stream<String> get nameStream         => _nameController.stream;
  Stream<String> get mobileStream       => _mobileController.stream.transform(mobileValidate);
  Stream<String> get newPasswordStream  => _newpasswordController.stream.transform(passwordValidate);
  Stream<String> get newPassword2Stream => _newpassword2Controller.stream.transform(passwordValidate);
  Stream<Map<String, dynamic>> get profilecvStream => _profilecvController.stream;

  Stream<bool> get validLogin => CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true);
  Stream<bool> get validSignUp => CombineLatestStream.combine4(emailStream, passwordStream, nameStream, mobileStream, (e, p, n, m) => true);

  get email        => _emailController.value;
  get password     => _passwordController.value;
  get name         => _nameController.value;
  get mobile       => _mobileController.value;
  get newPassword  => _newpasswordController.value;
  get newPassword2 => _newpassword2Controller.value;
  get profilecv    => _profilecvController.value;

  

  void dispose(){
    _emailController?.close();
    _passwordController?.close();
    _nameController?.close();
    _mobileController?.close();
    _newpasswordController?.close();
    _newpassword2Controller?.close();
    _profilecvController?.close();
  }

}







import 'dart:async';

class Validators {

  final emailValidate = StreamTransformer<String, String>.fromHandlers(
    handleData: ( email, sink ) {


      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp   = new RegExp(pattern);

      if ( regExp.hasMatch( email ) ) {
        sink.add( email );
      } else {
        sink.addError('Email not valid');
      }

    }
  );

  final passwordValidate = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {

      if (password.length > 2){
        sink.add( password ); 
      } else {
        sink.addError('Less than 2 characters');
      }

    }
  );

  final mobileValidate = StreamTransformer<String, String>.fromHandlers(
    handleData: (mobile, sink){

      final parsedNumber = int.tryParse(mobile);

      if (parsedNumber == null){
        sink.addError('Not Valid Number');
      } else {
        sink.add(mobile);
      }

    }
  );
}
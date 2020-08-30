import 'package:flutter/material.dart';

import 'package:hiring_open/src/bloc/login_bloc.dart';
export 'package:hiring_open/src/bloc/login_bloc.dart';


class Provider extends InheritedWidget {
  // Provider({Key key, this.child}) : super(key: key, child: child);

  // final Widget child;
  // final loginBloc = LoginBloc();

  static Provider _instancia;

  factory Provider({ Key key, Widget child }) {

    if ( _instancia == null ) {
      _instancia = new Provider._internal(key: key, child: child );
    }

    return _instancia;

  }

  Provider._internal({ Key key, Widget child })
    : super(key: key, child: child );


  final loginBloc = LoginBloc();

    static LoginBloc of ( BuildContext context ){
      return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
    } 

  @override
  bool updateShouldNotify( Provider oldWidget) {
    return true;
  }
}
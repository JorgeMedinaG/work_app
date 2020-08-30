import 'package:flutter/material.dart';


class LoadingDialog extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        height: 100.0,
        child: Center(
          child: CircularProgressIndicator()
        ),
      ),
    );
  }
}


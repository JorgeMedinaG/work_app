import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ErrorDialog extends StatelessWidget {

  final String message;

  ErrorDialog({@required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          title: Text(message, 
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context), 
              child: Text('Ok',
                style: GoogleFonts.poppins(
                  fontSize: 18.0
                ),
              )
              )
          ],
        );
  }
}


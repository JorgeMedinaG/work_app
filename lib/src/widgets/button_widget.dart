import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiring_open/src/values/values.dart';

class CustomButton extends StatelessWidget {

  final String text;
  final Function onPressed;
  
  CustomButton({@required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {

    double fontsize;
    final size = MediaQuery.of(context).size;
    if (size.width < 400.0){
      fontsize = size.width * 0.05;
    } else {
      fontsize = 22;
    }
    return Container(
          width: double.infinity,
          height: 62,
          margin: EdgeInsets.only(top: 21),
          child: FlatButton(
            onPressed: onPressed,
            disabledColor: Colors.grey,
            color: AppColors.primaryBackground,
            textColor: Color.fromARGB(255, 255, 255, 255),
            child: Text(
              text,
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                color: AppColors.accentText,
                fontWeight: FontWeight.w700,
                fontSize: fontsize,
              ),
            ),
          ),
        );
  }
}
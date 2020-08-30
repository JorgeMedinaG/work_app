import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiring_open/src/values/values.dart';

class TopBar extends StatelessWidget {

  final bool graybar; 
  final String title;
  final bool backButton;

  TopBar({this.graybar = false, @required this.title, this.backButton = true});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    double fontsize;
    if (size.width < 400.0){
      fontsize = size.width * 0.063;
    } else {
      fontsize = 26;
    }
    return Row(
      children: <Widget>[
          _backButton(context),
          Container(
            alignment: Alignment.bottomCenter,
              // width: 281,
              margin: EdgeInsets.only(left: 7.0),
              child: Text(title,
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  color: AppColors.secondaryText,
                  fontWeight: FontWeight.w500,
                  fontSize: fontsize,
                ),
              ),
          ),
          Spacer(),
          _grayBar(size)
      ],
    );
    

  }

  Widget _backButton(BuildContext context){

    if (backButton){
      if (Navigator.canPop(context)){
        return IconButton(
          highlightColor: Color.fromARGB(255, 255, 255, 255),
          hoverColor: Color.fromARGB(255, 255, 255, 255),
          splashColor: Color.fromARGB(255, 255, 255, 255),
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(2.0),
          icon: Icon(Icons.navigate_before,
            size: 42.0,
          ), 
          onPressed: () {
            Navigator.pop(context);
          }
        );
      } else {
        return Container(width: 20.0,);
      }
    } else {
      return Container(width: 20.0,);
    }
  }

  Widget _grayBar(Size size){
    if (graybar){
      return Padding(
        padding: EdgeInsets.only(top:2.0),
        child: Container(
          width: size.width * 0.42,
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.secondaryElement,
            // border: Border.fromBorderSide(Borders.primaryBorder),
          ),
          child: Container(),
        ),
      );
    } else {
      return Container();
    }
  }
}
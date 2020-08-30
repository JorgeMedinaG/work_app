import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:hiring_open/src/values/values.dart';
import 'package:hiring_open/src/widgets/button_widget.dart';
import 'package:hiring_open/src/widgets/topbar_widget.dart';


class CountryPage extends StatefulWidget {
  

  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {


    List country;
    List<bool> _selected;
    int _prevIndex;
    
    @override
    void initState() {
      super.initState();
      country = ['India', 'USA', 'Australia', 'Canada', 'New Zealand', 'Singapore', 'United Kingdom', 'Shri Lanka', 'Pakistan'];
      _selected = List.generate(country.length, (i) => false);
      _prevIndex = 0;
    }

    @override
    Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          margin: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          child: Column(
            children: <Widget>[
              _topBar(),
              SizedBox(height: 55.0),
              Expanded(
                child: ListView(
                  children: _countryList()
                ),
              ),
              CustomButton(text: 'SUBMIT', onPressed: _selected.contains(true) ? () => Navigator.pushReplacementNamed(context, 'home') : null,)
            ],
          ),         
        ),
      ),
    );
  }

  List<Widget> _countryList() {

    List<Widget> items = new List();

    country.forEach( (item) {

      final tempWidget = ListTile(
        dense: true,
        trailing: _selected[country.indexOf(item)] ?  Icon(Icons.check, color: AppColors.primaryElement, size: 30.0) : null,
        title: Text(item,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryElement
            ),
          ),
        onTap: () {   
          print(item);
          setState(() {
            _selected[_prevIndex] = false;
            _selected[country.indexOf(item)] = !_selected[country.indexOf(item)];
            _prevIndex = country.indexOf(item);
          });
        },
      );
      items..add(tempWidget)
           ..add(Divider());

    });

    return items;
  }

  Widget _topBar() {
    return TopBar(title: 'SELECT COUNTRY');
  }
}
import 'package:flutter/material.dart';

import 'package:hiring_open/src/utils/routes.dart';
import 'package:hiring_open/src/values/values.dart';
import 'package:hiring_open/src/widgets/titled_navigation_bar.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {

  int pageindex;

  @override
  void initState() {
    super.initState();
    pageindex = 0;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: navBarPage(pageindex),
        bottomNavigationBar: TitledBottomNavigationBar(
        currentIndex: pageindex, // Use this to update the Bar giving a position
        onTap: (index){
          print("Selected Index: $index");
          setState(() {
            pageindex = index;
          });
        },
        activeColor: AppColors.primaryColor,
        enableShadow: true,
        reverse: true,
        items: [
            TitledNavigationBarItem(title: ImageIcon(AssetImage('assets/icons/search.png'))),
            TitledNavigationBarItem(title: ImageIcon(AssetImage('assets/icons/create-resume.png'))),
            TitledNavigationBarItem(title: ImageIcon(AssetImage('assets/icons/recommended-job.png'))),
            TitledNavigationBarItem(title: ImageIcon(AssetImage('assets/icons/shortlist-job.png'))),
            TitledNavigationBarItem(title: ImageIcon(AssetImage('assets/icons/save-jobs.png'))),
            TitledNavigationBarItem(title: ImageIcon(AssetImage('assets/icons/applied-job.png'))),
            TitledNavigationBarItem(title: ImageIcon(AssetImage('assets/icons/profile.png'))),
        ]
      
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:hiring_open/src/bloc/provider.dart';

import 'package:hiring_open/src/utils/routes.dart';
import 'package:hiring_open/src/utils/user_preferences.dart';
import 'package:hiring_open/src/values/values.dart';
 
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPreferences();
  await prefs.initPrefs();
  runApp(MyApp());
} 
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hiring Open',
          initialRoute: 'splash',
          routes: getRoutes(),
          theme: ThemeData(
            primaryColor: AppColors.primaryColor
          ),
        ),
      );
  }
}
import 'package:flutter/widgets.dart';
import 'package:hiring_open/src/pages/applied_page.dart';
import 'package:hiring_open/src/pages/country_page.dart';
import 'package:hiring_open/src/pages/create_resume.dart';
import 'package:hiring_open/src/pages/forgetpassword_page.dart';
import 'package:hiring_open/src/pages/global_page.dart';
import 'package:hiring_open/src/pages/jobdetail_page.dart';
import 'package:hiring_open/src/pages/login_page.dart';
import 'package:hiring_open/src/pages/navigation_page.dart';
import 'package:hiring_open/src/pages/otp_page.dart';
import 'package:hiring_open/src/pages/post_resume.dart';
import 'package:hiring_open/src/pages/profile_page.dart';
import 'package:hiring_open/src/pages/recommended_page.dart';
import 'package:hiring_open/src/pages/resetpassword_page.dart';
import 'package:hiring_open/src/pages/savedjobs_page.dart';
import 'package:hiring_open/src/pages/shortlisted_page.dart';
import 'package:hiring_open/src/pages/signup_page.dart';
import 'package:hiring_open/src/pages/splashscreen.dart';
import 'package:hiring_open/src/pages/upload_resume.dart';



Map<String, WidgetBuilder>  getRoutes(){

  Map<String, WidgetBuilder> routeMap = {
    'signup'      : (BuildContext context) => SignUpPage(),
    'login'       : (BuildContext context) => LoginPage(),
    'resetpass'   : (BuildContext context) => ResetPasswordPage(),
    'forgetpass'  : (BuildContext context) => ForgetPasswordPage(),
    'otp'         : (BuildContext context) => OTPPage(),
    'country'     : (BuildContext context) => CountryPage(),
    'splash'      : (BuildContext context) => SplashScreen(),
    'nav'         : (BuildContext context) => NavigationPage(),
    'jobdetail'   : (BuildContext context) => JobDetailsPage(),
    'createresume': (BuildContext context) => CreateResume(),
    'uploadresume': (BuildContext context) => UploadResume()
  };

  return routeMap;
}

Widget navBarPage(int index) {

  switch (index) {
    case 0: return GlobalPage();
    case 1: return PostResumePage();
    case 2: return RecommendJobsPage();
    case 3: return ShorlistedJobsPage();
    case 4: return SavedJobsPage();
    case 5: return AppliedJobsPage();
    case 6: return ProfilePage();
    default: return GlobalPage(); 
  }

}
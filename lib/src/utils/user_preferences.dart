import 'package:shared_preferences/shared_preferences.dart';


class UserPreferences {

  static final UserPreferences _instancia = new UserPreferences._internal();

  factory UserPreferences() {
    return _instancia;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET and SET of email
  get email {
    return _prefs.getString('email') ?? '';
  }

  set email( String value ) {
    _prefs.setString('email', value);
  }
  
  // GET and SET of the password
  get password {
    return _prefs.getString('password') ?? '';
  }

  set password( String value ) {
    _prefs.setString('password', value);
  }

  //User Information
  get userInformation{
    return _prefs.getString('userInformation')?? '{}';
  }

  set userInformation(String value){
    _prefs.setString('userInformation', value);
  }

  //User ID
  get userID{
    return _prefs.getInt('userID') ?? 0;
  }

  set userID(int id){
    _prefs.setInt('userID', id);
  }





}


import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';

import 'package:hiring_open/src/utils/user_preferences.dart';
import 'package:hiring_open/src/utils/credentials.dart' as credentials;

class UserProvider {

  final _prefs = new UserPreferences();

  final _baseurl  = credentials.baseurl;
  final _apikey = credentials.apiKey;

  Future<Map> _requestHttp(Uri url) async {
  
    var resp;
    Map decodedResp = new Map();
    try {
      resp = await http.get(url,
        headers: {
          "Accept": "application/json; charset=UTF-8", 
        },
      );
    } catch (e) {
      print("Error in HTTP Request:");
      print(e.toString());
      return {'responseMessage' : 'ERROR', 'response' : "Couldn't process your request"};
    } 

    if (resp.statusCode == 200) {
      decodedResp = json.decode(resp.body);
    } else {
      print('Error HTTP:'+resp.statusCode.toString());
      return {'responseMessage' : 'ERROR', 'response' : "Request Error"};
    }

    return decodedResp;

  }

  Future<Map<dynamic,dynamic>> login(String email, String password) async {

    final url = Uri.https(_baseurl, 'api/login/'+email+'/'+password,
      {
        'apikey' : _apikey,
      }
    );
    
    return await _requestHttp(url);
  }

  Future<Map<dynamic,dynamic>> emailOtp(String email) async {

    final url = Uri.https(_baseurl, 'api/sendotpviaemail',
      {
        'email' : email,
        'apikey' : _apikey,
      }
    );
    print(url);
    return await _requestHttp(url);
  }

  Future<Map<dynamic,dynamic>> phoneOtp(String phone) async {

    final url = Uri.https(_baseurl, 'api/sendotpviaphone',
      {
        'phone' : phone,
        'apikey' : _apikey,
      }
    );
    print(url);
    return await _requestHttp(url);
  }

  Future<Map<dynamic,dynamic>> signUp(String name, String password, int emailverify, int phoneverify, String email, String phone, String role ) async {

    final url = Uri.https(_baseurl, 'api/signup',
      {
        'apikey'      : _apikey,
        'name'        : name, 
        'password'    : password,
        'emailverify' : emailverify.toString(),
        'phoneverify' : phoneverify.toString(),
        'email'       : email,
        'phone'       : phone,
        'role'        : role
      }
    );
    print(url);

    return await _requestHttp(url);
  }

  Future<Map<dynamic,dynamic>> changePassword(String email, String newpassword) async {
    
    final url = Uri.https(_baseurl, 'api/changepswd/'+email,
      {
        'apikey'      : _apikey,
        'newpassword' : newpassword
      }
    );
    print(url);

    return await _requestHttp(url);

  }

  Future<Map> updateProfilePicture(PickedFile image) async {

    final userid = _prefs.userID; 
    final url = Uri.https(_baseurl, 'api/profilepicupdate',
      {
        'apikey' : _apikey,
        'userid' : userid.toString()
      }
    );

    final mimeType = mime(image.path).split('/');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath(
      'file', 
      image.path, 
      contentType: MediaType(mimeType[0], mimeType[1])
    );

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode == 200 ){
      return json.decode(resp.body);

    } else {
      return {'responseMessage' : 'ERROR', 'response' : "Couldn't upload your image"};
    }

  }

  Future updateProfile(Map userInformation) async {

    final userid = _prefs.userID;
    final url = Uri.https(_baseurl, 'api/profilechange',
    {
      "apikey" : _apikey, 
      "userid" : userid.toString(),
      "name"   : userInformation["username"],
      "email"  : userInformation["email"],
      "phone"  : userInformation["phone"],
      "country" : userInformation["country"], 
      "state"  : userInformation["state"],
      "city"   : userInformation["city"]
    }
    );

    final resp = await _requestHttp(url); 

    _prefs.userInformation =json.encode(resp["response"]);
    return resp;
  }


}
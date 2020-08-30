import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:hiring_open/src/providers/user_provider.dart';
import 'package:hiring_open/src/utils/user_preferences.dart';
import 'package:hiring_open/src/values/values.dart';
import 'package:hiring_open/src/widgets/errordialog.dart';
import 'package:hiring_open/src/widgets/loading.dart';
import 'package:hiring_open/src/utils/credentials.dart' as credentials;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final _prefs = UserPreferences();
  final userProvider = UserProvider();
  final picker = ImagePicker();
  PickedFile pickedFile;

  Map<String,dynamic> userInfo = new Map();

  @override
  void initState() {
    super.initState();
    print(_prefs.userInformation);
    userInfo = json.decode(_prefs.userInformation);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white70,
      appBar: AppBar(
        leading: Navigator.canPop(context) ? IconButton(
          icon: Icon(Icons.keyboard_arrow_left, size: 30.0,), 
          onPressed: () => Navigator.pop(context)
          ) : Container(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: (){
              _prefs.email = '';
              _prefs.password = '';
              _prefs.userID = 0;
              _prefs.userInformation = json.encode({});
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
        ],
        title: Text('Update Profile', style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
        ),),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        
      ),
      body: Column(
      children: <Widget>[
          SizedBox(height: 25.0),          
          Expanded(
            child:  _userForm(),
          ),
          _button()
        ],
      ),
        
    );
  }

  Widget _displayName() {
    return Container(
      padding: EdgeInsets.all(15.0),
      alignment: Alignment.center,
      child: Text(userInfo['username']??'',
        style: GoogleFonts.poppins(
          fontSize: 20.0,
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }

  Widget _userForm(){
    return SingleChildScrollView(
      child: Form(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:35.0),
            child:Column(
              children: <Widget>[
                _image(),
                _displayName(),
                _name(),
                _email(),
                _phone(),
                _city(),
                _state(),
                _country(),
              ],
          ),
        ),
      ),
    );
  }

  Widget _image(){

    String imageurl = '';

    print(imageurl);
    return GestureDetector(
      child: CircleAvatar(
        backgroundImage: pickedFile?.path == null ? _imageSelect() : AssetImage(pickedFile.path),
        radius: 70.0,
      ),
      onTap: () async {
        print('tapped');
        
        pickedFile = await picker.getImage(source: ImageSource.gallery);
        if (pickedFile == null) return;
        setState(() {});
        print(pickedFile.path);

      },
    );
  }

  _imageSelect(){

    if ( userInfo['img'] == null){ 
      return AssetImage('assets/img/default-user.png');
    } else if ( userInfo['img'].toString().startsWith('public/media') ){
      return NetworkImage(credentials.baseurl+userInfo['img']);
    } else {
      return NetworkImage(userInfo['img']);
    }
  }

  Widget _name() {
    return TextFormField(
      initialValue: userInfo['username'],
      onChanged: (value) => userInfo["username"] = value,
      decoration: InputDecoration(
        labelText: 'NAME',
        labelStyle: GoogleFonts.poppins()
      ),
    );
  }

  Widget _email() {
    return TextFormField(
      initialValue: userInfo['email'],
      onChanged: (value) => userInfo["email"] = value,
      decoration: InputDecoration(
        labelText: 'EMAIL ADDRESS',
        labelStyle: GoogleFonts.poppins()
      ),
    );
  }

  Widget _phone() {
    return TextFormField(
      initialValue: userInfo['phone'],
      onChanged: (value) => userInfo["phone"] = value,
      decoration: InputDecoration(
        labelText: 'PHONE NO.',
        labelStyle: GoogleFonts.poppins()
      ),
    );
  }

  Widget _city() {
    return TextFormField(
      initialValue: userInfo['city'],
      onChanged: (value) => userInfo["city"] = value,
      decoration: InputDecoration(
        labelText: 'CITY',
        labelStyle: GoogleFonts.poppins()
      ),
    );
  }

  Widget _state() {
    return TextFormField(
      initialValue: userInfo['state'],
      onChanged: (value) => userInfo["state"] = value,
      decoration: InputDecoration(
        labelText: 'STATE',
        labelStyle: GoogleFonts.poppins()
      ),
    );
  }

  Widget _country() {
    return TextFormField(
      initialValue: userInfo['country'],
      onChanged: (value) => userInfo["country"] = value,
      decoration: InputDecoration(
        labelText: 'COUNTRY',
        labelStyle: GoogleFonts.poppins()
      ),
    );
  }

  Widget _button(){
    return Container(
      width: double.infinity,
      height: 50.0,
      child: FlatButton(
        onPressed: ()async{

          showDialog(
            context: context,
            barrierDismissible: false, 
            builder: (BuildContext context){
              return LoadingDialog();
            }
          );

          final updatedUser = await userProvider.updateProfile(userInfo);

          if (pickedFile != null){

            final resp = await userProvider.updateProfilePicture(pickedFile);
            if (resp['responseMessage'] == 'SUCESS'){
              _prefs.userInformation = json.encode(resp['response']);
              print('uploaded');
              setState(() {});
            }
          }

          Navigator.pop(context);
          showDialog(
            context: context, 
            builder: (BuildContext context){
              return ErrorDialog(message: updatedUser["responseMessage"]);
            }
          );


        }, 
        child: Text('Update',
          style: GoogleFonts.poppins(
            fontSize: 20.0
          ),
        ),
        textColor: Colors.white,
        color: AppColors.primaryColor,
      ),
    );
  }

}
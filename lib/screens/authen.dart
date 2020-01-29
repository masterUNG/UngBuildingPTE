import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungbuilding/models/user_model.dart';
import 'package:ungbuilding/screens/my_service.dart';

import 'package:ungbuilding/screens/register.dart';
import 'package:ungbuilding/utility/my_style.dart';
import 'package:ungbuilding/utility/normal_dialog.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Field
  String user, password;

  // Method
  Widget userForm() {
    return Container(
      width: 250.0,
      child: TextField(
        onChanged: (String string) {
          user = string.trim();
        },
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: MyStyle().textColor)),
            prefixIcon: Icon(
              Icons.face,
              color: MyStyle().textColor,
            ),
            hintText: 'User :',
            hintStyle: TextStyle(color: MyStyle().textColor)),
      ),
    );
  }

  Widget passwordForm() {
    return Container(
      width: 250.0,
      child: TextField(
        onChanged: (String string) {
          password = string.trim();
        },
        obscureText: true,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: MyStyle().textColor)),
            prefixIcon: Icon(
              Icons.lock,
              color: MyStyle().textColor,
            ),
            hintText: 'Password :',
            hintStyle: TextStyle(color: MyStyle().textColor)),
      ),
    );
  }

  Widget showLogo() {
    return Container(
      width: 120.0,
      height: 120.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showAppName() {
    return Text(
      'Ung Building',
      style: MyStyle().h1Main,
    );
  }

  Widget signInButton() {
    return RaisedButton(
      color: MyStyle().textColor,
      child: Text(
        'Sign In',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        print('user = $user, pass = $password');
        if (user == null ||
            user.isEmpty ||
            password == null ||
            password.isEmpty) {
          normalDialog(context, 'Have Space', 'Please Fill User and Password');
        } else {
          checkAuthen();
        }
      },
    );
  }

  Future<void> checkAuthen() async {
    String url =
        'https://www.androidthai.in.th/pte/getUserWhereUserMaster.php?isAdd=true&User=$user';

    Response response = await Dio().get(url);
    print('response = $response');
    if (response.toString() == 'null') {
      normalDialog(context, 'User False', 'No $user in my database');
    } else {
      var result = json.decode(response.data);
      print('result = $result');

      for (var map in result) {
        UserModel userModel = UserModel.fromMap(map);
        if (password == userModel.password) {
          print('Welcome ${userModel.name}');

          // MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext buildContext){return MyService();});
          MaterialPageRoute materialPageRoute = MaterialPageRoute(
              builder: (BuildContext buildContext) => MyService());
          Navigator.of(context).pushAndRemoveUntil(materialPageRoute,
              (Route<dynamic> route) {
            return false;
          });
        } else {
          normalDialog(context, 'Password False', 'Please Try Agains');
        }
      }
    }
  }

  Widget signUpButton() {
    return OutlineButton(
      borderSide: BorderSide(color: MyStyle().textColor),
      child: Text(
        'Sign Up',
        style: TextStyle(color: MyStyle().textColor),
      ),
      onPressed: () {
        print('You Click Sign Up');

        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext buildContext) {
          return Register();
        });
        Navigator.of(context).push(materialPageRoute);
      },
    );
  }

  Widget showButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        signInButton(),
        SizedBox(width: 5.0),
        signUpButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[Colors.white, MyStyle().mainColor],
            radius: 1.2,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                showLogo(),
                showAppName(),
                userForm(),
                passwordForm(),
                SizedBox(height: 10.0),
                showButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

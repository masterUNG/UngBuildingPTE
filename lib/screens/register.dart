import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ungbuilding/utility/my_constant.dart';
import 'package:ungbuilding/utility/my_style.dart';
import 'package:ungbuilding/utility/normal_dialog.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Field
  File file;
  String name, user, password;

  // Method
  Widget nameForm() {
    Color color = Colors.purple;
    return Container(
      margin: EdgeInsets.only(left: 30.0, right: 30.0),
      child: TextField(
        onChanged: (String string) {
          name = string.trim();
        },
        style: TextStyle(color: color),
        decoration: InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: color)),
          helperStyle: TextStyle(color: color),
          helperText: 'Type Your Name in Blank',
          labelText: 'Display Name : ',
          labelStyle: TextStyle(color: color),
          icon: Icon(
            Icons.face,
            size: 36.0,
            color: color,
          ),
        ),
      ),
    );
  }

  Widget userForm() {
    Color color = Colors.deepOrange;
    return Container(
      margin: EdgeInsets.only(left: 30.0, right: 30.0),
      child: TextField(
        onChanged: (String string) {
          user = string.trim();
        },
        style: TextStyle(color: color),
        decoration: InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: color)),
          helperStyle: TextStyle(color: color),
          helperText: 'Type Your User in Blank',
          labelText: 'User : ',
          labelStyle: TextStyle(color: color),
          icon: Icon(
            Icons.account_box,
            size: 36.0,
            color: color,
          ),
        ),
      ),
    );
  }

  Widget passwordForm() {
    Color color = Colors.green;
    return Container(
      margin: EdgeInsets.only(left: 30.0, right: 30.0),
      child: TextField(
        onChanged: (String string) {
          password = string.trim();
        },
        style: TextStyle(color: color),
        decoration: InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: color)),
          helperStyle: TextStyle(color: color),
          helperText: 'Type Your Password in Blank',
          labelText: 'Password : ',
          labelStyle: TextStyle(color: color),
          icon: Icon(
            Icons.lock,
            size: 36.0,
            color: color,
          ),
        ),
      ),
    );
  }

  Widget cameraButton() {
    return IconButton(
      icon: Icon(Icons.add_a_photo),
      onPressed: () {
        getPhoto(ImageSource.camera);
      },
    );
  }

  Future<void> getPhoto(ImageSource imageSource) async {
    try {
      var object = await ImagePicker.pickImage(
        source: imageSource,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );

      setState(() {
        file = object;
      });
    } catch (e) {}
  }

  Widget galleryButton() {
    return IconButton(
      icon: Icon(Icons.add_photo_alternate),
      onPressed: () {
        getPhoto(ImageSource.gallery);
      },
    );
  }

  Widget showButtom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        cameraButton(),
        galleryButton(),
      ],
    );
  }

  Widget showAvatar() {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: file == null ? Image.asset('images/avatar.png') : Image.file(file),
    );
  }

  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        if (file == null) {
          normalDialog(context, 'No Avatar', 'Please Click Camera or Gallery');
        } else if (name == null ||
            name.isEmpty ||
            user == null ||
            user.isEmpty ||
            password == null ||
            password.isEmpty) {
          normalDialog(context, 'Have Space', 'Please Fill Every Blank');
        } else {
          processUploadAvatar();
        }
      },
    );
  }

  Future<void> processUploadAvatar() async {
    try {
      Map<String, dynamic> map = Map();
      map['file'] = UploadFileInfo(file, '$name.jpg');
      FormData formData = FormData.from(map);

      await Dio()
          .post(MyConstant().urlAPIsaveFile, data: formData)
          .then((response) {
        print('response = $response');
        processInsertDatabase();
      });
    } catch (e) {}
  }

  Future<void> processInsertDatabase() async {
    String avatar = 'https://www.androidthai.in.th/pte/avatarMaster/$name.jpg';
    String url =
        'https://www.androidthai.in.th/pte/addUserMaster.php?isAdd=true&Name=$name&User=$user&Password=$password&Avatar=$avatar';

    await Dio().get(url).then((response) {
      if (response.toString() == 'true') {
        Navigator.of(context).pop();
      } else {
        normalDialog(context, 'Register False', 'Please Try Again');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        actions: <Widget>[registerButton()],
        backgroundColor: MyStyle().textColor,
      ),
      body: ListView(
        children: <Widget>[
          showAvatar(),
          showButtom(),
          nameForm(),
          userForm(),
          passwordForm(),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}

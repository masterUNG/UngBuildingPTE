import 'package:flutter/material.dart';

class AddBuildtin extends StatefulWidget {
  @override
  _AddBuildtinState createState() => _AddBuildtinState();
}

class _AddBuildtinState extends State<AddBuildtin> {
  // Field

  // Method
  Widget nameForm() {
    return Container(
      width: 250.0,
      child: TextField(
        decoration: InputDecoration(hintText: 'Name :'),
      ),
    );
  }

  Widget detailForm() {
    return Container(
      width: 250.0,
      child: TextField(
        decoration: InputDecoration(hintText: 'Detail :'),
      ),
    );
  }

  Widget showImage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Image.asset('images/camera.png'),
    );
  }

  Widget myContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        showImage(),
        nameForm(),
        detailForm(),
      ],
    );
  }

  Widget addBuildingButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: RaisedButton(
            child: Text('Add Buildtin'),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Building'),
      ),
      body: Stack(
        children: <Widget>[
          addBuildingButton(),
          myContent(),
        ],
      ),
    );
  }
}

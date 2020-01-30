import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddBuildtin extends StatefulWidget {
  @override
  _AddBuildtinState createState() => _AddBuildtinState();
}

class _AddBuildtinState extends State<AddBuildtin> {
  // Field
  double lat, lng;

  // Method
  @override
  void initState() {
    super.initState();
    findLatLng();
  }

  Future<void> findLatLng() async {
    Duration duration = Duration(seconds: 10);
    await Timer(duration, () {
      setState(() {
        lat = 13.677872;
        lng = 100.586286;
      });
    });
  }

  Widget showDetailMap() {
    LatLng latLng = LatLng(lat, lng);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16,
    );
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: cameraPosition,
      onMapCreated: (GoogleMapController googleMapController) {},
    );
  }

  Widget showMap() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: lat == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : showDetailMap(),
    );
  }

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
        showMap(),
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

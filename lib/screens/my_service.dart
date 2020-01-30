import 'package:flutter/material.dart';
import 'package:ungbuilding/widget/list_building.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Filed
  Widget currentWidget = ListBuilding();

  // Method
  Widget showDrawer() {
    return Drawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
      ),
      drawer: showDrawer(),
      body: currentWidget,
    );
  }
}

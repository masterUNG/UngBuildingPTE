import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungbuilding/models/building_model.dart';
import 'package:ungbuilding/screens/add_building.dart';
import 'package:ungbuilding/utility/my_constant.dart';

class ListBuilding extends StatefulWidget {
  @override
  _ListBuildingState createState() => _ListBuildingState();
}

class _ListBuildingState extends State<ListBuilding> {
  // Field
  List<BuildingModel> buildingModels = List();

  // Method

  @override
  void initState() {
    super.initState();
    readAllData();
  }

  Future<void> readAllData() async {
    if (buildingModels.length > 0) {


      buildingModels.clear();
      // buildingModels.removeWhere((BuildingModel buildingModel) {
      //   return buildingModel != null;
      // });
    }

    Response response = await Dio().get(MyConstant().urtAPIreadAllBuild);
    var result = json.decode(response.data);
    print('result = $result');

    for (var map in result) {
      BuildingModel buildingModel = BuildingModel.fromJson(map);
      setState(() {
        buildingModels.add(buildingModel);
      });
    }
  }

  Widget addBuildingButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                right: 20.0,
                bottom: 20.0,
              ),
              child: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  MaterialPageRoute materialPageRoute =
                      MaterialPageRoute(builder: (BuildContext buildContext) {
                    return AddBuildtin();
                  });
                  Navigator.of(context)
                      .push(materialPageRoute)
                      .then((response) {
                    readAllData();
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget showListView() {
    return ListView.builder(
      itemCount: buildingModels.length,
      itemBuilder: (BuildContext buildContext, int index) {
        return Row(
          children: <Widget>[
            showImage(index),
            showText(index),
          ],
        );
      },
    );
  }

  Widget showImage(int index) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.4,
      child: Image.network(
        buildingModels[index].urlImage,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget showText(int index) {
    return Column(
      children: <Widget>[
        Text(buildingModels[index].name),
        Text(buildingModels[index].detail),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        showListView(),
        addBuildingButton(),
      ],
    );
  }
}

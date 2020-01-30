import 'package:flutter/material.dart';
import 'package:ungbuilding/screens/add_building.dart';

class ListBuilding extends StatefulWidget {
  @override
  _ListBuildingState createState() => _ListBuildingState();
}

class _ListBuildingState extends State<ListBuilding> {
  // Field

  // Method
  Widget addBuildingButton() {
    return Column(mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(margin: EdgeInsets.only(right: 20.0, bottom: 20.0,),
              child: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {

                    MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext buildContext){return AddBuildtin();});
                    Navigator.of(context).push(materialPageRoute);

                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget showListView() {
    return ListView(
      children: <Widget>[Text('ListView')],
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

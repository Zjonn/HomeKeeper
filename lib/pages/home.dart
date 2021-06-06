import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_keeper/providers/teams_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    TeamProvider teamProvider = Provider.of<TeamProvider>(context);

    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.all(40.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Ble ble bleble",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 30),
                ),
              ])),
    );
  }
}

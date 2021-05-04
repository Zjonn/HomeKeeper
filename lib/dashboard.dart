import 'package:flutter/material.dart';
import 'package:home_keeper/widgets/side_menu.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text("HomeKeeper"),
        elevation: 0.1,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Center(child: Text("WELCOME")),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}

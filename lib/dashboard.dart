import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:home_keeper/auth_provider.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    Function() doLogout = () async {
      await auth.logout();
      Navigator.pushReplacementNamed(context, '/login');
      Flushbar(
        message: "Successful logout",
        duration: Duration(seconds: 2),
      ).show(context);
    };

    return Scaffold(
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
          ElevatedButton(onPressed: doLogout, child: Text("Logout"))
        ],
      ),
    );
  }
}

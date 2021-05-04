import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:home_keeper/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
        body: SingleChildScrollView(
            child: Container(
      padding: EdgeInsets.all(40.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Theme.of(context).primaryColor,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: doLogout,
            child: Text(
              "Logout",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ]),
    )));
  }
}

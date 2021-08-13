import 'package:flutter/material.dart';
import 'package:home_keeper/providers/auth_provider.dart';
import 'package:home_keeper/widgets/button.dart';
import 'package:home_keeper/widgets/flushbar.dart';
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
      CommonFlushbar("Successful logout").show(context);
    };

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(5, 40, 5, 20),
      reverse: true,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Theme.of(context).primaryColor,
          child: CommonMaterialButton("Logout", onPressed: doLogout),
        ),
      ]),
    );
  }
}

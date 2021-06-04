import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_keeper/providers/teams_provider.dart';
import 'package:provider/provider.dart';

class Team extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Team();
}

class _Team extends State<Team> with AutomaticKeepAliveClientMixin<Team> {
  final formKey = new GlobalKey<FormState>();

  late String _teamName, _teamPassword;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    TeamProvider teamProvider = Provider.of<TeamProvider>(context);

    final usernameField = TextFormField(
      autofocus: false,
      onSaved: (value) => _teamName = value ?? '',
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) =>
          value?.isEmpty ?? true ? "Please enter password" : null,
      onSaved: (value) => _teamPassword = value ?? '',
    );

    var doJoin = () {
      // final form = formKey.currentState;
      // if (form.validate()) {
      //   form.save();
      //
      //   final Future<JoinResult> successfulMessage =
      //   teamProvider.joinTeam(_teamName);
      //   auth.login(_username, _password);
      //
      //   successfulMessage.then((response) {
      //     if (response.status) {
      //       Navigator.pushReplacementNamed(context, '/dashboard');
      //       Flushbar(
      //         message: "Successful login",
      //         duration: Duration(seconds: 2),
      //       ).show(context);
      //     } else {
      //       Flushbar(
      //         message: response.response.errors
      //             .map((error) => error.message)
      //             .join("\n"),
      //         duration: Duration(seconds: 2),
      //       ).show(context);
      //     }
      //   });
      // } else {
      //   print("form is invalid");
      // }
    };
    var doCreate = () {
      final form = formKey.currentState;
      if (form?.validate() ?? false) {
        form!.save();

        final Future<CreateResult> successfulMessage =
            teamProvider.createTeam(_teamName, _teamPassword);

        successfulMessage.then((response) {
          if (response.status) {
            // Navigator.pushReplacementNamed(context, '/login');
            Flushbar(
              message: "Team created",
              duration: Duration(seconds: 2),
            ).show(context);
          } else {
            Flushbar(
              message: response.response.errors!
                  .map((error) => error.message)
                  .join("\n"),
              duration: Duration(seconds: 2),
            ).show(context);
          }
        });
      } else {
        print("form is invalid");
      }
    };

    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.all(40.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 250.0),
            Text("Name"),
            usernameField,
            SizedBox(height: 20.0),
            Text("Password"),
            passwordField,
            SizedBox(height: 20.0),
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Theme.of(context).primaryColor,
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: doCreate,
                child: Text("Create a team", textAlign: TextAlign.center),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(0.0),
              ),
              child: Text("Join to an existing team",
                  style: TextStyle(fontWeight: FontWeight.w300)),
              onPressed: () {
//            Navigator.pushReplacementNamed(context, '/reset-password');
              },
            )
          ],
        ),
      ),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}

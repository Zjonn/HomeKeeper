// https://medium.com/@afegbua/flutter-thursday-13-building-a-user-registration-and-login-process-with-provider-and-external-api-1bb87811fd1d

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:home_keeper/providers/auth_provider.dart';
import 'package:home_keeper/widgets/button.dart';
import 'package:home_keeper/widgets/flushbar.dart';
import 'package:home_keeper/widgets/loading.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();

  late String _username, _password;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final usernameField = TextFormField(
      autofocus: false,
      onSaved: (value) => _username = value ?? '',
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) =>
          (value?.isEmpty ?? true) ? "Please enter password" : null,
      onSaved: (value) => _password = value ?? '',
    );

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CommonButton("Forgot password?", onPressed: () {
          // Navigator.pushReplacementNamed(context, '/reset-password');
        }),
        CommonButton("Sign up", onPressed: () {
          Navigator.pushNamed(context, '/register');
        }),
      ],
    );

    var doLogin = () {
      final form = formKey.currentState;

      if (form?.validate() ?? false) {
        form!.save();

        final Future<LoginResult> successfulMessage =
            auth.login(_username, _password);

        successfulMessage.then((response) {
          if (response.status) {
            sleep(Duration(milliseconds: 100)); // TODO: Remove me

            Navigator.pushReplacementNamed(context, '/dashboard');
            CommonFlushbar("Successful login").show(context);
          } else {
            CommonFlushbar(response.response.errors!
                    .map((error) => error.message)
                    .join("\n"))
                .show(context);
          }
        });
      } else {
        print("form is invalid");
      }
    };

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(40.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 250.0),
                  Text("Username"),
                  SizedBox(height: 5.0),
                  usernameField,
                  SizedBox(height: 20.0),
                  Text("Password"),
                  SizedBox(height: 5.0),
                  passwordField,
                  SizedBox(height: 20.0),
                  auth.loggedInStatus == Status.Authenticating
                      ? Loading()
                      : CommonMaterialButton("Login", onPressed: doLogin),
                  SizedBox(height: 5.0),
                  forgotLabel
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

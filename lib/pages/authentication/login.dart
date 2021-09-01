import 'package:flutter/material.dart';
import 'package:home_keeper/providers/auth_provider/auth_provider.dart';
import 'package:home_keeper/providers/auth_provider/results.dart';
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
      decoration: const InputDecoration(labelText: "Username"),
      onSaved: (value) => _username = value ?? '',
    );

    final passwordField = TextFormField(
      decoration: const InputDecoration(labelText: "Password"),
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
          Navigator.pushNamed(context, 'register');
        }),
      ],
    );

    var doLogin = () {
      final form = formKey.currentState!;

      if (form.validate()) {
        form.save();

        final Future<LoginResult> successfulMessage =
            auth.login(_username, _password);

        successfulMessage.then((response) {
          if (response.isSuccessful) {
            CommonFlushbar("Successful login").show(context);
          } else {
            CommonFlushbar(response.errors!).show(context);
          }
        });
      }
    };

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      color: Theme.of(context).backgroundColor,
                      onPressed: () => Navigator.pushNamed(context, 'url'),
                      icon: Icon(Icons.settings_remote)),
                ),
                SizedBox(height: 250.0),
                usernameField,
                SizedBox(height: 20.0),
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
    );
  }
}

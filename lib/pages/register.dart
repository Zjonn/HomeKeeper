import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:home_keeper/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = new GlobalKey<FormState>();

  String _username, _email, _password, _confirmPassword;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final usernameField = TextFormField(
      autofocus: false,
      onSaved: (value) => _username = value,
    );

    final emailField = TextFormField(
      autofocus: false,
      onSaved: (value) => _email = value,
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value.isEmpty ? "Please enter password" : null,
      onSaved: (value) => _password = value,
    );

    final confirmPassword = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value.isEmpty ? "Your password is required" : null,
      onSaved: (value) => _confirmPassword = value,
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[CircularProgressIndicator()],
    );

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(0.0),
          ),
          child: Text("Forgot password?",
              style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {},
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(0.0),
          ),
          child: Text("Sign in", style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ],
    );

    var doRegister = () {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        auth
            .register(_username, _email, _password, _confirmPassword)
            .then((response) {
          if (response.status) {
            Navigator.pushReplacementNamed(context, '/login');
            Flushbar(
              message: "Registration succeeded",
              duration: Duration(seconds: 3),
            ).show(context);
          } else {
            Flushbar(
              message: response.response.hasErrors
                  ? response.response.errors
                      .map((err) => err.message)
                      .join("\n")
                  : response.response.data.register.errors
                      .map((err) =>
                          [err.field, err.messages.join(",")].join(": "))
                      .join("\n"),
              duration: Duration(seconds: 10),
            ).show(context);
          }
        });
      } else {
        Flushbar(
          message: "Invalid form",
          duration: Duration(seconds: 3),
        ).show(context);
      }
    };
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

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
                  SizedBox(height: 215.0),
                  Text("Username"),
                  SizedBox(height: 5.0),
                  usernameField,
                  Text("Email"),
                  SizedBox(height: 5.0),
                  emailField,
                  SizedBox(height: 15.0),
                  Text("Password"),
                  SizedBox(height: 10.0),
                  passwordField,
                  SizedBox(height: 15.0),
                  Text("Confirm Password"),
                  SizedBox(height: 10.0),
                  confirmPassword,
                  SizedBox(height: 20.0),
                  auth.registeredInStatus == Status.Registering
                      ? loading
                      : Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Theme.of(context).primaryColor,
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: doRegister,
                            child: Text("Login",
                                textAlign: TextAlign.center,
                                style: style.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
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

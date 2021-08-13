import 'package:flutter/material.dart';
import 'package:home_keeper/providers/auth_provider.dart';
import 'package:home_keeper/widgets/button.dart';
import 'package:home_keeper/widgets/flushbar.dart';
import 'package:home_keeper/widgets/loading.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = new GlobalKey<FormState>();

  late String _username, _email, _password, _confirmPassword;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final usernameField = TextFormField(
      decoration: const InputDecoration(labelText: "Username"),
      onSaved: (value) => _username = value ?? '',
    );

    final emailField = TextFormField(
      decoration: const InputDecoration(labelText: "Email"),
      onSaved: (value) => _email = value ?? '',
    );

    final passwordField = TextFormField(
      decoration: const InputDecoration(labelText: "Password"),
      obscureText: true,
      validator: (value) =>
          (value?.isEmpty ?? true) ? "Please enter password" : null,
      onSaved: (value) => _password = value ?? '',
    );

    final confirmPassword = TextFormField(
      decoration: const InputDecoration(labelText: "Confirm Password"),
      obscureText: true,
      validator: (value) =>
          (value?.isEmpty ?? true) ? "Your password is required" : null,
      onSaved: (value) => _confirmPassword = value ?? '',
    );

    var doRegister = () {
      final form = formKey.currentState;
      if (form?.validate() ?? false) {
        form!.save();
        auth
            .register(_username, _email, _password, _confirmPassword)
            .then((response) {
          if (response.status) {
            Navigator.pushReplacementNamed(context, 'login');
            CommonFlushbar("Registration succeeded").show(context);
          } else {
            CommonFlushbar(response.response.hasErrors
                    ? response.response.errors!
                        .map((err) => err.message)
                        .join("\n")
                    : response.response.data!.register!.errors!
                        .map((err) => err != null
                            ? [err.field, err.messages.join(",")].join(": ")
                            : '')
                        .join("\n"))
                .show(context);
          }
        });
      } else {
        CommonFlushbar("Invalid form").show(context);
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
                SizedBox(height: 215.0),
                usernameField,
                SizedBox(height: 20.0),
                emailField,
                SizedBox(height: 20.0),
                passwordField,
                SizedBox(height: 20.0),
                confirmPassword,
                SizedBox(height: 20.0),
                auth.registeredInStatus == Status.Registering
                    ? Loading()
                    : CommonMaterialButton("Register", onPressed: doRegister)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

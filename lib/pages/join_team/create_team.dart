import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_keeper/providers/teams_provider.dart';
import 'package:home_keeper/widgets/button.dart';
import 'package:home_keeper/widgets/flushbar.dart';
import 'package:provider/provider.dart';

class CreateTeam extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateTeam();
}

class _CreateTeam extends State<CreateTeam>
    with AutomaticKeepAliveClientMixin<CreateTeam> {
  final formKey = new GlobalKey<FormState>();

  late String _teamName, _teamPassword;
  var _wantToKeptAlive = true;

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

    var doCreate = () {
      final form = formKey.currentState;
      if (form?.validate() ?? false) {
        form!.save();

        final Future<CreateResult> successfulMessage =
            teamProvider.createTeam(_teamName, _teamPassword);

        successfulMessage.then((response) {
          if (response.status) {
            CommonFlushbar("Team created").show(context);
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

    print(ModalRoute.of(context)!.settings.name);

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
            CommonMaterialButton("Create new team", onPressed: doCreate),
          ],
        ),
      ),
    ));
  }

  @override
  bool get wantKeepAlive => _wantToKeptAlive;
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_keeper/providers/teams_provider.dart';
import 'package:home_keeper/widgets/button.dart';
import 'package:home_keeper/widgets/flushbar.dart';
import 'package:provider/provider.dart';

class JoinTeam extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _JoinTeam();
}

class _JoinTeam extends State<JoinTeam>
    with AutomaticKeepAliveClientMixin<JoinTeam> {
  final formKey = new GlobalKey<FormState>();

  late int _teamId;
  late String _teamPassword;
  var _wantToKeptAlive = true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    TeamProvider teamProvider = Provider.of<TeamProvider>(context);

    final idField = TextFormField(
      decoration: const InputDecoration(labelText: "Team ID"),
      onSaved: (value) => _teamId = int.parse(value ?? '0'),
    );

    final passwordField = TextFormField(
      decoration: const InputDecoration(labelText: "Password"),
      obscureText: true,
      validator: (value) =>
          value?.isEmpty ?? true ? "Please enter password" : null,
      onSaved: (value) => _teamPassword = value ?? '',
    );

    var doJoin = () {
      final form = formKey.currentState;
      if (form?.validate() ?? false) {
        form!.save();

        final Future<JoinResult> successfulMessage =
            teamProvider.joinTeam(_teamId, _teamPassword);

        successfulMessage.then((response) {
          if (response.status) {
            CommonFlushbar("Joined to a team").show(context);
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

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 250.0),
            idField,
            SizedBox(height: 20.0),
            passwordField,
            SizedBox(height: 20.0),
            CommonMaterialButton(
              "Join to a team",
              onPressed: doJoin,
            ),
            CommonButton("Create new team", onPressed: () {
              Navigator.pushNamed(context, 'create_team');
            })
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => _wantToKeptAlive;
}

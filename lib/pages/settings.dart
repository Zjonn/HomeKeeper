import 'package:flutter/material.dart';
import 'package:home_keeper/providers/auth_provider/auth_provider.dart';
import 'package:home_keeper/providers/teams_provider/teams_provider.dart';
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
    TeamProvider teamProvider = Provider.of<TeamProvider>(context);

    final doLogout = () async {
      await auth.logout();
      CommonFlushbar("Successful logout").show(context);
    };

    final leaveTeam = teamProvider.state == TeamProviderState.UserIsMember
        ? () async {
            final res = await teamProvider
                .leaveTeam(int.parse(teamProvider.currentTeamInfo.id));
            if (res.isSuccessful) {
              CommonFlushbar("Team left").show(context);
            } else {
              SOMETHING_WENT_WRONG_FLUSHBAR.show(context);
            }
          }
        : null;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(5, 40, 5, 20),
      reverse: true,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CommonMaterialButton("Logout", onPressed: doLogout),
        SizedBox(height: 5),
        CommonMaterialButton("Leave team",
            textColor: Colors.red, onPressed: leaveTeam),
      ]),
    );
  }
}

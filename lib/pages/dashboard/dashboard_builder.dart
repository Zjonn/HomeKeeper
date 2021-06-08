import 'package:flutter/cupertino.dart';
import 'package:home_keeper/pages/dashboard.dart';
import 'package:home_keeper/providers/teams_provider.dart';
import 'package:provider/provider.dart';

class DashBoardBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => TeamProvider(),
      builder: (context, child) {
        var teamProvider = Provider.of<TeamProvider>(context);

        return FutureBuilder(
          future: teamProvider.initialize(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            return DashBoard();
          },
        );
      },
    );
  }
}

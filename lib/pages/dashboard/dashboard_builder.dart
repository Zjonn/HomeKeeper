import 'package:flutter/cupertino.dart';
import 'package:home_keeper/pages/dashboard/dashboard.dart';
import 'package:home_keeper/providers/teams_provider.dart';
import 'package:home_keeper/widgets/loading.dart';
import 'package:provider/provider.dart';

class DashBoardBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TeamProvider(),
      builder: (context, child) {
        final teamProvider = Provider.of<TeamProvider>(context);

        return FutureBuilder(
          future: teamProvider.initialize(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return DashBoard();
              case ConnectionState.waiting:
                return Loading();
              default:
                throw UnsupportedError("Unexpected snapshot state");
            }
          },
        );
      },
    );
  }
}

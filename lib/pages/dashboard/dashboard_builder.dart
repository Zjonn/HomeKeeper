import 'package:flutter/cupertino.dart';
import 'package:home_keeper/pages/dashboard/dashboard.dart';
import 'package:home_keeper/providers/auth_client_provider.dart';
import 'package:home_keeper/providers/tasks_provider.dart';
import 'package:home_keeper/providers/teams_provider.dart';
import 'package:home_keeper/widgets/loading.dart';
import 'package:provider/provider.dart';

class DashBoardBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => AuthClientProvider(),
        builder: (context, child) {
          final client = Provider.of<AuthClientProvider>(context);

          switch (client.state) {
            case ClientState.Uninitialized:
              return FutureBuilder(
                  future: client.initialize(),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                      case ConnectionState.waiting:
                        return Loading();
                      default:
                        throw "Unexpected snapshot state";
                    }
                  });
            case ClientState.Initialized:
              return MultiProvider(providers: [
                ChangeNotifierProvider(
                    create: (_) => TeamProvider(client.client)),
                ChangeNotifierProvider(
                    create: (_) => TasksProvider(client.client))
              ], builder: (context, child) => DashBoard());
            default:
              throw "Unsupported state";
          }
        });
  }
}

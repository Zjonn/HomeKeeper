import 'package:flutter/cupertino.dart';
import 'package:home_keeper/pages/dashboard/dashboard.dart';
import 'package:home_keeper/providers/connection_provider.dart';
import 'package:home_keeper/providers/auth_client_provider.dart';
import 'package:home_keeper/providers/sync_provider.dart';
import 'package:home_keeper/providers/teams_provider/teams_provider.dart';
import 'package:home_keeper/widgets/loading.dart';
import 'package:provider/provider.dart';

class DashBoardBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final connectionProvider = Provider.of<ConnectionProvider>(context);

    return ChangeNotifierProvider(
        create: (_) => AuthClientProvider(connectionProvider),
        builder: (context, child) {
          final client = Provider.of<AuthClientProvider>(context);

          switch (client.state) {
            case AuthClientProviderState.InProgress:
              return Loading();
          }

          return MultiProvider(providers: [
            ChangeNotifierProvider(create: (_) => SyncProvider()),
            ChangeNotifierProxyProvider<SyncProvider, TeamProvider>(
                create: (_) => TeamProvider(client.client),
                update: (_, syncProvider, teamProvider) {
                  teamProvider!.updateUserTeamsInfo();
                  return teamProvider;
                }),
          ], builder: (context, child) => DashBoard());
        });
  }
}

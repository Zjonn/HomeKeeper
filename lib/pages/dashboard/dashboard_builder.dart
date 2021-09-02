import 'package:flutter/cupertino.dart';
import 'package:home_keeper/pages/dashboard/dashboard.dart';
import 'package:home_keeper/providers/api_url_provider.dart';
import 'package:home_keeper/providers/auth_client_provider.dart';
import 'package:home_keeper/providers/sync_provider.dart';
import 'package:home_keeper/providers/teams_provider/teams_provider.dart';
import 'package:home_keeper/widgets/container.dart';
import 'package:home_keeper/widgets/loading.dart';
import 'package:provider/provider.dart';

class DashBoardBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<ApiURLProvider, AuthClientProvider>(
        create: (_) => AuthClientProvider(ApiURLProvider.defaultApiURL),
        update: (context, value, previous) => AuthClientProvider(value.apiURL),
        builder: (context, child) {
          final client = Provider.of<AuthClientProvider>(context);

          switch (client.state) {
            case AuthClientProviderState.InProgress:
              return Loading();
            case AuthClientProviderState.NoConnectionWithBackend:
              return CommonContainer(
                child: Center(child: Text("Server is under maintenance 😢")),
              );
            case AuthClientProviderState.NoInternetConnection:
              return CommonContainer(
                child: Center(child: Text("No internet connection 😐")),
              );
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

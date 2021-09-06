import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_keeper/config/client.dart';
import 'package:home_keeper/providers/auth_client_provider.dart';
import 'package:home_keeper/providers/connection_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_client_provider_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage, ConnectionProvider])
void main() {
  late ConnectionProvider connectionProvider;
  late AuthClientProvider authClientProvider;
  late MockFlutterSecureStorage mockStorage;

  group('AuthClientProvider', () {
    setUp(() {
      mockStorage = MockFlutterSecureStorage();
      connectionProvider = MockConnectionProvider();

      when(mockStorage.read(key: anyNamed('key')))
          .thenAnswer((realInvocation) async {
        await Future.delayed(Duration(milliseconds: 10));
        return '';
      });

      when(connectionProvider.createClient(httpClient: anyNamed('httpClient')))
          .thenAnswer((realInvocation) => ArtemisClientWithTimeout(''));

      authClientProvider = AuthClientProvider(connectionProvider, mockStorage);
    });

    test('Initial state', () async {
      expect(authClientProvider.state, AuthClientProviderState.InProgress);
    });

    test('Initialized', () async {
      await Future.delayed(Duration(milliseconds: 10));
      expect(authClientProvider.state, AuthClientProviderState.Initialized);
    });
  });
}

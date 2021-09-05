import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_keeper/config/constants.dart';
import 'package:home_keeper/providers/connection_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'connection_provider.mocks.dart';

class MockCallbackFunction extends Mock {
  call();
}

@GenerateMocks([FlutterSecureStorage])
void main() {
  final notifyListenerCallback = MockCallbackFunction();
  late MockFlutterSecureStorage mockStorage;
  late ConnectionProvider apiURLProvider;

  group('ApiURLProvider', () {
    setUp(() {
      mockStorage = MockFlutterSecureStorage();
      reset(notifyListenerCallback);
    });

    test('Default value is from api_url', () {
      expect(ConnectionProvider.defaultApiURL, Constants.API_URL);
    });

    test(
      'ConstValueIfStorageEmpty',
      () async {
        when(mockStorage.read(key: anyNamed('key')))
            .thenAnswer((Invocation a) async => '');

        apiURLProvider = ConnectionProvider(mockStorage);
        await Future.delayed(Duration(milliseconds: 10));

        expect(apiURLProvider.apiURL, Constants.API_URL);
        verify(mockStorage.write(key: "api_url", value: Constants.API_URL));
      },
    );

    test(
      'ValueFromStorage',
      () async {
        when(mockStorage.read(key: anyNamed('key')))
            .thenAnswer((Invocation a) async => '8.8.8.8');

        apiURLProvider = ConnectionProvider(mockStorage);
        apiURLProvider.addListener(notifyListenerCallback);
        await Future.delayed(Duration(milliseconds: 10));

        expect(apiURLProvider.apiURL, '8.8.8.8');
        verify(notifyListenerCallback());
      },
    );

    test('ChangeValue', () async {
      when(mockStorage.read(key: anyNamed('key')))
          .thenAnswer((Invocation a) async => '8.8.8.8');

      apiURLProvider = ConnectionProvider(mockStorage);
      apiURLProvider.addListener(notifyListenerCallback);

      apiURLProvider.apiURL = '7.7.7.7';

      expect(apiURLProvider.apiURL, '7.7.7.7');
      verify(notifyListenerCallback());
      verify(mockStorage.write(key: "api_url", value: '7.7.7.7'));
    });
  });
}

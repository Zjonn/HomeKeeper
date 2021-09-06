import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_keeper/config/constants.dart';
import 'package:home_keeper/providers/connection_provider.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../utils/MockCallbackFunction.dart';
import 'connection_provider_test.mocks.dart';

@GenerateMocks([http.Client, FlutterSecureStorage])
void main() {
  final notifyListenerCallback = MockCallbackFunction();
  late MockFlutterSecureStorage mockStorage;
  late ConnectionProvider connectionProvider;
  late MockClient mockHttpClient;

  group('ConnectionProviderURLChanges', () {
    setUp(() {
      mockStorage = MockFlutterSecureStorage();
      reset(notifyListenerCallback);
    });

    test('Default value is from api_url', () {
      expect(ConnectionProvider.defaultApiURL, Constants.API_URL);
    });

    test(
      'ValueFromStorage',
      () async {
        when(mockStorage.read(key: anyNamed('key')))
            .thenAnswer((Invocation a) async => '8.8.8.8');

        connectionProvider = ConnectionProvider(mockStorage);
        connectionProvider.addListener(notifyListenerCallback);
        await Future.delayed(Duration(milliseconds: 10));

        expect(connectionProvider.apiURL, '8.8.8.8');
        verify(notifyListenerCallback());
      },
    );

    test('ChangeValue', () async {
      when(mockStorage.read(key: anyNamed('key')))
          .thenAnswer((Invocation a) async => '8.8.8.8');

      connectionProvider = ConnectionProvider(mockStorage);
      connectionProvider.addListener(notifyListenerCallback);

      connectionProvider.apiURL = '7.7.7.7';

      expect(connectionProvider.apiURL, '7.7.7.7');
      verify(notifyListenerCallback());
      verify(mockStorage.write(key: "api_url", value: '7.7.7.7'));
    });

    test(
      'ConstValueIfStorageEmpty',
      () async {
        when(mockStorage.read(key: anyNamed('key')))
            .thenAnswer((Invocation a) async => '');

        connectionProvider = ConnectionProvider(mockStorage);
        await Future.delayed(Duration(milliseconds: 10));

        expect(connectionProvider.apiURL, Constants.API_URL);
        verify(mockStorage.write(key: "api_url", value: Constants.API_URL));
      },
    );
  });

  group('ConnectionProvider', () {
    setUp(() {
      mockStorage = MockFlutterSecureStorage();
      mockHttpClient = MockClient();
      reset(notifyListenerCallback);

      when(mockStorage.read(key: anyNamed('key')))
          .thenAnswer((Invocation a) async => '');

      connectionProvider = ConnectionProvider(mockStorage, mockHttpClient);
      connectionProvider.addListener(notifyListenerCallback);
    });

    test('Initial state', () {
      expect(connectionProvider.state, ConnectionProviderState.Connected);
    });

    test('GetClient', () async {
      expect(connectionProvider.createClient(), isNot(null));
    });

    test('Connected', () async {
      when(mockHttpClient.get(any)).thenAnswer((Invocation a) async {
        await Future.delayed(Duration(milliseconds: 10));
        return http.Response('', 200);
      });

      connectionProvider.updateState();
      await Future.delayed(Duration(milliseconds: 5));
      expect(connectionProvider.state, ConnectionProviderState.CheckInProgress);

      await Future.delayed(Duration(milliseconds: 25));
      expect(connectionProvider.state, ConnectionProviderState.Connected);
      verify(notifyListenerCallback());
    });

    test('NoInternetConnection', () async {
      when(mockHttpClient.get(any)).thenThrow(TimeoutException(''));

      connectionProvider.updateState();
      await Future.delayed(Duration(milliseconds: 10));
      expect(connectionProvider.state,
          ConnectionProviderState.NoInternetConnection);
      verify(notifyListenerCallback());
    });

    test('NoBackendConnection', () async {
      when(mockHttpClient.get(Uri.parse('https://www.google.com/')))
          .thenAnswer((_) async => http.Response('', 200));

      when(mockHttpClient.get(Uri.parse(connectionProvider.apiURL)))
          .thenThrow(TimeoutException(''));

      connectionProvider.updateState();
      await Future.delayed(Duration(milliseconds: 10));
      expect(connectionProvider.state,
          ConnectionProviderState.NoBackendConnection);
      verify(notifyListenerCallback());
    });
  });
}

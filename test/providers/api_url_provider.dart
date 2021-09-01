import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_keeper/config/api_url.dart';
import 'package:home_keeper/providers/api_url_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_url_provider.mocks.dart';

class MockCallbackFunction extends Mock {
  call();
}

@GenerateMocks([FlutterSecureStorage])
void main() {
  final notifyListenerCallback = MockCallbackFunction();
  late MockFlutterSecureStorage mockStorage;
  late ApiURLProvider apiURLProvider;

  group('ApiURLProvider', () {
    setUp(() {
      mockStorage = MockFlutterSecureStorage();
      reset(notifyListenerCallback);
    });

    test('Default value is from api_url', () {
      expect(ApiURLProvider.defaultApiURL, ApiUrl.URL);
    });

    test(
      'ConstValueIfStorageEmpty',
      () async {
        when(mockStorage.read(key: anyNamed('key')))
            .thenAnswer((Invocation a) async => '');

        apiURLProvider = ApiURLProvider(mockStorage);
        await Future.delayed(Duration(milliseconds: 10));

        expect(apiURLProvider.apiURL, ApiUrl.URL);
        verify(mockStorage.write(key: "api_url", value: ApiUrl.URL));
      },
    );

    test(
      'ValueFromStorage',
      () async {
        when(mockStorage.read(key: anyNamed('key')))
            .thenAnswer((Invocation a) async => '8.8.8.8');

        apiURLProvider = ApiURLProvider(mockStorage);
        apiURLProvider.addListener(notifyListenerCallback);
        await Future.delayed(Duration(milliseconds: 10));

        expect(apiURLProvider.apiURL, '8.8.8.8');
        verify(notifyListenerCallback());
      },
    );

    test('ChangeValue', () async {
      when(mockStorage.read(key: anyNamed('key')))
          .thenAnswer((Invocation a) async => '8.8.8.8');

      apiURLProvider = ApiURLProvider(mockStorage);
      apiURLProvider.addListener(notifyListenerCallback);

      apiURLProvider.apiURL = '7.7.7.7';

      expect(apiURLProvider.apiURL, '7.7.7.7');
      verify(notifyListenerCallback());
      verify(mockStorage.write(key: "api_url", value: '7.7.7.7'));
    });
  });
}

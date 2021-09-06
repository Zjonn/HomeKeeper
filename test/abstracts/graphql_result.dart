import 'package:artemis/artemis.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home_keeper/abstracts/graphql_result.dart';
import 'package:test/test.dart';

class _FakeGraphqlResult extends GraphqlResult {
  _FakeGraphqlResult(GraphQLResponse response) : super(response);
  bool parseCalled = false;
  bool getErrorsCalled = false;

  @override
  Iterable<GraphqlError> getDataErrors(GraphQLResponse response) {
    getErrorsCalled = true;
    return response.data == null ? [] : [GraphqlError('error')];
  }

  @override
  void parseData(GraphQLResponse response) {
    parseCalled = true;
  }
}

void main() {
  group('GraphqlError', () {
    test('ValueOfProperties', () {
      final err = GraphqlError('Message', field: 'Field');
      expect(err.field, 'Field');
      expect(err.message, 'Message');
    });

    test('ErrorWithMessageAndField', () {
      final err = GraphqlError('Message', field: 'Field');
      expect(err.toString(), 'Error: Message');
    });

    test('ErrorWithMessage', () {
      final err = GraphqlError('Message');
      expect(err.toString(), 'Error: Message');
    });
  });

  group('GraphqlResult', () {
    test('ResponseWithError', () {
      final response =
          GraphQLResponse(errors: [GraphQLError(message: 'error')]);

      final err = _FakeGraphqlResult(response);
      expect(err.isSuccessful, false);
      expect(err.getErrorsCalled, false);
      expect(err.parseCalled, false);
    });

    test('ResponseWithDataError', () {
      final response = GraphQLResponse(data: '');

      final err = _FakeGraphqlResult(response);
      expect(err.isSuccessful, false);
      expect(err.getErrorsCalled, true);
      expect(err.parseCalled, false);
    });

    test('CorrectResponse', () {
      final response = GraphQLResponse();

      final err = _FakeGraphqlResult(response);
      expect(err.isSuccessful, true);
      expect(err.parseCalled, true);
      expect(err.parseCalled, true);
    });
  });
}

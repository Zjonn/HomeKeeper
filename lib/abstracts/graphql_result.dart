import 'package:artemis/schema/graphql_response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';

class GraphqlError {
  final String? field;
  final String message;

  GraphqlError(this.message, {this.field});

  GraphqlError.fromError(GraphQLError error) : this(error.message);

  @override
  String toString() {
    return 'Error: ${message}';
  }
}

abstract class GraphqlResult<T extends GraphQLResponse> {
  final T response;
  late final bool isSuccessful;
  late final String? errors;

  GraphqlResult(this.response) {
    if (response.hasErrors) {
      errors = response.errors!
          .map((e) => GraphqlError.fromError(e).toString())
          .join('\n');
      isSuccessful = false;
      return;
    }

    final dataErrors = getDataErrors(response);
    if (dataErrors.isNotEmpty) {
      errors = dataErrors.map((e) => e.toString()).join('\n');
      isSuccessful = false;
    } else {
      errors = null;
      parseData(response);
      isSuccessful = true;
    }
  }

  /// Called only when response.hasError is false.
  @protected
  Iterable<GraphqlError> getDataErrors(T response);

  /// Called only when response don't have any errors.
  @protected
  void parseData(T response);
}

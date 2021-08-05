import 'package:meta/meta.dart';

class GraphqlError<T1, T2> {
  final T1? field;
  final T2 message;

  GraphqlError(this.message, {this.field});
}

abstract class GraphqlResult<T> {
  final T response;
  late final bool isSuccessful;
  late final String? errors;

  GraphqlResult(this.response) {
    isSuccessful = parseResponse(this.response);
  }

  @protected
  bool parseResponse(T response);
}

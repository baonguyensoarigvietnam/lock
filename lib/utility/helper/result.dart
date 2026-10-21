/// Helper class representing either a success data [data], or error [error].
sealed class Result<T> {
  const Result();

  // Creates a successful result containing a value
  const factory Result.success(T data) = Success<T>._;

  // Creates an error result containing an Exception
  factory Result.error(Object error) {
    return error is Exception
        ? Error<T>._(error)
        : Error<T>._(Exception(error.toString()));
  }
}

/// Success case of [Result], having type [T]
final class Success<T> extends Result<T> {
  const Success._(this.data);
  final T data;

  @override
  String toString() => '$data';
}

/// Error case of [Result], carrying an exception.
final class Error<T> extends Result<T> {
  const Error._(this.error);
  final Exception error;

  @override
  String toString() => '$error';

  String? get message => error.toString();

  Map<String, List<String>>? get errorDetails => null;
}

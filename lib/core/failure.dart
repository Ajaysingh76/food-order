import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  final String code;

  const Failure(this.message, {this.code = 'unknown'});

  @override
  List<Object?> get props => [message, code];

  @override
  String toString() => 'Failure(code: ' + code + ', message: ' + message + ')';
}

// Simple Either-like result wrapper
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Error<T> extends Result<T> {
  final Failure failure;
  const Error(this.failure);
}

import 'package:equatable/equatable.dart';

abstract class Errors extends Equatable {
  final String message;

  const Errors(this.message);

  @override
  List<Object?> get props => [message];
}

class ApiError extends Errors {
  const ApiError(super.message);
}

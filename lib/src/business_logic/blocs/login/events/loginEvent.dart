import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginGetConnection extends LoginEvent {}

class LoginExecutedError extends LoginEvent {}

class LoginExecutedSuccess extends LoginEvent {}

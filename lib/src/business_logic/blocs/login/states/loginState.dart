import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginNormalState extends LoginState {}

class LoginErrorState extends LoginState {
  final String message;
  LoginErrorState({required this.message});
}

class LoginErrorConectionState extends LoginState {
  final String message;
  LoginErrorConectionState({required this.message});
}

class LoginSucessedState extends LoginState {}
class ButtonLoginPressedState extends LoginState {}
class ButtonLoginState extends LoginState {}
import 'package:equatable/equatable.dart';

class SplashState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SplashRunningState extends SplashState {
   late bool verifica;
  SplashRunningState([this.verifica = false]);
}

class SplashErrorState extends SplashState {
  final String message;
  SplashErrorState({required this.message});
}

class SplashExecutedState extends SplashState {}

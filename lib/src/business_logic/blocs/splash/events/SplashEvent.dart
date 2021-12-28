import 'package:equatable/equatable.dart';

class SplashEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class SplashGetConnection extends SplashEvent {
  
}
class SplashGetConnectionError extends SplashEvent {}
class SplashGetConnectionSuccess extends SplashEvent {}



import 'package:equatable/equatable.dart';

class MainState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MainOpeningState extends MainState {}

class MainNetworkErrorOpeningState extends MainState {
  final String message;
  MainNetworkErrorOpeningState({required this.message});
}

class MainProcessedState extends MainState {}
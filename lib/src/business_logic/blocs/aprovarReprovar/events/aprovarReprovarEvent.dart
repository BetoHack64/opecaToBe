import 'package:equatable/equatable.dart';

class AprovarReprovarEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAprovarReprovarEvent extends AprovarReprovarEvent {}

class AprovarEvent extends AprovarReprovarEvent {}

class ReprovarEvent extends AprovarReprovarEvent {}

class AbrirAnexosEvent extends AprovarReprovarEvent {}

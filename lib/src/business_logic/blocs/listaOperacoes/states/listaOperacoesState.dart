import 'package:SOP/src/views/ui/Lista_Aprovacoes/listaAprovacoes.dart';
import 'package:equatable/equatable.dart';

class ListaOperacoesState extends Equatable {
  @override
  List<Object?> get props => [];
}

//View Lista de Operacoes
class ListaOperacoesLoadingState extends ListaOperacoesState {}

class ListaOperacoesLoadedSucessState extends ListaOperacoesState {
  final List<CardDetail> message;
  ListaOperacoesLoadedSucessState({required this.message});
}

class ListaOperacoesLoadedErrorState extends ListaOperacoesState {
  final String message;
  ListaOperacoesLoadedErrorState({required this.message});
}

//Pesquisas
class ListaOperacoesPesquisaLoadingState extends ListaOperacoesState {}

class ListaOperacoesPesquisaFindSucessState extends ListaOperacoesState {}

class ListaOperacoesPesquisaFindErrorState extends ListaOperacoesState {}

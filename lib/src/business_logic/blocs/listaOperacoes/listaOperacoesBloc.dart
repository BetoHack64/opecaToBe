// ignore_for_file: unused_field, unused_element

import 'package:SOP/src/business_logic/blocs/listaOperacoes/events/listaOperacoesEvent.dart';
import 'package:SOP/src/business_logic/blocs/listaOperacoes/states/listaOperacoesState.dart';
import 'package:SOP/src/business_logic/models/cardDetail.dart';
import 'package:SOP/src/business_logic/repositories/listaOperacoes/cardDetailRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListaOperacoesBloc
    extends Bloc<ListaOperacoesEvent, ListaOperacoesState> {
  bool botaoHomeAparece = true;
  bool caixaDePesquisaEstaVisivel = false;
  CardDetailRepository cardDetailRepository = CardDetailRepository();
  List<CardDetail> cards = [];
  List<CardDetail> foundUsers = [];
  String idAccount = '';
  bool isDeviceConnected = false;
  String nomeSistema = '';
  String sistemaID = '';
  String traco = ' - ';
  ListaOperacoesBloc([ListaOperacoesState? initialState])
      : super(ListaOperacoesLoadingState()) {
    on<ListaOperacoesGetConnection>((event, emit) async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      nomeSistema = sistemaID =
          sharedPreferences.getString('SistemaID') ?? 'bug sistemaID';
      idAccount = sharedPreferences.getString('IdAccount') ?? 'bug idAcount';
      print('idAacount = $idAccount e sistemaId = $sistemaID');
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      try {
        foundUsers = await cardDetailRepository.getOperationsPerSystem(
            sistemaID, idAccount);
        cards = foundUsers;
        //emit(menuProcessado(listaSistemas));
      } catch (erro) {
        print('Erro lista sistemas $erro');
      }
      emit(verificaConexao(isDeviceConnected, foundUsers));
    });
  }

  ListaOperacoesState verificaConexao(bool v, List<CardDetail> lista) {
    if (v == true) {
      return ListaOperacoesLoadedSucessState(message: lista);
    } else {
      return ListaOperacoesLoadedErrorState(
          message: "Verifique a sua coneção a internet!");
    }
  }

}

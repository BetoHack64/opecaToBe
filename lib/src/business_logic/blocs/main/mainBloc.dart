import 'package:SOP/src/business_logic/blocs/main/events/mainEvent.dart';
import 'package:SOP/src/business_logic/blocs/main/states/mainState.dart';
import 'package:SOP/src/business_logic/models/sistema.dart';
import 'package:SOP/src/business_logic/repositories/main/SistemaRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  SistemaRepository sistemaRepository = SistemaRepository();
  bool estaLogado = false;
  List<Sistema> listaSistemas = [];
  bool isDeviceConnected = false;
  MainBloc(MainState initialState) : super(MainOpeningState()) {
    on<MainOpenning>((event, emit) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      emit(processando(isDeviceConnected));
    });
    on<MainGetConnectionSuccess>((event, emit) async {
      try {
        listaSistemas = await sistemaRepository.getSystemsList(); 

        emit(menuProcessado(listaSistemas));
      } catch (erro) {
        print('Erro lista sistemas $erro');
      }
    });
  }

  MainState processando(isDeviceConnected) {
    if (isDeviceConnected == true) {
      return MainOpeningState();
    } else {
      return MainNetworkErrorOpeningState(
          message: "Verifique a sua conexão por favor!");
    }
  }

  MainState menuProcessado(List<Sistema> l) {
    return MainProcessedState(lista: l);
  }
}

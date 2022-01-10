import 'package:SOP/src/business_logic/blocs/main/events/mainEvent.dart';
import 'package:SOP/src/business_logic/blocs/main/states/mainState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc(MainState initialState, List s) : super(MainOpeningState()) {
    on<MainOpenning>((event, emit) {
      emit(processando(s));
    });
    on<MainGetConnectionSuccess>((event, emit) {
      emit(menuProcessado());
    });
  }

  MainState processando(List lista) {
    if (lista.isNotEmpty) {
      return MainOpeningState();
    } else {
      return MainNetworkErrorOpeningState(
          message: "Verifique a sua conexão por favor!");
    }
  }

  MainState menuProcessado() {
    return MainProcessedState();
  }
}

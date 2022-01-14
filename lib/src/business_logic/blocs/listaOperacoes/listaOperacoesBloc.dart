import 'package:SOP/src/business_logic/blocs/listaOperacoes/events/listaOperacoesEvent.dart';
import 'package:SOP/src/business_logic/blocs/listaOperacoes/states/listaOperacoesState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ListaOperacoesBloc
    extends Bloc<ListaOperacoesEvent, ListaOperacoesState> {
  ListaOperacoesBloc([ListaOperacoesState? initialState, bool verifica = false])
      : super(ListaOperacoesLoadingState()) {
    on<ListaOperacoesGetConnection>(
        (event, emit) => emit(verificaConexao(verifica)));
    on<ListaOperacoesGetPesquisaLista>((event, emit) => emit(pesquisa()));
  }
  ListaOperacoesState verificaConexao(bool v) {
    if (v == true) {
      return ListaOperacoesLoadedSucessState();
    } else {
      return ListaOperacoesLoadedErrorState(
          message: "Verifique a sua coneção a internet!");
    }
  }

  ListaOperacoesState pesquisa() {
    return ListaOperacoesPesquisaLoadingState();
  }

  static Future<bool> temNet() async {
    bool result = await InternetConnectionChecker().hasConnection;
    //final text = result ? 'Tem Internet' : 'Nao tem Internet';
    //final cor = result ? Colors.green : Colors.red;

    return result;
  }
}

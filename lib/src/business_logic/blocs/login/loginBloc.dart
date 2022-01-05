import 'package:SOP/Home/main.dart';
import 'package:SOP/src/business_logic/blocs/login/events/loginEvent.dart';
import 'package:SOP/src/business_logic/blocs/login/states/loginState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc([LoginState? initialState, bool verifica = false])
      : super(LoginNormalState()) {
    on<LoginGetConnection>((event, emit) => emit(verificarConexao(verifica)));
    on<LoginProcessing>((event, emit) => emit(verificarCredenciais()));
    on<LoginExecutedError>((event, emit) => emit(erroCredenciais()));
    on<LoginProcessing1>((event, emit) => emit(normal()));
  }

  LoginState verificarConexao(bool v) {
    if (v == true) {
      return LoginNormalState();
    } else {
      return LoginErrorConectionState(message: "Ola");
    }
  }

  static abrirViewPrincipal(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return Home();
      }),
    );
  }

  LoginState verificarCredenciais() {
    return LoginSucessedState();
  }

  LoginState erroCredenciais() {
    return LoginErrorState(message: "Usuário ou senha inválidos!");
  }
  LoginState normal() {
    return ButtonLoginState();
  }
}

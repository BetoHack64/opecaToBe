import 'package:SOP/Home/main.dart';
import 'package:SOP/src/business_logic/blocs/login/events/loginEvent.dart';
import 'package:SOP/src/business_logic/blocs/login/states/loginState.dart';
import 'package:SOP/src/views/ui/login/logar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc([LoginState? initialState, bool verifica = false])
      : super(LoginNormalState()) {
    on<LoginGetConnection>((event, emit) => emit(verificarConexao(verifica)));
    on<LoginExecutedSuccess>((event, emit) {
      
    });
  }

  LoginState verificarConexao(bool v) {
    if (v == true) {
      return LoginNormalState();
    } else {
      return LoginErrorConectionState(message: "Ola");
    }
  }

  abrirViewPrincipal(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return Home();
      }),
    );
  }
}

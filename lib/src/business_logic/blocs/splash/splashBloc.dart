import 'dart:async';
import 'dart:io';

import 'package:SOP/Authentication/logar.dart';
import 'package:SOP/src/business_logic/blocs/splash/events/SplashEvent.dart';
import 'package:SOP/src/business_logic/blocs/splash/states/SplashState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc([SplashState? initialState, bool verifica = false])
      : super(SplashRunningState()) {
    on<SplashGetConnection>((event, emit) => emit(teste(verifica)));
  }
  //Função do tempo
  inicioTempo(BuildContext context) async {
    var duracao = Duration(seconds: 3);
    return new Timer(duracao, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreem()),
      );
    });
  }

  bool d = false;
  SplashState teste(bool v) {
    
    bool temConexao = v;
    if (temConexao == true) {
      return SplashExecutedState();
    } else {
      return SplashErrorState(message: "Erro de Conexao, verifique");
    }
  }

  test() {
    Future<bool> dd = conectar();
  print(dd);
    return d;
  }

  Future<bool> conectar() async {
    List resultado = [];
    try {
      resultado = await InternetAddress.lookup('google.com');
    } catch (e) {}

    return resultado.isNotEmpty;
  }
}

import 'dart:async';
import 'dart:io';

import 'package:SOP/src/business_logic/blocs/login/events/loginEvent.dart';
import 'package:SOP/src/business_logic/blocs/login/loginBloc.dart';
import 'package:SOP/src/business_logic/blocs/login/states/loginState.dart';
import 'package:SOP/src/views/ui/login/logar.dart';
import 'package:SOP/src/business_logic/blocs/splash/events/SplashEvent.dart';
import 'package:SOP/src/business_logic/blocs/splash/states/SplashState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc([SplashState? initialState]) : super(SplashRunningState()) {
    on<SplashGetConnection>((event, emit) => emit(abrirLoginView()));
  }
  //Função do tempo
  inicioTempo(BuildContext context, List lista) async {
    var duracao = Duration(seconds: 3);
    return new Timer(duracao, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return BlocProvider<LoginBloc>(
            create: (_) {
              return LoginBloc(
                  LoginNormalState(), lista.isNotEmpty ? true : false)
                ..add(LoginGetConnection());
            },
            child: LoginScreem(),
          );
        }),
      );
    });
  }

  SplashState abrirLoginView() {
    return SplashExecutedState();
  }

  Future<bool> conecta() async {
    List resultado = [];
    try {
      resultado = await InternetAddress.lookup('google.com');
    } catch (e) {}

    return resultado.isNotEmpty;
  }
}

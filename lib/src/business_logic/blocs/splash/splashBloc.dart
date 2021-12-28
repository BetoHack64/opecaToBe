import 'dart:async';

import 'package:SOP/Authentication/logar.dart';
import 'package:SOP/src/business_logic/blocs/splash/events/SplashEvent.dart';
import 'package:SOP/src/business_logic/blocs/splash/states/SplashState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc([SplashState? initialState]) : super(SplashRunningState());

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    if(event is SplashRunningState ){
      
    }
    
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


}

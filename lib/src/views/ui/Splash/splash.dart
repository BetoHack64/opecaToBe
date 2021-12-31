import 'dart:async';

import 'package:SOP/Authentication/logar.dart';
import 'package:SOP/src/business_logic/blocs/splash/splashBloc.dart';
import 'package:SOP/src/business_logic/blocs/splash/states/SplashState.dart';
import 'package:SOP/src/business_logic/services/shared_prefs_services/checkInternet.dart';
import 'package:SOP/src/views/ui/Splash/juncaoDosWidgetsSplashUI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Splashscrem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<Splashscrem> {
  @override
  Widget build(BuildContext context) {
    //  throw UnimplementedError();
    return initWidget();
  }
 
  @override
  void initState() {
    super.initState();
  }

  //função init widget
  Widget initWidget() {
    return Scaffold(
      body: BlocBuilder<SplashBloc, SplashState>(
        bloc: BlocProvider.of<SplashBloc>(context),
        builder: (context, state) {
         if (state is SplashExecutedState) {
            SplashBloc().inicioTempo(context);
          } if(state is SplashErrorState){
            return Center(child: Text(state.message));
          }
          return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    /* gradient: LinearGradient(
                      colors: [(Colors.red), (Color(0xFFEF5350))],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),*/
                  ),
                ),
                Center(
                  child: Container(
                    child: Image.asset(
                      "assets/images/sop.png",
                      scale: 0.9,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 115),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.red[900]),
                      ),
                    ),
                  ),
                ),
              ],
            );
        },
      ),
    );
  }
}

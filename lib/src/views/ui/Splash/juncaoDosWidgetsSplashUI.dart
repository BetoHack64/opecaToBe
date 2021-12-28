import 'package:SOP/src/business_logic/blocs/splash/splashBloc.dart';
import 'package:SOP/src/business_logic/blocs/splash/states/SplashState.dart';
import 'package:SOP/src/views/ui/Splash/indicadorProgressoCircularUI.dart';
import 'package:SOP/src/views/ui/Splash/splashLogoUI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JuncaoDosWidgetsSplashUI {
   //função init widget
  Widget initWidget(BuildContext context) {
    final media = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocBuilder<SplashBloc, SplashState>(
        bloc: BlocProvider.of<SplashBloc>(context),
        builder: (context, state) {
          if (state is SplashRunningState) {
            return Stack(
              children: [
                SplashLogoUI(),
                IndicadorProgressoCircularUI(),
              ],
            );
          } else {
            return Center(child: Text('Erro'));
          }
        },
      ),
    );
  }
}

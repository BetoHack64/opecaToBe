import 'package:SOP/src/business_logic/blocs/splash/events/SplashEvent.dart';
import 'package:SOP/src/business_logic/blocs/splash/splashBloc.dart';
import 'package:SOP/src/business_logic/blocs/splash/states/SplashState.dart';
import 'package:SOP/src/business_logic/services/shared_prefs_services/checkInternet.dart';
import 'package:SOP/src/business_logic/services/shared_prefs_services/verificaConexao.dart';
import 'package:flutter/material.dart';
import 'package:SOP/src/views/ui/Splash/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool test = false;
  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<SplashBloc>(
        create: (_) =>
            SplashBloc(SplashRunningState(), VerificaConexao().teste())..add(SplashGetConnection()),
        child:Splashscrem(),
      ),
    );
  }
}

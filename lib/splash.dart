import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opeca_app/login.dart';

class Splashscrem extends StatefulWidget {
  Splashscrem({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<Splashscrem> {
  late final MediaQueryData mediaQueryData;
  @override
  Widget build(BuildContext context) {
    //  throw UnimplementedError();
    return initWidget();
  }

  @override
  void initState() {
    super.initState();
    InicioTempo();
  }

  //Função do tempo
  InicioTempo() async {
    var duracao = Duration(seconds: 3);
    return new Timer(duracao, loginRoute);
  }

  loginRoute() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginTela()),
    );
  }

  //função init widget
  Widget initWidget() {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
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
                "assets/images/logo.png",
                color: Colors.white,
                scale: 0.6,
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 220, left: 50, right: 152),
                child: Text(
                  'OPECA'.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                      //Estilização do texto da tela de login "Login"
                      ),
                ),
              ))
        ],
      ),
    );
  }
}
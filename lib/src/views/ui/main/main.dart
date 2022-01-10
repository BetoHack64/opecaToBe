import 'dart:async';

import 'package:SOP/src/business_logic/blocs/main/events/mainEvent.dart';
import 'package:SOP/src/business_logic/blocs/main/mainBloc.dart';
import 'package:SOP/src/business_logic/blocs/main/states/mainState.dart';
import 'package:SOP/src/views/ui/login/logar.dart';
import 'package:flutter/material.dart';
import 'package:SOP/src/views/ui/main/dashboard.dart';
//import 'package:SOP/listaAprovacoes.dart';
import 'package:SOP/src/views/ui/Header/my_header_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool estaLogado = false;
bool isRunning = false;
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (estaLogado == true) ? Home() : LoginScreem(),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  //carrega os dados do usuario

  _carregaDados() async {
    final result = await pegaDados().then((bool result) {
      setState(() {
        estaLogado = result;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    //carrega os dados do usuario ao se abrir a view
    _carregaDados();

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isRunning = true;
      });
    });
  }

  //Obtem os dados partilhados do usuario
  Future<bool> pegaDados() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return (sharedPreferences.getBool("isLoggedIn") ?? false);
  }

  partilha() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.commit();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreem()),
        (Route<dynamic> route) => false);
  }

  var currentPage = DrawerSections.dashboard;
  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = Dashboard1();
    } else if (currentPage == DrawerSections.logout) {
      partilha();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Portal de Operações'),
        backgroundColor: Colors.red[900],
        centerTitle: true,
      ),
      backgroundColor: Colors.white, //
      body: BlocBuilder<MainBloc, MainState>(
        bloc: BlocProvider.of<MainBloc>(context),
        builder: (context, state) {
          if (state is MainOpeningState) {
            if (isRunning == true) {
              BlocProvider.of<MainBloc>(context)
                  .add(MainGetConnectionSuccess());
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.red[900]),
                ),
              );
            }
          }
          if (state is MainNetworkErrorOpeningState) {
            return Center(child: Text(state.message));
          }
          if (state is MainProcessedState) {
            return container;
          }
          return Text("");
        },
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                myDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        children: [
          menuItem(1, "Home", Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Sair", Icons.exit_to_app,
              currentPage == DrawerSections.logout ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String titulo, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.logout;
            }
          });
        },
        splashColor: Colors.amber,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  titulo,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections { dashboard, logout }

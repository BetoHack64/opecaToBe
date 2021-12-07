import 'package:flutter/material.dart';
import 'package:opeca_app/dashboard.dart';
import 'package:opeca_app/Authentication/login.dart';
//import 'package:opeca_app/listaAprovacoes.dart';
import 'package:opeca_app/Header/my_header_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool estaLogado = false;
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (estaLogado == true) ? Home() : LoginTela(),
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
        MaterialPageRoute(builder: (context) => LoginTela()),
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
        title: Text('SOP'),
        backgroundColor: Colors.red[900],
        centerTitle: true,
      ),
      backgroundColor: Colors.white, //
      body: container,
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
          menuItem(1, "Dashboard", Icons.dashboard_outlined,
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

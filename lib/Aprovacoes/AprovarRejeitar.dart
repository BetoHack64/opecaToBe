import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:opeca_app/Aprovacoes/anexos.dart';
import 'package:opeca_app/caixaPesquisaAnimacao.dart';
import 'package:opeca_app/dashboard.dart';
import 'package:opeca_app/Aprovacoes/detalhes.dart';
import 'package:opeca_app/Aprovacoes/itemsLista.dart';
import 'package:opeca_app/Aprovacoes/listaAprovacoes.dart';
import 'package:opeca_app/Home/main.dart';
import 'package:opeca_app/Header/my_header_drawer.dart';
import 'package:opeca_app/validacao.dart';
//import 'constant.dart';

String traco = ' - ';
String nome = '';
String id = '';
bool botaoHomeAparece = true;
bool botao = false;
void main() {
  runApp(AprovarRejeitar(nome, id, botaoHomeAparece));
}

class AprovarRejeitar extends StatelessWidget {
  AprovarRejeitar(String sistema, String idOp, bool btnAparece) {
    nome = sistema;
    id = idOp;
    botaoHomeAparece = btnAparece;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*title: 'OpecaA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),*/
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var currentPage = null;
  bool menu = false;
  int seleteposition = 2;
  @override
  Widget build(BuildContext context) {
    String tr = traco;
    void _selecionaSistema(BuildContext context) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return Home();
          },
        ),
      );
    }

    var container;
    if (currentPage == DrawerSections.dashboard) {
      nome = '';
      traco = '';
      botaoHomeAparece = false;
      container = Dashboard1();
    } else if (currentPage == DrawerSections.logout) {
      //container = LoginTela();
    }
    print(traco);
    return Scaffold(
      /*floatingActionButton: FloatingActionButton(
        //Floating action button on Scaffold
        onPressed: () {
          //code to execute on button press
        },
        child: Icon(Icons.format_list_bulleted),
        backgroundColor: Colors.grey[800], //icon inside button
      ),*/
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: Colors.red[900],
        title: Text('SOP' + " - " + nome),
        centerTitle: true,
        actions: [
          botaoHomeAparece
              ? IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.attach_file),
                )
              : Text(""),
        ],
      ),
      /*bottomNavigationBar: BottomAppBar(
        //bottom navigation bar on scaffold
        color: Colors.red[900],
        shape: CircularNotchedRectangle(), //shape of notch
        notchMargin:
            5, //notche margin between floating button and bottom appbar
        child: Row(
          //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 60),
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 65),
              child: IconButton(
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),*/
      body: container,
      floatingActionButton: botaoHomeAparece
          ? FabCircularMenu(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _selecionaSistema(context);
                  },
                ),
                IconButton(
                    icon: Icon(
                      Icons.list_alt_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return ListaAprovacoes(nome, " - ", true);
                          },
                        ),
                      );
                    }),
              ],
              fabColor: Colors.red[900],
              ringColor: Colors.grey[800],
              ringDiameter: 330.56,
              fabElevation: 12.0,
              fabOpenColor: Colors.white,
              fabCloseColor: Colors.white,
              fabOpenIcon: Icon(Icons.apps),
              fabSize: 60,
            )
          : null,
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
        splashColor: Colors.black,
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

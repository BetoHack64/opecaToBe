import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opeca_app/Models/ApiJsonToObject.dart';
import 'package:opeca_app/caixaPesquisaAnimacao.dart';
import 'package:opeca_app/dashboard.dart';
import 'package:opeca_app/itemsLista.dart';
import 'package:opeca_app/Home/main.dart';
import 'package:opeca_app/my_header_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
//import 'constant.dart';

String traco = ' - ';
String nome = '';
String id = '0';
bool botaoHomeAparece = true;
List<CardDetail> cardss = [];
void main() {
  runApp(ListaAprovacoes(nome, traco, botaoHomeAparece));
}

class ListaAprovacoes extends StatelessWidget {
  buscaOperacoes(String sis) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(
        'http://83.240.225.239:130/api/Operation?ApplicationID=51000000');
    var token = (sharedPreferences.getString("access_token") ?? "");
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    var jsonResponse;
    var response = await http.get(url, headers: header);
    Map mapResponse = json.decode(response.body);
    Map userMap = jsonDecode(response.body);

    //print(userMap['OperationList'][0]['Area']);
    //print(sis);
    if (userMap != null) {
      /*for (var item in userMap['OperationList']) {
        if (item['Area'] == sis) {
          cardss.add(
            CardDetail(
                title: item['Operation'],
                subtitle: item['Date'],
                valor: item['ValueOperation']),
          );
        }
      }*/
    } else {
      print('Bug');
    }
  }

  ListaAprovacoes(String sistema, String trac, bool botaoAparece) {
    nome = sistema;
    traco = trac;
    botaoHomeAparece = botaoAparece;
    buscaOperacoes(sistema);
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

class CardDetail {
  String title;
  String subtitle;
  String valor;

  CardDetail(
      {required this.title, required this.subtitle, required this.valor});
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var currentPage = null;
  final List<CardDetail> cards = cardss;

  @override
  Widget build(BuildContext context) {
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
      traco = '';
      nome = '';
      botaoHomeAparece = false;
      container = Dashboard1();
    } else if (currentPage == DrawerSections.logout) {
      //container = LoginTela();
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: botaoHomeAparece
          ? FloatingActionButton(
              //Floating action button on Scaffold
              onPressed: () {
                
                _selecionaSistema(context);
                //code to execute on button press
              },
              child: Icon(
                Icons.home,
                color: Colors.grey,
              ),
              backgroundColor: Colors.white, //icon inside button
              elevation: 10.0,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red[900],
        title: Text('SOP' + traco + nome),
        centerTitle: true,
      ),
      body: (container == null)
          ? Column(
              children: [
                CaixaPesquisaAnimacao(),
                Expanded(
                  flex: 360,
                  child: ListView.builder(
                    itemCount: cards.length,
                    itemBuilder: (context, index) => ItemsLista(
                      title: cards[index].title,
                      subtitle: "Fornecedor",
                      sistema: nome,
                      id: id,
                      data: cards[index].subtitle,
                      valor: cards[index].valor.toString(),
                    ),
                  ),
                ),
              ],
            )
          : container,
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

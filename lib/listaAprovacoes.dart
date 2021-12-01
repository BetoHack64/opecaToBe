import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opeca_app/caixaPesquisaAnimacao.dart';
import 'package:opeca_app/dashboard.dart';
import 'package:opeca_app/itemsLista.dart';
import 'package:opeca_app/main.dart';
import 'package:opeca_app/my_header_drawer.dart';
//import 'constant.dart';

String traco = ' - ';
String nome = '';
String id = '0';
bool botaoHomeAparece = true;
void main() {
  runApp(ListaAprovacoes(nome, traco, botaoHomeAparece));
}

class ListaAprovacoes extends StatelessWidget {
  ListaAprovacoes(String sistema, String trac, bool botaoAparece) {
    nome = sistema;
    traco = trac;
    botaoHomeAparece = botaoAparece;
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
  double valor;

  CardDetail(
      {required this.title, required this.subtitle, required this.valor});
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var currentPage = null;
  final List<CardDetail> cards = [
    CardDetail(title: 'Orc. Alteracoes', subtitle: '04-11-2021', valor: 1500000),
    CardDetail(title: 'Encomenda', subtitle: '01-09-2021', valor: 1600000),
    CardDetail(title: 'Encomenda', subtitle: '30-08-2021', valor: 4000000),
    CardDetail(title: 'Pagamento', subtitle: '27-08-2021', valor: 1700000),
    CardDetail(title: 'Pagamento', subtitle: '27-08-2021', valor: 1500000),
    CardDetail(title: 'Encomenda', subtitle: '27-08-2021', valor: 1505000),
  ];

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

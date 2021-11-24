import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opeca_app/caixaPesquisaAnimacao.dart';
import 'package:opeca_app/dashboard.dart';
import 'package:opeca_app/itemsLista.dart';
import 'package:opeca_app/my_header_drawer.dart';
import 'constant.dart';

String nome = '';
void main() {
  runApp(ListaAprovacoes(nome));
}

class ListaAprovacoes extends StatelessWidget {
  ListaAprovacoes(String sistema) {
    nome = sistema;
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
    CardDetail(
        title: 'Orc. Alteracoes', subtitle: '2021-11-04', valor: 1500000),
    CardDetail(title: 'Encomenda', subtitle: '2021-09-01', valor: 1600000),
    CardDetail(title: 'Encomenda', subtitle: '2021-08-30', valor: 4000000),
    CardDetail(title: 'Pagamento', subtitle: '2021-08-27', valor: 1700000),
    CardDetail(title: 'Pagamento', subtitle: '2021-08-27', valor: 1500000),
    CardDetail(title: 'Encomenda', subtitle: '2021-08-27', valor: 1505000),
  ];

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = Dashboard1();
    } else if (currentPage == DrawerSections.logout) {
      //container = LoginTela();
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: Text('Opeca - ' + nome),
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
                      title: cards[index].title +
                          ' - ' +
                          cards[index].valor.toString() +
                          ' akz',
                      subtitle: cards[index].subtitle,
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

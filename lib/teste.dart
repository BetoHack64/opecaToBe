import 'package:flutter/material.dart';
import 'package:opeca_app/dashboard.dart';
import 'package:opeca_app/listaAprovacoes.dart';
import 'package:opeca_app/my_header_drawer.dart';

class GridDashboard extends StatefulWidget {
  @override
  GridDashboardState createState() => new GridDashboardState();
}

class GridDashboardState extends State<GridDashboard> {
  var currentPage = DrawerSections.dashboard;
  void _selecionaSistema(BuildContext context) {
    /*Navigator.of(context).pushReplacement(
     /* MaterialPageRoute(
        /*builder: (context) {
         // return ListaAprovacoes("teste");
        },*/
      ),*/
    );*/
  }

  Items item1 = new Items(
      title: "SOP SAL",
      subtitle: "Salário Cobrança",
      event: "1",
      img: "assets/images/money-transfer-100.png");
  Items item2 = new Items(
    title: "SGCD",
    subtitle: "Gestão Créditos",
    event: "7",
    img: "assets/images/donate-50.png",
  );
  Items item3 = new Items(
    title: "SGC",
    subtitle: "Compras Crédito",
    event: "1",
    img: "assets/images/icons8-basket-50.png",
  );
  Items item4 = new Items(
    title: "MD",
    subtitle: "Mediation",
    event: "8",
    img: "assets/images/synchronize.png",
  );
  Items item5 = new Items(
    title: "ACR",
    subtitle: "Accrual",
    event: "4",
    img: "assets/images/calculator-50.png",
  );
  Items item6 = new Items(
    title: "SGFM",
    subtitle: "Compra Dinheiro",
    event: "4",
    img: "assets/images/money-bag-50.png",
  );
  Items item7 = new Items(
    title: "ADM",
    subtitle: "Administração",
    event: "4",
    img: "assets/images/group-64.png",
  );
  Items item8 = new Items(
    title: "SGP",
    subtitle: "Gestão Património",
    event: "4",
    img: "assets/images/swatchbook.png",
  );
  Items item9 = new Items(
    title: "SOPMN",
    subtitle: "Operações MN",
    event: "4",
    img: "assets/images/money-transfer.png",
  );
  Items item10 = new Items(
    title: "MMF",
    subtitle: "Meios Físicos",
    event: "4",
    img: "assets/images/money-transfer.png",
  );
  Items item11 = new Items(
    title: "SGL",
    subtitle: "Gestão Liquidez",
    event: "4",
    img: "assets/images/money-transfer.png",
  );
  Items item12 = new Items(
    title: "SCT",
    subtitle: "Contabilidade",
    event: "4",
    img: "assets/images/money-transfer.png",
  );

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = Dashboard1();
    } else if (currentPage == DrawerSections.logout) {
      //container = ListaAprovacoes("");
    }
    List<Items> myList = [
      item1,
      item2,
      item3,
      item4,
      item5,
      item6,
      item7,
      item8,
      item9,
      item10,
      item11,
      item12
    ];
    var color = 0xffEf5350;
    return Scaffold(
      appBar: AppBar(
        title: Text('Opeca'),
        backgroundColor: Colors.red,
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
          menuItem(2, "Contactos", Icons.exit_to_app,
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

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items(
      {required this.title,
      required this.subtitle,
      required this.event,
      required this.img});
}

enum DrawerSections { dashboard, logout }

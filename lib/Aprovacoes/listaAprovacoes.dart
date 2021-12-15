import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:SOP/caixaPesquisaAnimacao.dart';
import 'package:SOP/dashboard.dart';
import 'package:SOP/Aprovacoes/itemsLista.dart';
import 'package:SOP/Home/main.dart';
import 'package:SOP/Header/my_header_drawer.dart';
//import 'constant.dart';

String traco = ' - ';
String nome = '';
String id = '0';

List<CardDetail> _foundUsers = [];
bool botaoHomeAparece = true;
bool caixaDePesquisaEstaVisivel = false;
List<CardDetail> cardss = [];
void main() {
  runApp(ListaAprovacoes(nome, traco, cardss, botaoHomeAparece));
}

class ListaAprovacoes extends StatefulWidget {
  ListaAprovacoes(
      String sistema, String trac, List<CardDetail> lista, bool botaoAparece) {
    nome = sistema;
    traco = trac;
    botaoHomeAparece = botaoAparece;
    cardss = lista;
    //print(cardss);
  }

  @override
  State<ListaAprovacoes> createState() => _ListaAprovacoesState();
}

class _ListaAprovacoesState extends State<ListaAprovacoes> {
  @override
  void initState() {
    /*_getThingsOnStartup().then((value){
      print('Async done');
      
    });*/
    //buscaOperacoes();
    super.initState();
    //buscaOperacoes(nome);
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
  CardDetail(
      {required this.title,
      required this.subtitle,
      required this.valor,
      required this.fornecedor,
      required this.id,
      required this.moeda});

  String fornecedor;
  String id;
  String moeda;
  String subtitle;
  String title;
  String valor;
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<CardDetail> cards = cardss;
  var currentPage = null;
  bool estaVisivelCaixaPesquisa = false;
// This list holds the data for the list view
  List<CardDetail> _foundUsers = [];

  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = cards;
    super.initState();
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

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<CardDetail> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = cards;
    } else {
      results = cards.where((card) {
        return card.title
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()) ||
            card.subtitle
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()) ||
            card.fornecedor
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()) ||
            card.valor.toLowerCase().contains(enteredKeyword.toLowerCase());
      }).toList();
      //toLowerCase().contains((enteredKeyword.toLowerCase()))
      //.toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

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
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (caixaDePesquisaEstaVisivel) {
                  caixaDePesquisaEstaVisivel = false;
                } else {
                  caixaDePesquisaEstaVisivel = true;
                }
              });
            },
            icon: Icon(
              Icons.search,
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: (container == null)
          ? Column(
              children: [
                Container(
                  color: Colors.grey[50],
                  child: Center(
                    child: Container(
                      height: 90.0,
                      width: 250.0,
                      alignment: Alignment(-1.0, 0.0),
                      child: caixaDePesquisaEstaVisivel
                          ? AnimatedContainer(
                              duration: Duration(milliseconds: 375),
                              height: 48.0,
                              width: (toggle == 0) ? 48.0 : 250.0,
                              curve: Curves.easeOut,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      spreadRadius: -10.0,
                                      blurRadius: 10.0,
                                      offset: Offset(-4.0, 10.0),
                                    ),
                                  ]),
                              child: Stack(
                                children: [
                                  AnimatedPositioned(
                                    duration: Duration(milliseconds: 375),
                                    left: (toggle == 0) ? 20.0 : 40.0,
                                    top: 13.0,
                                    curve: Curves.easeOut,
                                    child: AnimatedOpacity(
                                      opacity: (toggle == 0) ? 0.0 : 1.0,
                                      duration: Duration(milliseconds: 200),
                                      child: Container(
                                        height: 23.0,
                                        width: 200.0,
                                        child: TextField(
                                          onChanged: (valor) =>
                                              _runFilter(valor),
                                          cursorRadius: Radius.circular(10.0),
                                          cursorWidth: 2.0,
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            labelText: 'Procurar...',
                                            labelStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            alignLabelWithHint: true,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Material(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {});
                                      },
                                      icon: Image.asset(
                                        'assets/images/search.png',
                                        height: 18.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.only(top: 29),
                              child: Center(
                                  child: Column(
                                children: [
                                  Text(
                                    "LISTA DE OPERAÇÕES",
                                    textScaleFactor: 1.4,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    "Selecione a operação",
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              )),
                            ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 360,
                  child: _foundUsers.isNotEmpty
                      ? ListView.builder(
                          itemCount: _foundUsers.length,
                          itemBuilder: (context, index) => ItemsLista(
                            title: _foundUsers[index].title,
                            subtitle: _foundUsers[index].fornecedor,
                            sistema: nome,
                            id: _foundUsers[index].id,
                            data: _foundUsers[index].subtitle,
                            valor: _foundUsers[index].valor.toString(),
                            moeda: _foundUsers[index].moeda,
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(bottom: 130),
                          child: Center(
                            child: const Text(
                              'Nenhum resultado encontrado.',
                              style: TextStyle(fontSize: 20),
                            ),
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
}

enum DrawerSections { dashboard, logout }

import 'package:SOP/src/business_logic/services/api_services/FuncoesAPI.dart';
import 'package:SOP/src/views/ui/Header/my_header_drawer.dart';
import 'package:SOP/src/views/ui/Lista_Aprovacoes/listaAprovacoes.dart';
import 'package:SOP/src/views/ui/main/dashboard.dart';
import 'package:SOP/src/views/ui/main/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'hom_modal.dart';
//import 'constant.dart';

String traco = ' - ';
String nome = '';
String id = '';
String valor = '';
String tit = ''; //referen descrição da operação
String cont = '';
String dataO = '';
String cash = '';
List<CardDetail> listaDeOperacoes = [];

bool botaoHomeAparece = true;

bool botao = false;
void main() {
  runApp(AprovarRejeitar(nome, id, valor, botaoHomeAparece, tit, dataO, cash));
}

class AprovarRejeitar extends StatelessWidget {
  AprovarRejeitar(String sistema, String idOp, String valorOficio,
      bool btnAparece, String title, String data, String moeda) {
    nome = sistema;
    id = idOp;
    valor = valorOficio;
    botaoHomeAparece = btnAparece;
    tit = title;
    dataO = data;
    cash = moeda;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  initState() {
    super.initState();
    FuncoesAPI.buscaOperacoes(0,1001).then((value) {
      listaDeOperacoes = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    String tr = traco;
    final larg = MediaQuery.of(context).size.width;
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    //print(valor);
    void _selecionaSistema(BuildContext context) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return Home();
          },
        ),
      );
    }

    //Retornar a Detalhes de Operaçõesvoid
    void _retornaPaginaDetalhe(BuildContext context, String sistema) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            // applicationDetailItems = [];
            return ListaAprovacoes(sistema, traco, listaDeOperacoes, true);
          },
        ),
      );
    }

    void _retornaLista(BuildContext context, String sistema) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            // applicationDetailItems = [];
            return ListaAprovacoes(sistema, traco, listaDeOperacoes, true);
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
    //print(traco);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: Colors.red[900],
        title: Text(
          '${nome} - ${tit} ${id}', // ${id}
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
        centerTitle: true,
        actions: [
          //Center(child: Text('Anexos')),
          botaoHomeAparece
              ? IconButton(
                  onPressed: () => _retornaLista(context, nome),
                  icon: Icon(Icons.list_alt_outlined),
                )
              : Text(""),
        ],
      ),

      body: (container == null)
          ?
          //Design do Conteúdo toda descrição da operaçã à aprovar ou rejeitar
          Container(
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  //Informação de cabeçalho
                  /* Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      "${nome} - ${tit}".toUpperCase(),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Open Sans"),
                    ),
                  )),*/

                  /* Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 30,
                        bottom: 3,
                        //left: 10,
                      ),
                      child: Text(
                        "${id} ".toUpperCase(),
                        style: TextStyle(
                            color: Colors.red[900],
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Open Sans"),
                      ),
                    ),
                  ),*/
//Fim da Informação de Cabeçalho

//Informação de Tipo Operação
                  /*  Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: 3, bottom: 16),
                    child: Text(
                      "${tit}".toUpperCase(), //Nome Ope
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Open Sans"),
                    ),
                  )),*/
//Fim informação de Operação

//Fim informação de Operação

                  //Texto IconData
                  /*  Padding(
            padding: EdgeInsets.only(left: 17),
            child: Text("14.000.000,00 AKZ",
                style:TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Open Sans",
                      ),
            ),
            
          ),*/

//texto ID Fim
//Texto IconData
                  /* Padding(
                    padding: EdgeInsets.only(
                        top: 0,
                        bottom: 10,
                        left: MediaQuery.of(context).size.width - 160),
                    child: Text(
                      "ID: ${id}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Open Sans"),
                    ),
                  ),*/

//texto ID Fim

                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 18,
                        // bottom: 12,
                        //left: 10,
                      ),
                      child: Text(
                        "Toneca - Serviços Assistencia Técnica".toUpperCase(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Open Sans"),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  //Fim divisão Operação
                  Card(
                    // Inicia Aqui o 1º card com a  informação referente ao numero da conta
                    elevation: 5.0,
                    margin: new EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.02,
                        vertical: MediaQuery.of(context).size.height * 0.01),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Color.fromARGB(0, 0, 0, 0)),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 0.0),
                        /*  leading: Container(
                          padding: EdgeInsets.only(right: 12.0),
                          decoration: new BoxDecoration(
                              border: new Border(
                                  right: new BorderSide(
                                      width: 1.0, color: Colors.white24))),
                          child: Icon(Icons.open_with_sharp,
                              color: Colors.red[900]),
                        ),*/
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //aqui irei colocar todos os widgets q farão parte dos detalhes
                            Container(
                              margin: EdgeInsets.only(right: 0, left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 4,
                                      bottom: 6,
                                      //left: 20,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 1),
                                          child: Text(
                                            "Valor ",
                                            //textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                                fontSize: 15,
                                                //fontWeight: FontWeight.bold,
                                                fontFamily: "Open Sans"),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 6),
                                          child: Text(
                                            " ${valor}  ${cash}",
                                            //textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                                fontSize: 17,
                                                //fontWeight: FontWeight.bold,
                                                fontFamily: "Open Sans"),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 6),
                                          child: Text(
                                            "Data ",
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                                fontSize: 15,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: "Open Sans"),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 6),
                                          child: Text(
                                            "${dataO} ",
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                                fontSize: 17,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: "Open Sans"),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 6),
                                          child: Text(
                                            "Orçamento ",
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                                fontSize: 15,
                                                //fontWeight: FontWeight.bold,
                                                fontFamily: "Open Sans"),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 6),
                                          child: Text(
                                            "1.0000.9876 AKZ",
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                                fontSize: 17,
                                                //fontWeight: FontWeight.bold,
                                                fontFamily: "Open Sans"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  ///VALOR

                                  //Sess

                                  ///
                                ],
                              ),
                            ),

                            Divider(
                              color: Colors.black,
                            ),
                            /* Padding(
                              padding: EdgeInsets.only(
                                top: 4,
                                bottom: 10,
                                left: 10,
                              ),
                              child: Text(
                                "Produtos Adquiridos".toUpperCase(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Open Sans"),
                              ),
                            ),*/

                            Container(
                              margin: EdgeInsets.only(right: 0, left: 35),
                              width: double.infinity,
                              child: Table(
                                // border: TableBorder.all(
                                //     color: Colors.black, width: 1.0, style: BorderStyle.solid),
                                border: TableBorder.symmetric(
                                    inside: BorderSide(
                                        width: 0.01, color: Colors.white)),
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                columnWidths: {
                                  0: FlexColumnWidth(0.1),
                                  1: FlexColumnWidth(0.1),
                                },
                                children: [
                                  TableRow(children: [
                                    Text(
                                      "Hack",
                                      //textScaleFactor: 1.2,
                                      //textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 14,
                                          //fontWeight: FontWeight.bold,
                                          fontFamily: "Open Sans"),
                                    ),
                                    Text(
                                      "3.000.000,00 AKZ",
                                      // textScaleFactor: 1.2,
                                      //textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 14,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: "Open Sans"),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Text(
                                      "PC DELL",
                                      // textScaleFactor: 1.2,
                                      // textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 14,
                                          fontFamily: "Open Sans"),
                                    ),
                                    Text(
                                      "10.000,00 AKZ".toString(),
                                      //textScaleFactor: 1.2,
                                      // textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 14,
                                          fontFamily: "Open Sans"),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Text(
                                      "Telefones",
                                      //textAlign: TextAlign.center,
                                      //textScaleFactor: 1.2,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 14,
                                          fontFamily: "Open Sans"),
                                    ),
                                    Text(
                                      "10.000,00 AKZ".toString(),
                                      //textScaleFactor: 1.3,
                                      // textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 14,
                                          fontFamily: "Open Sans"),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ), //makeListTile,
                    ), // termina Aqui o 1º card com a  informação referente ao numero da conta
                  ),

                  //Card com informações dos produtos

                  /*Divider(
                    color: Colors.black,
                  ),*/
                  //Fim Divisão
                  //Botões para aceitar e rejeitar

                  //   _botaoAprovar(),
                  //  _botaoRejeitar()
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // mainAxisSpacing: MainAxisSpacing.right,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 200,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 50, //altura do button
                                  width: 100, //Largura button
                                  child: ElevatedButton(
                                    child: Text('Aprovar'.toUpperCase()),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        //side: BorderSide(color: Colors.red)
                                      ),
                                      primary: Colors.green,
                                      onPrimary: Colors.white,
                                      onSurface: Colors.grey,
                                    ),
                                    onPressed: () {
                                      print('Aprovar'.toUpperCase());
                                    },
                                  ),
                                ),
                              ),
                              //Fim botão aprovar
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 50, //altura do button
                                  width: 100, //Largura button
                                  child: ElevatedButton(
                                    child: Text('Rejeitar'.toUpperCase()),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        //side: BorderSide(color: Colors.red)
                                      ),
                                      primary: Colors.red[900],
                                      onPrimary: Colors.white,
                                      onSurface: Colors.grey,
                                    ),
                                    onPressed: () {
                                      print('Rejeitar'.toUpperCase());
                                    },
                                  ),
                                ),
                              ),
                              //Fim btn rejeitar
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 50, //altura do button
                                  width: 100, //Largura button
                                  child: ElevatedButton(
                                    child: Text('Anexos'.toUpperCase()),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        //side: BorderSide(color: Colors.red)
                                      ),
                                      primary: Colors.grey,
                                      onPrimary: Colors.white,
                                      onSurface: Colors.grey,
                                    ),
                                    onPressed: () {
                                      showMaterialModalBottomSheet(
                                        context: context,
                                        builder: (context) =>
                                            HomeModal(tit, nome),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Fim dos botões
                ],
              ),
            )
          /*
      Center(child: Text('Teste')
      )*/
          //Fim do Conteúdo
          : container,
      floatingActionButton:
          botaoHomeAparece ? null : null, //Desenha o Dash lateral esquerdo
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

//Botão Aprovar
  _botaoAprovar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      width: double.infinity,
      margin: const EdgeInsets.only(right: 130, left: 130),
      child: SizedBox(
        height: 60, //altura do button
        width: 20, //Largura button
        child: ElevatedButton(
          //  elevation: 5.0,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              //side: BorderSide(color: Colors.red)
            ),
            primary: Colors.green, // background
            onPrimary: Colors.white, // foreground
          ),
          onPressed: () {
            print("Aprovar");
          },

          child: Text("APROVAR",
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  ///Botão Rejeitar
  _botaoRejeitar() {
    return Container(
      padding: EdgeInsets.all(0),
      width: double.infinity,
      margin: const EdgeInsets.only(right: 130, left: 130),
      child: SizedBox(
        height: 60, //altura do button
        width: 20, //Largura button
        child: ElevatedButton(
          //  elevation: 5.0,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              //side: BorderSide(color: Colors.red)
            ),
            primary: Colors.red[900], // background
            onPrimary: Colors.white, // foreground
          ),
          onPressed: () {
            print("Rejeitar");
          },

          child: Text("REJEITAR",
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

enum DrawerSections { dashboard, logout }

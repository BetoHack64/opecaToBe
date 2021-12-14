import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opeca_app/Aprovacoes/listaAprovacoes.dart';
import 'package:opeca_app/Home/main.dart';
import 'package:opeca_app/Header/my_header_drawer.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../dashboard.dart';
import 'hom_modal.dart';
//import 'constant.dart';

String traco = ' - ';
String nome = '';
String id = '';
String valor = '';
String tit='';//referen descrição da operação
String cont='';
String dataO='';
String cash='';

bool botaoHomeAparece = true;

bool botao = false;
void main() {
  runApp(AprovarRejeitar(nome, id,valor, botaoHomeAparece,tit,dataO,cash));
}

class AprovarRejeitar extends StatelessWidget {
  AprovarRejeitar(String sistema, String idOp,String valorOficio, bool btnAparece,String title,String data,String moeda) {
    nome = sistema;
    id = idOp;
    valor = valorOficio;
    botaoHomeAparece = btnAparece;
    tit=title;
    dataO=data;
    cash=moeda;
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
  Widget build(BuildContext context) {
    String tr = traco;
    print(valor);
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
                  onPressed: () {
                    showMaterialModalBottomSheet(context: context, builder:(context)=>HomeModal(tit),
                    );
                  },
                  icon: Icon(Icons.attach_file),
                )
              : Text(""),
        ],
      ),
      
      
      body: (container == null)? 
      //Design do Conteúdo toda descrição da operaçã à aprovar ou rejeitar
   Container(
     
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          //Informação de cabeçalho
         Center(
           child:  
           Padding(
             padding: EdgeInsets.only(top: 16,bottom: 8),
             child: Text("DETALHES DA OPERAÇÃO".toUpperCase(),
            style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
          ),
           )
         ),
//Fim da Informação de Cabeçalho

//Informação de Tipo Operação
  Center(
           child:  
           Padding(
             padding: EdgeInsets.only(top: 3,bottom: 16),
             child: Text("${tit}".toUpperCase(),//Nome Ope
            style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
          ),
           )
         ),
//Fim informação de Operação

 Center(
           child:  
           Padding(
             padding: EdgeInsets.only(top: 3,bottom: 16),
             child: Text("VAL. ${valor}  ${cash}" .toUpperCase(),
            style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.red[900],
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
          ),
           )
         ),
//Fim informação de Operação

         //Texto IconData
    /*  Padding(
            padding: EdgeInsets.only(left: 17),
            child: Text("14.000.000,00 AKZ",
                style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
            ),
            
          ),*/

//texto ID Fim
//Texto IconData
      Padding(
            padding: EdgeInsets.only(top: 2,bottom: 10,left: 250),
            child: Text("ID: ${id}",
                style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.red[900],
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
            ),
            
          ),

//texto ID Fim


          Card(
            // Inicia Aqui o 1º card com a  informação referente ao numero da conta
            elevation: 3.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(0, 0, 0, 0)
          ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.perm_identity, color: Colors.red[900]),
        ),
        title: Text(
          "Conta : 00127812334",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        

        

        ),//makeListTile,
      ),// termina Aqui o 1º card com a  informação referente ao numero da conta
          ),


   Card(
            // Inicia Aqui o 1º card com a  informação referente ao numero da conta
            elevation: 3.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(0, 0, 0, 0)
          ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.recent_actors, color: Colors.red[900]),
        ),
        title: Text(
          "Ordenante. : Academia Militar",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        

        

        ),//makeListTile,
      ),// termina Aqui o 1º card com a  informação referente ao numero da conta
          ),


   Card(
            // Inicia Aqui o 1º card com a  informação referente ao numero da conta
            elevation: 3.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(0, 0, 0, 0)
          ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.open_with_sharp, color: Colors.red[900]),
        ),
        title: Text(
          "Ref. Ofício : 20248",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
         ),//makeListTile,
      ),// termina Aqui o 1º card com a  informação referente ao numero da conta
          ),

          //Data do Ofício
 Card(
            // Inicia Aqui o 1º card com a  informação referente ao numero da conta
            elevation: 3.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(0, 0, 0, 0)
          ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.date_range_sharp, color: Colors.red[900]),
        ),
        title: Text(
          "Data Ofício : ${dataO}",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
         ),//makeListTile,
      ),// termina Aqui o 1º card com a  informação referente ao numero da conta
          ),

          //Fim Data Ofício
        
        //Tipo Salario de

 Card(
            // Inicia Aqui o 1º card com a  informação referente ao numero da conta
            elevation: 3.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(0, 0, 0, 0)
          ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.payment_sharp, color: Colors.red[900]),
        ),
        title: Text(
          "Tipo Salário : Sub Ferias",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        
//----------------Fim
/*subtitle: Row(
          children: <Widget>[
            Icon(Icons.date_range_rounded, color: Colors.red),
            Text(" Agosto/2020", style: TextStyle(color: Colors.grey))
          ],
        ),*/
//-----------

         ),
         //makeListTile,
      ),
      // termina Aqui o 1º card com a  informação referente ao numero da conta
          ),
          
        //---Fim tipo salário


        //Card mês Processamento

 Card(
            // Inicia Aqui o 1º card com a  informação referente ao numero da conta
            elevation: 3.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(0, 0, 0, 0)
          ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.date_range, color: Colors.red[900]),
        ),
        title: Text(
          "Mês Processamento : Agosto/2020",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
         ),//makeListTile,
      ),// termina Aqui o 1º card com a  informação referente ao numero da conta
          ),
        //Fim Card Mês Processamento


         //Botões para aceitar e rejeitar
          Row(
           
              mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    
    FlatButton(
      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(color: Colors.red)
        ),
      color: Colors.red[900],
      textColor: Colors.white,
      padding: EdgeInsets.all(10.0),
      onPressed: () {
        print("Rejeitado");
      },
      child: Text(
        "Rejeitar".toUpperCase(),
        style: TextStyle(
          fontSize: 14.0,
        ),
      ),
    ),
    SizedBox(width: 20),
    RaisedButton(
     // padding: EdgeInsets.only(left: 20, right:20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(color: Colors.green)),
      onPressed: () {
        print("Aprovado");
      },
      color: Colors.green,
      textColor: Colors.white,
      child: Text("Aprovar".toUpperCase(),
        style: TextStyle(fontSize: 14)),
    ),
  ],   
          ),
    //Fim dos botões
        ],
        
      ),
    )
      /*
      Center(child: Text('Teste')
      )*/
      //Fim do Conteúdo
      :container,
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
                            return ListaAprovacoes(nome, " - ",[],true);
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
          : null,//Desenha o Dash lateral esquerdo
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

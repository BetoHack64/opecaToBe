import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
String titulo='';
class HomeModal extends StatefulWidget {

  HomeModal(String titu){
          titulo=titu;
  }
  @override
  _HomeModalState createState() => _HomeModalState();
}

class _HomeModalState extends State<HomeModal> {
  bool _isLoading=false;
  

  

  void _onLoading() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new CircularProgressIndicator(),
            new Text("Carregando"),
          ],
        ),
      );
    },
  );
 
}
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(50),
      child: Form(
        child:Column(
          children: [
             Text("anexos DA OPERAÇÃO".toUpperCase(),
            style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
          ),

          //Lista de Arquivos
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
                  right: new BorderSide(width: 1.0, color: Colors.white24)
                  ),
                  ),
          child: Icon(Icons.file_copy, color: Colors.red[900]),
        ),
        title: Text(
          " ${titulo}".toUpperCase(),
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),),),),
          //Final Lista
          DataTable(
            columns: [
              DataColumn(label: Text("Descrição Ficheiro")),
               DataColumn(label: Text("Opção",),
               ),
            ],
            rows: [
              DataRow(cells:[
                DataCell(Text("Factura Recibo")),
                DataCell(
                   RawMaterialButton(
                            onPressed: () {
                              print("Olá");
                            },
                        
                            elevation: 1.0,
                            //fillColor: Colors.white,
                            child: Icon(
                              Icons.remove_red_eye_rounded,
                              color: Colors.red[900],
                              size: 35.0,
                            ),
                            padding: EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                          )
                ),
              ],
              )
            ],
          ),
          ],
        )
      )
    );
  }





}
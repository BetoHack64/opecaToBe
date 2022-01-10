import 'package:SOP/src/views/ui/Detalhes/pdf_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String titulo = '';
String nome = '';

class HomeModal extends StatefulWidget {
  HomeModal(String titu, String nomes) {
    titulo = titu;
    nome = nomes;
  }
  @override
  _HomeModalState createState() => _HomeModalState();
}

class _HomeModalState extends State<HomeModal> {
  bool _isLoading = false;

  _listaFicheiro() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PdfVer(titulo, nome)),
        );
      },
      child: Card(
        // Inicia Aqui o 1º card com a  informação referente ao numero da conta
        elevation: 3.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromARGB(0, 0, 0, 0)),
          child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right:
                          new BorderSide(width: 1.0, color: Colors.white24))),
              child: Icon(Icons.picture_as_pdf, color: Colors.red[900]),
            ),
            title: Text(
              "Factura-Recibo Agosto/2020",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ), //makeListTile,
        ), // termina Aqui o 1º card com a  informação referente ao numero da conta
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(50),
        child: Form(
            child: Column(
          children: [
            /*Text(
              "anexos DA OPERAÇÃO".toUpperCase(),
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Open Sans"),
            ),*/

            //Lista de Arquivos
            Card(
              // Inicia Aqui o 1º card com a  informação referente ao numero da conta
              elevation: 3.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                decoration: BoxDecoration(color: Color.fromARGB(0, 0, 0, 0)),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                      border: new Border(
                          right: new BorderSide(
                              width: 1.0, color: Colors.white24)),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.red[900],
                      ),
                      onPressed: () =>
                          //Navigator.of(context, rootNavigator: true).pop()
                          //Voltar a página que chamou a modal
                          Navigator.of(context).pop(),
                    ),
                  ),
                  title: Text(
                    "${nome} - ${titulo}".toUpperCase(),
                    style: TextStyle(
                        color: Colors.red[900], fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            //Final Lista
            _listaFicheiro()
          ],
        )));
  }
}

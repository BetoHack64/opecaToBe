import 'package:SOP/src/business_logic/models/detalhes.dart';
import 'package:SOP/src/business_logic/services/api_services/FuncoesAPI.dart';
import 'package:SOP/src/views/ui/Detalhes/pdf_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String titulo = '';
String nome = '';
List<Anexo> _anexos = [];

class HomeModal extends StatefulWidget {
  //Antes HomeModal(String titu, String nomes)
  HomeModal(String titu, List<Anexo> anexo) {
    titulo = titu;
    _anexos = anexo;
    //nome = nomes;
  }
  @override
  _HomeModalState createState() => _HomeModalState();
}

class _HomeModalState extends State<HomeModal> {
  @override
  void initState() {
    super.initState();
  }

  String f = '';
  bool _isLoading = false;

  _listaFicheiro(int i, int aux) {
    return GestureDetector(
      onTap: () {
        String fo =
            _anexos[i + 1].data[aux].valor.toString() == 'PDF' ? 'pdf' : 'bug';
        print('aqui Modal');

        // print(nome);
        FuncoesAPI.buscaPdf('2021101000004', '1').then((value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PdfVer(_anexos[i].data[aux].valor,
                    _anexos[i].operationId, _anexos[i].idConteudo, value);
              },
            ),
          );
        });
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
              _anexos[i].data[aux].valor,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Documento anexado'),
            //trailing: Icon(Icons.favorite_outline),
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
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  title: Text(
                    " ${titulo}".toUpperCase(),
                    style: TextStyle(
                        color: Colors.red[900], fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            //Final Lista
            for (int aux = 0; aux < _anexos[0].data.length; aux++)
              if (_anexos[0].data[aux].valor != 'Formato')
                _listaFicheiro(0, aux)
          ],
        )));
  }
}

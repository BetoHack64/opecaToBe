// ignore_for_file: must_be_immutable, unused_field

import 'package:SOP/src/business_logic/models/detalhes.dart';
import 'package:SOP/src/views/ui/Lista_Aprovacoes/expancaoDetalhes.dart';
import 'package:SOP/src/views/ui/Lista_Aprovacoes/expansaoDetalhe.dart';
import 'package:flutter/material.dart';

class ItemsLista extends StatefulWidget {
  final String title;
  final String data;
  final String valor;
  final String subtitle;
  final String sistema;
  final String id;
  final String moeda;
  final int index;
  final String unidadeOrcamental;

  ItemsLista(
      {required this.unidadeOrcamental,
      required this.title,
      required this.subtitle,
      required this.sistema,
      required this.id,
      required this.data,
      required this.valor,
      required this.moeda,
      required this.index});

  @override
  State<ItemsLista> createState() => _ItemsListaState();
}

class _ItemsListaState extends State<ItemsLista> {
  String seta = 'assets/setabaixo.PNG';
  bool estaExpandido = false;

  /*void _iniVariaveis() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.remove('OperationID');
    //sharedPreferences.setString('OperationID', id);
    //String id = sharedPreferences.getString('SistemaID') ?? 'bug sistemaID';
    BlocProvider.of<ListaOperacoesBloc>(context).buscaDetalhes(widget.id);
    
    //print(detalhes.dados.toString());
  }*/

  @override
  Widget build(BuildContext context) {
    //print(widget.id);
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        /*Border(
            //right: BorderSide(color: Color(0xFFB71c1c), width: 5),
            //bottom: BorderSide(color: Color(0xFF636161), width: 1)
            
            ),*/
        //color: Colors.blue,
        elevation: 4.0,
        margin: new EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 8.0,
        ),
        child: Column(
          children: [
            Container(
              child: Text(
                widget.data, //+ valor,
                style: TextStyle(
                    color: Colors.grey[800],
                    //fontWeight: FontWeight.bold,
                    fontFamily: "SEGOEUI",
                    fontSize: 17),
              ),
              width: 87,
              margin: EdgeInsets.fromLTRB(270, 4, 0, 0),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                widget.unidadeOrcamental,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.5,
                  fontFamily: "SEGOEUI",
                ),
              ),
              //color: Colors.green,
              margin: EdgeInsets.fromLTRB(18, 0, 0, 0),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
              //width: 70,

              child: ExpandirDetalhes(forn: widget.subtitle, id: widget.id, context: context),
            ),
            Container(
              //color: Colors.blue,
              margin: EdgeInsetsDirectional.only(
                top: 0.0,
              ),
              child: Divider(
                thickness: 2,
                indent: 22,
                endIndent: 26,
                color: Colors.black26,
              ),
            ),
            Container(
              //color: Colors.red,
              padding: EdgeInsets.zero,
              height: 22,
              width: 48,
              margin: EdgeInsetsDirectional.only(
                start: 335.0,
              ),
              child: Center(
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 35,
                      onPressed: () {},
                      icon: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.black,
                        //size: 30.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              //margin: EdgeInsetsDirectional.only(bottom: 10),
              height: 40,
              //color: Colors.green,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsetsDirectional.only(
                        start: 23,
                      ),
                      child: Text(
                        widget.valor + ' ' + widget.moeda,
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            fontFamily: "SEGOEUI",
                            color: Colors.orange),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsetsDirectional.only(
                        end: 23,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: widget.title == 'Encomenda'
                              ? Color(0xfff9dddf)
                              : Color(0xffe6f6e9),
                          //onSurface: Color(0xfff9dddf),
                          elevation: 0,
                          fixedSize: Size(70, 20),
                        ),
                        onPressed: () => {},
                        child: Text(
                          widget.title,
                          style: TextStyle(
                              color: widget.title == 'Encomenda'
                                  ? Color(0xFFfb2436)
                                  : Color(0xFF59c369),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: "SEGOEUI"),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              margin: EdgeInsets.only(bottom: 9),
            ),
          ],
        ),
      ),
    );
  }
}

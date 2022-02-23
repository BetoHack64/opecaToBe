// ignore_for_file: must_be_immutable, unused_field

import 'package:SOP/src/business_logic/blocs/listaOperacoes/listaOperacoesBloc.dart';
import 'package:SOP/src/business_logic/models/detalhes.dart';
import 'package:SOP/src/views/ui/Lista_Aprovacoes/expansaoDetalhe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  final OperationData detalhes;
  ItemsLista(
      {required this.unidadeOrcamental,
      required this.title,
      required this.subtitle,
      required this.sistema,
      required this.id,
      required this.data,
      required this.valor,
      required this.moeda,
      required this.index,
      required this.detalhes});

  @override
  State<ItemsLista> createState() => _ItemsListaState();
}

class _ItemsListaState extends State<ItemsLista> {
  String seta = 'assets/setabaixo.PNG';
  bool estaExpandido = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      margin: EdgeInsetsDirectional.only(
          end: BlocProvider.of<ListaOperacoesBloc>(context).margemW),
      child: Container(
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
                margin: EdgeInsetsDirectional.only(
                  start: MediaQuery.of(context).size.width - 150,
                  top: 10,
                ),
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
              Column(
                children: [
                  Container(
                    child: Stack(
                      children: [
                        Container(
                          //height: 50,
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          //width: 70,
                          child: ExpandirDetalhes(
                            forn: widget.subtitle,
                            id: widget.id,
                            context: context,
                            detalhes: widget.detalhes,
                            sistemaNome: widget.sistema,
                          ),
                        ),
                        Container(
                          //color: Colors.blue,
                          margin: EdgeInsetsDirectional.only(
                            bottom: 50,
                            top: 36.0,
                          ),
                          child: Divider(
                            thickness: 2,
                            indent: 22,
                            endIndent: 26,
                            color: Colors.black26,
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
                          margin: EdgeInsets.only(
                            top: 55,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: must_be_immutable, unused_field

import 'package:SOP/src/business_logic/blocs/aprovarReprovar/aprovarReprovarBloc.dart';
import 'package:SOP/src/business_logic/blocs/aprovarReprovar/events/aprovarReprovarEvent.dart';
import 'package:SOP/src/business_logic/blocs/aprovarReprovar/states/aprovarReprovarState.dart';
import 'package:SOP/src/business_logic/models/detalhes.dart';
import 'package:SOP/src/views/ui/Lista_Aprovacoes/expancaoDetalhes.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:SOP/src/views/ui/Detalhes/AprovarRejeitar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemsLista extends StatelessWidget {
  final String title;
  final String data;
  final String valor;
  final String subtitle;
  final String sistema;
  final String id;
  final String moeda;
  final int index;
  final String unidadeOrcamental;

  //Criação de objeto de Detalhes
  OperationData _detalhes = OperationData(
    applicationId: '',
    operationCodId: '',
    operationId: '',
    header: Header(campo: '', valor: ''),
    dados: [],
    grelha: Grelha(
        header: Header_grelha(coluna1: '', coluna2: '', coluna3: ''), data: []),
    anexo: [],
  );
  AprovarReprovarBloc teste =
      AprovarReprovarBloc(LoadingAprovarReprovarState());
  OperationData detalhes = OperationData(
    applicationId: '',
    operationCodId: '',
    operationId: '',
    header: Header(campo: '', valor: ''),
    dados: [],
    grelha: Grelha(
        header: Header_grelha(coluna1: '', coluna2: '', coluna3: ''), data: []),
    anexo: [],
  );
//Fim do objeto _detalhes

  //Função para chamar tela de Detalhes

  void _selecionaSistema(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String nomeSistema =
        sharedPreferences.getString('SistemaID') ?? 'bug sistemaID';
    sharedPreferences.remove('OperationID');
    sharedPreferences.setString('OperationID', id);

    detalhes = await teste.teste(id);
    //print(detalhes.dados.toString());
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          // print('Dentro 3');
          // print(this._detalhes.applicationId);
          return BlocProvider<AprovarReprovarBloc>(
            create: (_) {
              return AprovarReprovarBloc(LoadingAprovarReprovarState())
                ..add(LoadAprovarReprovarEvent());
            },
            child: AprovarRejeitar(detalhes),
          );
        },
      ),
    );
  }

  //oid Function() onTap;
  //String sistema = '';

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
  Widget build(BuildContext context) {
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
                data + " ", //+ valor,
                style: TextStyle(
                    color: Colors.grey[800],
                    //fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
              width: 77,
              margin: EdgeInsets.fromLTRB(310, 10, 0, 0),
            ),
            Container(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          unidadeOrcamental,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            fontFamily: "SEGOEUI",
                          ),
                        ),
                        //color: Colors.green,
                        margin: EdgeInsets.fromLTRB(18, 0, 0, 0),
                      ),
                      Positioned(
                        bottom: 2,
                        child: Container(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(3, 0, 0, 0),
                            //width: 70,

                            child: ExpancaoDetalhes(),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              //color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //margin: EdgeInsets.symmetric(horizontal: 15)),

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
          ],
        ),
      ),
    );
  }
}

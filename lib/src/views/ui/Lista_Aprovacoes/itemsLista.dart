import 'package:SOP/src/business_logic/blocs/aprovarReprovar/aprovarReprovarBloc.dart';
import 'package:SOP/src/business_logic/blocs/aprovarReprovar/events/aprovarReprovarEvent.dart';
import 'package:SOP/src/business_logic/blocs/aprovarReprovar/states/aprovarReprovarState.dart';
import 'package:SOP/src/business_logic/models/detalhes.dart';
import 'package:SOP/src/business_logic/services/api_services/FuncoesAPI.dart';
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
  AprovarReprovarBloc teste = AprovarReprovarBloc(LoadingAprovarReprovarState());
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
        sharedPreferences.setString('OperationID',id);
        
    
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
        shape: Border(
            //right: BorderSide(color: Color(0xFFB71c1c), width: 5),
            //bottom: BorderSide(color: Color(0xFF636161), width: 1)
            ),
        //color: Colors.blue,
        elevation: 4.0,
        margin: new EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 3.0,
        ),
        child: ListTile(
          //minLeadingWidth: 40 - 20,
          tileColor: (index % 2 == 1) ? Colors.white : Color(0xFFEEEEEE),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 6.0,
            vertical: 0.0,
          ),
          /*leading: Container(
            padding: EdgeInsets.only(left: 3.0),
            width: 28.0,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 0.2,
                  color: Colors.grey,
                ),
              ),
            ),
            child: Icon(
              Icons.storage,
              color: Colors.grey[600],
            ),
          ),*/
          title: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment.topLeft,
                child: Text(
                  unidadeOrcamental,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(8, 0),
                child: Container(
                  margin: EdgeInsets.only(left: 0),
                  child: Row(
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
                      ),
                      Container(
                        child: AutoSizeText(title + " ", //+ valor,
                            style:
                                TextStyle(color: Colors.red[900], fontSize: 13
                                    //fontWeight: FontWeight.bold,
                                    ),
                            minFontSize: 7,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2),
                        width: title.length == 15
                            ? 99
                            : title.length == 9
                                ? 80
                                : title.length == 22
                                    ? 150
                                    : title.length == 16
                                        ? 114
                                        : title.length == 7
                                            ? 53
                                            : title.length == 8
                                                ? 72
                                                : title.length == 12
                                                    ? 72
                                                    : title.length == 17
                                                        ? 119
                                                        : title.length == 19
                                                            ? 118
                                                            : title.length == 21
                                                                ? 130
                                                                : title.length ==
                                                                        5
                                                                    ? 42
                                                                    : 100,
                      ),
                      Expanded(
                        child: Container(
                          margin: title.length == 15
                              ? EdgeInsets.only(right: 0)
                              : EdgeInsets.only(right: 20),
                          child: AutoSizeText(
                            valor + " akz",
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: valor.length == 14
                                  ? 15
                                  : valor.length == 8
                                      ? 15
                                      : valor.length > 17
                                          ? 15
                                          : valor.length <= 11
                                              ? 15
                                              : valor.length == 12
                                                  ? 15
                                                  : valor.length == 9
                                                      ? 15
                                                      : valor.length == 13
                                                          ? 15
                                                          : valor.length == 22
                                                              ? 15
                                                              : 15,
                            ),
                            minFontSize: 7,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          width: valor.length == 22 ? 245 : 239,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          subtitle: Transform.translate(
            offset: Offset(8, 4),
            child: Row(
              children: [
                SizedBox(
                  width: 2,
                ),
                Text(
                  subtitle + " - " + " Serviços Assistência",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
            size: 20.0,
          ),
          onTap: () => _selecionaSistema(context),
        ),
      ),
    );
  }
}

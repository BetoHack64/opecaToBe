import 'package:SOP/src/business_logic/blocs/listaOperacoes/listaOperacoesBloc.dart';
import 'package:SOP/src/business_logic/models/detalhes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpandirDetalhes extends StatefulWidget {
  late final String forn;
  late final String id;
  late final BuildContext context;
  final OperationData detalhes;
  ExpandirDetalhes(
      {required this.forn,
      required this.id,
      required this.context,
      required this.detalhes});
  @override
  State<ExpandirDetalhes> createState() => _ExpandirDetalhesState();
}

class _ExpandirDetalhesState extends State<ExpandirDetalhes> {
  String seta = 'assets/setabaixo.PNG';
  String test = "{Header: {Coluna1: , Coluna2: , Coluna3: }, Data: []}";
  bool estaExpandido = false;
  List<String> columns = [];
  @override
  initState() {
    super.initState();
    BlocProvider.of<ListaOperacoesBloc>(context).detalhes = widget.detalhes;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      textColor: Colors.black,
      collapsedTextColor: Colors.black,
      onExpansionChanged: (value) {
        print(widget.id);
        //BlocProvider.of<ListaOperacoesBloc>(widget.context)
        //   .buscaDetalhes(widget.id);
        if (value == true) {
          setState(() {
            seta = "assets/setacima.PNG";
            estaExpandido = true;
          });
          if (estaExpandido == true) {
            columns = [
              widget.detalhes.grelha.header.coluna1,
              widget.detalhes.grelha.header.coluna2,
              widget.detalhes.grelha.header.coluna3,
            ];
          }
        } else {
          setState(() {
            seta = "assets/setabaixo.PNG";
            estaExpandido = false;
          });
        }
      },
      title: Column(
        children: [
          Container(
            //color: Colors.red,
            padding: EdgeInsets.zero,
            height: 22,
            width: 48,
            margin: EdgeInsetsDirectional.only(
              start: MediaQuery.of(context).size.width - 102,
            ),
            child: Center(
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 35,
                    onPressed: () {
                      setState(() {
                        BlocProvider.of<ListaOperacoesBloc>(context).margemW = 20;
                      });
                    },
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
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Image.asset(
                  seta,
                  height: 30,
                  width: 30,
                ),
              ),
              Text(
                widget.forn,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "SEGOEUI",
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.white,
      collapsedBackgroundColor: Colors.white,
      //leading: ,

      // trailing: Icon(Icons.no),
      children: [
        estaExpandido == true
            ? ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 0.0,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //aqui irei colocar todos os widgets q farão parte dos detalhes
                    Container(
                      margin: EdgeInsets.only(
                        right: 0,
                        left: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                              bottom: 2,
                              //left: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Intrução for
                                for (int i = 2;
                                    i < widget.detalhes.dados.length;
                                    i++)
                                  (widget.detalhes.dados[i].valor == 'ok')
                                      ? camposPovoar(++i)
                                      : camposPovoar(i),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    widget.detalhes.grelha.toJson().toString().contains(test) ==
                            false
                        ? Column(
                            children: [
                              Divider(
                                color: Colors.grey,
                              ),
                              Container(
                                child: tabelaDados(),
                              ),
                            ],
                          )
                        : Text(''),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }

  //Gera o conteudo das celulas
  List<DataCell> getCelulas(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();

  //Desenha o cabeçalho das Colunas
  List<DataColumn> getColunas(List<String> columns) => columns
      .map((String columns) => DataColumn(
            label: Text(columns),
          ))
      .toList();

  //Desenha as linhas
  List<DataRow> getLinhas(List<String> columns, List<dynamic> cell) => columns
      .map((String columns) => DataRow(
            cells: getCelulas(cell),
          ))
      .toList();

  List<DataRow> tabela() {
    var celulas = [];
    List<DataRow> lista = [];
    for (int i = 0; i < widget.detalhes.grelha.data.length; i++) {
      celulas = [
        widget.detalhes.grelha.data[i].valor1,
        widget.detalhes.grelha.data[i].valor2,
        widget.detalhes.grelha.data[i].valor3
      ];
      DataRow rows = DataRow(cells: getCelulas(celulas));
      lista.add(rows);
    }
    return lista;
  }

  //Construção da Tabela
  Widget tabelaDados() {
    return Container(
      //margin: EdgeInsets.only(right: 10, top: 10), poderia usar o FitdBox para rem o pading
      child: DataTable(
        horizontalMargin: 1,
        columnSpacing: 40,
        columns: getColunas(columns),
        rows: tabela(),
        dataRowHeight: 40,
      ),
    );
  }

  //Construção dos campos
  Widget camposPovoar(int i) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 1),
          child: Text(
            (widget.detalhes.dados[i].campo == 'ok')
                ? ''
                : widget.detalhes.dados[i].campo,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 20,
                fontFamily: "SEGOEUI"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            (widget.detalhes.dados[i].campo.contains('Data'))
                ? widget.detalhes.dados[i].valor.split('-').reversed.join('-')
                : widget.detalhes.dados[i].valor,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontSize: 19,
              fontFamily: "SEGOEUI",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

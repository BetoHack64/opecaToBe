// ignore_for_file: unnecessary_statements

import 'package:SOP/src/business_logic/blocs/listaOperacoes/listaOperacoesBloc.dart';
import 'package:SOP/src/business_logic/blocs/listaOperacoes/states/listaOperacoesState.dart';
import 'package:SOP/src/business_logic/models/cardDetail.dart';
import 'package:SOP/src/views/ui/Lista_Aprovacoes/itemsLista.dart';
import 'package:SOP/src/views/ui/main/drawer.dart';
import 'package:SOP/src/views/ui/main/homeIconButton.dart';
import 'package:SOP/src/views/ui/main/logout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:SOP/src/views/ui/Header/my_header_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'constant.dart';

int toggle = 1;
late String sistema;
void main() {
  runApp(ListaAprovacoes(
    nomeSistema: sistema,
  ));
}

class ListaAprovacoes extends StatefulWidget {
  final String nomeSistema;
  ListaAprovacoes({required this.nomeSistema}) {
    sistema = nomeSistema;
  }
  @override
  State<ListaAprovacoes> createState() => _ListaAprovacoesState();
}

class _ListaAprovacoesState extends State<ListaAprovacoes> {
  @override
  void initState() {
    super.initState();
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
  @override
  initState() {
    super.initState();
    BlocProvider.of<ListaOperacoesBloc>(context).foundUsers =
        BlocProvider.of<ListaOperacoesBloc>(context).cards;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: RetrocederButton(telaRetroceder: 'listaOperacoes'),
          elevation: 0.1,
          backgroundColor: Colors.red[900],
          title: (BlocProvider.of<ListaOperacoesBloc>(context)
                      .botaoHomeAparece ==
                  false)
              ? Text("Portal de Operações")
              : Text(
                  'Portal de Operações' +
                      BlocProvider.of<ListaOperacoesBloc>(context).traco +
                      sistema,
                  style: TextStyle(
                      fontSize: (BlocProvider.of<ListaOperacoesBloc>(context)
                                  .botaoHomeAparece ==
                              true)
                          ? 20
                          : 20),
                ),
          //actions: [ LogoutButton()],
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              color: Colors.grey[50],
              child: Center(
                child: Container(
                  height: 60.0,
                  width: 250.0,
                  alignment: Alignment(-1.0, 0.0),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 375),
                    height: 40.0,
                    width: (toggle == 0) ? 48.0 : 250.0,
                    curve: Curves.easeOut,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            spreadRadius: -14.0,
                            blurRadius: 10.0,
                            offset: Offset(-4.0, 10.0),
                          ),
                        ]),
                    child: Stack(
                      children: [
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 375),
                          left: (toggle == 0) ? 45.0 : 15.0,
                          top: 13.0,
                          curve: Curves.easeOut,
                          child: AnimatedOpacity(
                            opacity: (toggle == 0) ? 0.0 : 1.0,
                            duration: Duration(milliseconds: 200),
                            child: Container(
                              height: 20.0,
                              width: 150.0,
                              child: TextField(
                                onChanged: (valor) => runFilter(valor),
                                cursorRadius: Radius.circular(10.0),
                                cursorWidth: 2.0,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  //labelText: 'Pesquisar...',
                                  label: Text('Pesquisa'),
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  alignLabelWithHint: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        /*Container(
                            margin: EdgeInsets.only(left: 200),
                              child: Material(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.0),
                                child: IconButton(
                                  splashRadius: 20.0,
                                  splashColor: Colors.grey,
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  icon: Image.asset(
                                    'assets/images/search.png',
                                    height: 18.0,
                                  ),
                                ),
                              ),
                            ),*/
                      ],
                    ),
                  ),
                ),
              ),
            ),
            BlocBuilder<ListaOperacoesBloc, ListaOperacoesState>(
                bloc: BlocProvider.of<ListaOperacoesBloc>(context),
                builder: (context, state) {
                  if (state is ListaOperacoesLoadedSucessState) {
                    return Expanded(
                      flex: 360,
                      child: BlocProvider.of<ListaOperacoesBloc>(context)
                              .foundUsers
                              .isNotEmpty
                          ? ListView.builder(
                              itemCount:
                                  BlocProvider.of<ListaOperacoesBloc>(context)
                                      .foundUsers
                                      .length,
                              itemBuilder: (context, index) => ItemsLista(
                                unidadeOrcamental:
                                    BlocProvider.of<ListaOperacoesBloc>(context)
                                        .foundUsers[index]
                                        .unidadeOrcamental,
                                title:
                                    BlocProvider.of<ListaOperacoesBloc>(context)
                                        .foundUsers[index]
                                        .title,
                                subtitle:
                                    BlocProvider.of<ListaOperacoesBloc>(context)
                                        .foundUsers[index]
                                        .fornecedor,
                                sistema: nome,
                                id: BlocProvider.of<ListaOperacoesBloc>(context)
                                    .foundUsers[index]
                                    .id,
                                data:
                                    BlocProvider.of<ListaOperacoesBloc>(context)
                                        .foundUsers[index]
                                        .subtitle,
                                valor:
                                    BlocProvider.of<ListaOperacoesBloc>(context)
                                        .foundUsers[index]
                                        .valor
                                        .toString(),
                                moeda:
                                    BlocProvider.of<ListaOperacoesBloc>(context)
                                        .foundUsers[index]
                                        .moeda,
                                index: index,
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.only(bottom: 130),
                              child: Center(
                                child: const Text(
                                  'Nenhum resultado encontrado.',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                    );
                  }

                  return Container();
                }),
          ],
        ),
      ),
    );
  }

  // This function is called whenever the text field changes
  void runFilter(String enteredKeyword) {
    List<CardDetail> results = [];

    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = BlocProvider.of<ListaOperacoesBloc>(context).cards;
    } else {
      results =
          BlocProvider.of<ListaOperacoesBloc>(context).cards.where((card) {
        return card.title
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()) ||
            card.subtitle
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()) ||
            card.fornecedor
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()) ||
            card.valor.toLowerCase().contains(enteredKeyword.toLowerCase());
      }).toList();
    }
    setState(() {
      BlocProvider.of<ListaOperacoesBloc>(context).foundUsers = results;
    });
  }
}

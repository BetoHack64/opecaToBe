import 'package:SOP/src/business_logic/blocs/listaOperacoes/events/listaOperacoesEvent.dart';
import 'package:SOP/src/business_logic/blocs/listaOperacoes/listaOperacoesBloc.dart';
import 'package:SOP/src/business_logic/blocs/listaOperacoes/states/listaOperacoesState.dart';
import 'package:SOP/src/business_logic/services/shared_prefs_services/verificaConexao.dart';
import 'package:SOP/src/views/ui/Lista_Aprovacoes/listaAprovacoes.dart';
import 'package:SOP/src/views/ui/main/iconSistema.dart';
import 'package:flutter/material.dart';
import 'package:SOP/src/business_logic/services/api_services/FuncoesAPI.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

String traco = ' - ';
List<Sistema> applicationDetailItems = [];
List<CardDetail> cardss = [];
int id = 0;
List lista = [];
bool temOuNao = false;

class GridDashboard extends StatefulWidget {
  GridDashboard({required List<Sistema> items}) {
    applicationDetailItems = items;
  }

  @override
  State<GridDashboard> createState() => _GridDashboardState();
}

class _GridDashboardState extends State<GridDashboard> {
  @override
  initState() {
    super.initState();
    FuncoesAPI.buscaOperacoes(51000000, 1001).then((value) {
      cardss = value;
    });
    ListaOperacoesBloc.temNet().then((value) => temOuNao = value);
    //print(temOuNao);
  }

  Future<String> pegaDados() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return (sharedPreferences.getString("IdAccount") ?? "");
  }

  Future<void> _selecionaSistema(
      BuildContext context, String sistema, int appID) async {
    /*SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("ApplicationID", appID);*/
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          applicationDetailItems = [];
          return BlocProvider<ListaOperacoesBloc>(
            create: (_) {
              return ListaOperacoesBloc(ListaOperacoesLoadingState(), temOuNao)
                ..add(ListaOperacoesGetConnection());
            },
            child: ListaAprovacoes(sistema, traco, cardss, true),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Sistema> myList = applicationDetailItems;
    return Flexible(
      child: GridView.count(
        childAspectRatio: 1.0,
        padding: EdgeInsets.only(left: 16, right: 16, top: 10),
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        children: myList.map(
          (data) {
            return InkWell(
              onTap: () => _selecionaSistema(
                  context, data.applicationCod, data.applicationID),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 0.2,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      height: 30,
                      width: 30,
                      child: Center(
                        child: Text(
                          data.numOperations,
                          style: TextStyle(
                              color: data.numOperations == "0"
                                  ? Colors.black
                                  : Colors.red[900],
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Open Sans"),
                        ),
                      ),
                      margin: EdgeInsets.only(left: 120, bottom: 0),
                    ),
                    Container(
                      child: IconSistema(
                          imageAnalysed: data.iconBase64,
                          nome: data.applicationCod),
                      margin: EdgeInsets.only(bottom: 16),
                    ),
                    Container(
                      child: Text(
                        data.applicationCod,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Open Sans"),
                      ),
                      margin: EdgeInsets.only(bottom: 5),
                    ),
                    Text(
                      data.applicationNameShort,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Open Sans"),
                    ),
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

class Sistema {
  late final int applicationID;
  late final String applicationCod;
  late final String applicationName;
  late final String applicationNameShort;
  late final String iconBase64;
  late final String numOperations;
  Sistema({
    required this.applicationID,
    required this.applicationCod,
    required this.applicationName,
    required this.applicationNameShort,
    required this.iconBase64,
    required this.numOperations,
  });
}

import 'dart:convert';

import 'package:SOP/src/views/ui/main/cabecalho.dart';
import 'package:flutter/material.dart';
import 'package:SOP/src/business_logic/models/apiJsonToObjectSistemas.dart';
import 'package:SOP/src/views/ui/main/griddashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

List<Sistema> listaSiste = [];
List<Sistema> applicationDetailItems = [];
String idAccount = '';

class Dashboard1 extends StatefulWidget {
  @override
  State<Dashboard1> createState() => _Dashboard1State();
}

class _Dashboard1State extends State<Dashboard1> {
  @override
  initState() {
    super.initState();
    pegaDados().then((value) {
      setState(() {
        idAccount = value;
        buscaOperacoes(idAccount).then((value) {
          setState(() {
            listaSiste = value;
            //print(idAccount + " testes");
          });
        });
      });
      print(idAccount + " teste");
    });
  }

  Future<String> pegaDados() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return (sharedPreferences.getString("IdAccount") ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Cabecalho(lista: listaSiste);
  }

  List<String> iconesLista = [
    "assets/images/money-transfer-100.png",
    "assets/images/donate-50.png",
    "assets/images/icons8-basket-50.png",
    "assets/images/synchronize.png",
    "assets/images/calculator-50.png",
    "assets/images/money-bag-50.png",
    "assets/images/group-64.png",
    "assets/images/swatchbook.png",
    "assets/images/money-transfer.png",
    "assets/images/icons8-coin-in-hand-90.png",
    "assets/images/analytics.png",
    "assets/images/icons8-calculator-64.png",
    "assets/images/icons8-calculator-64.png",
    "assets/images/icons8-calculator-64.png"
  ];
  Future<List<Sistema>> buscaOperacoes(String accountID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //idAccount = (sharedPreferences.getString("IdAccount") ?? "");
    var url = Uri.parse(
        'http://83.240.225.239:130/api/Systems?AccountID=' + accountID);
    print(url);
    var token = (sharedPreferences.getString("access_token") ?? "");
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    var response = await http.get(url, headers: header);
    Map<String, dynamic> userMap = jsonDecode(response.body);
    List<Sistema> tagsJson = [];
    int i = 0;
    if (userMap.isNotEmpty) {
      SistemaAPI sist = SistemaAPI.fromJson(userMap);
      sist.applicationDetail.applicationDetailItems.forEach((element) {
        tagsJson.add(
          Sistema(
              applicationID: element.applicationID,
              applicationCod: element.applicationCod,
              applicationName: element.applicationName,
              applicationNameShort: element.applicationNameShort,
              iconClass: iconesLista[i],
              numOperations: element.numOperations),
        );

        i++;
      });

      return tagsJson;
    } else {
      print('Bug');
      return [];
    }
  }
}
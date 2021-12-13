import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opeca_app/Aprovacoes/listaAprovacoes.dart';
import 'package:opeca_app/Models/apiJsonToObjectSistemas.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

String traco = ' - ';
List<Sistema> applicationDetailItems =[];
List<CardDetail> cardss = [];
class GridDashboard extends StatefulWidget {
  //List<Sistema> applicationDetailItems =[];
  GridDashboard({required List<Sistema> items}){
    applicationDetailItems = items;
  }
  
  @override
  State<GridDashboard> createState() => _GridDashboardState();
}

class _GridDashboardState extends State<GridDashboard> {
  @override
  initState() {
    super.initState();
    buscaOperacoes().then((value) {
      cardss = value;
    });
  }
  void _selecionaSistema(BuildContext context, String sistema) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          applicationDetailItems =[];
          return ListaAprovacoes(sistema, traco, cardss, true);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
  //print(applicationDetailItems);
    List<Sistema> myList = applicationDetailItems;
    var color = 0xffEf5350;
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
              onTap: () => _selecionaSistema(context, data.applicationCod),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.iconClass,
                      color: Colors.black,
                      width: 55,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.applicationCod,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.applicationNameShort,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.numOperations,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
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
   Future<List<CardDetail>> buscaOperacoes() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(
        'http://83.240.225.239:130/api/Operation?ApplicationID=51000000');
    var token = (sharedPreferences.getString("access_token") ?? "");
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    var jsonResponse;
    var response = await http.get(url, headers: header);
    Map mapResponse = json.decode(response.body);
    Map userMap = jsonDecode(response.body);
    List<CardDetail> cards = [];
    //print(userMap['OperationList'][0]['Area']);
    //print(sis);
    if (userMap != null) {
      for (var item in userMap['OperationList']) {
      if(item['Entity1'].isNotEmpty){
        cards.add(
          CardDetail(
            title: item['Operation'],
            subtitle: item['Date'],
            valor: item['ValueOperation'],
            fornecedor: item['Entity1'],
          ),
        );
      }
      }
      return cards;
    } else {
      print('Bug');
      return [];
    }
  }
}

class Sistema {
    late final int applicationID;
    late final String applicationCod;
    late final String applicationName;
    late final String applicationNameShort;
    late final String iconClass;
    late final String numOperations;
  Sistema(
      {required this.applicationID,
      required this.applicationCod,
      required this.applicationName,
      required this.applicationNameShort,
      required this.iconClass,
      required this.numOperations,
      });
}


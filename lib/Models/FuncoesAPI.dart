import 'dart:convert';

import 'package:SOP/Aprovacoes/listaAprovacoes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FuncoesAPI {
 static Future<List<CardDetail>> buscaOperacoes() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(
        'http://83.240.225.239:130/api/Operation?ApplicationID=51000000');
    var token = (sharedPreferences.getString("access_token") ?? "");
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    var response = await http.get(url, headers: header);
    Map userMap = jsonDecode(response.body);
    List<CardDetail> cards = [];
    //print(userMap['OperationList'][0]['Area']);
    //print(sis);
    if (userMap.isNotEmpty) {
      for (var item in userMap['OperationList']) {
        cards.add(
          CardDetail(
            title: item['Operation'],
            subtitle: item['Date'],
            id: item['OperationID'].toString(),
            moeda: item['Currency'],
            valor: item['ValueOperation'] ?? '23',
            fornecedor: item['Entity1'] ?? 'Teste',
          ),
        );
      }
      return cards;
    } else {
      print('Bug');
      return [];
    }
  }
}

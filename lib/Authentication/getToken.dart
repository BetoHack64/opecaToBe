// Importacao de bibliotecas
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class Token {

  /*
    *   Funcao para obter o token
    *   Recebe como parametro, o nome do usuario e a senha
  */
  Future<bool> token(String user, String password) async {
    var url = Uri.parse('http://83.240.225.239:130/token');
    
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var header = {"Content-Type": "application/json"};

    //Map params = {"Username": user, "Password": password};
    String para =
        'Username=' + user + '&Password=' + password + '&grant_type=password';
    var jsonResponse;
    //var _body = json.encode(params);
    var _body = json.encode(para);
    //print(" ******** aqui - " + _body);
    print("json enviado : $_body");
    //print("json enviado : $_body2");

    var response = await http.post(url, headers: header, body: para);
    //var response2 = await http.post(tokenUrl, body: _body2);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map mapResponse = json.decode(response.body);
    int mensagem = mapResponse["expires_in"];
    String token = mapResponse["access_token"];

    print("message $mensagem");
    print("token $token");
    if (response.body.contains("invalid")) {
      print("falhou token");
      return false;
    } else {
     
      return true;
    }
  }

  
}

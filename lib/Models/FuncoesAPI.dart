import 'dart:convert';

import 'package:SOP/Aprovacoes/listaAprovacoes.dart';
import 'package:SOP/Home/main.dart';
import 'package:SOP/src/business_logic/blocs/login/events/loginEvent.dart';
import 'package:SOP/src/business_logic/blocs/login/loginBloc.dart';
import 'package:SOP/src/views/ui/login/mensagem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FuncoesAPI {
/*
    *   Funcao para obter o token
    *   Recebe como parametro, o nome do usuario e a senha
    *   Depois de obter o token, armazena-o em um espaço alocado
  */
  static token(String usuario, String password, BuildContext context) async {
    // Url da API para obter o token
    var url = Uri.parse('http://83.240.225.239:130/token');

    //SharedPreferences - Plugin para armazenar dados, onde armazenar-se-á o token
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    //Cabeçalho da requisiçao
    var header = {"Content-Type": "application/json"};

    //Corpo da requisiçao
    String corpo = 'Username=' +
        usuario +
        '&Password=' +
        password +
        '&grant_type=password';

    // Converte a string "corpo" para uma string no formato JSON
    var _body = json.encode(corpo);

    // Envia uma requisiçao POST com o seu devido cabeçalho e corpo à URL
    var response = await http.post(url, headers: header, body: corpo);

    //Analisa a string em "response.body" e retorna o objeto Json resultante
    Map mapResponse = json.decode(response.body);

    try {
      //Armazena os dados no local partilhado da aplicacao
      sharedPreferences.setString("access_token", mapResponse["access_token"]);
      sharedPreferences.setBool("isLoggedIn", true);
      sharedPreferences.setString("usuarioNomeLogin", usuario);
      sharedPreferences.setString("usuarioSenhaLogin", password);

      //Redireciona para a tela Home
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return Home();
          },
        ),
      );
    } catch (e) {}
  }

  //---------------------------
  //Pega os dados do user
  contaUsuario(String usuario, String password, TextEditingController user,
      TextEditingController pass, BuildContext context) async {
    var url = Uri.parse('http://83.240.225.239:130/api/Authenticate');

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {"Username": usuario, "Password": password};
    var response = await http.post(url, body: body);
    Map mapResponse = json.decode(response.body);

    if (mapResponse['IsValid'] == true) {
      sharedPreferences.setString(
          "NomeBanco", mapResponse['User']['Description']);
      sharedPreferences.setString("Nome", usuario);
      sharedPreferences.setString(
          "IdAccount", mapResponse['User']['IdAccount'].toString());

      token(usuario, password, context);
    } else {
      //Future.delayed(Duration.zero, () => MensagemLogin.erroLogin(context));
      // pass.clear();
      //user.clear();
      Future.delayed(Duration.zero, () => MensagemLogin.erroLogin(context));
      user.clear();
      pass.clear();
      BlocProvider.of<LoginBloc>(context).add(LoginProcessing1());
      //BlocProvider.of<LoginBloc>(context).add(LoginExecutedError());
    }
  }

  //---
  static Future<List<CardDetail>> buscaOperacoes(int appID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(
        'http://83.240.225.239:130/api/Operation?ApplicationID=' +
            appID.toString());
    print(url);
    var token = (sharedPreferences.getString("access_token") ?? "");
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    var response = await http.get(url, headers: header);
    Map userMap = jsonDecode(response.body);
    List<CardDetail> cards = [];
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
      return [];
    }
  }
}

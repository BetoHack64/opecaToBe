import 'dart:convert';

import 'package:SOP/src/business_logic/models/detalhes.dart';
import 'package:SOP/src/views/ui/main/main.dart';
import 'package:SOP/src/business_logic/blocs/login/events/loginEvent.dart';
import 'package:SOP/src/business_logic/blocs/login/loginBloc.dart';
import 'package:SOP/src/business_logic/blocs/main/events/mainEvent.dart';
import 'package:SOP/src/business_logic/blocs/main/mainBloc.dart';
import 'package:SOP/src/business_logic/blocs/main/states/mainState.dart';
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
    //var _body = json.encode(corpo);

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
            return MultiBlocProvider(
              providers: [
                BlocProvider<MainBloc>(
                  create: (_) {
                    return MainBloc(MainOpeningState())..add(MainOpenning());

                    //return MainBloc(MainOpeningState(), lista)..add(MainOpenning());
                  },
                ),
                
              ],
              child: Home(),
            );
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
      Future.delayed(Duration.zero, () => MensagemLogin.erroLogin(context));
      user.clear();
      pass.clear();
      BlocProvider.of<LoginBloc>(context).add(LoginGetConnection());
    }
  }

  //---
 //Buscar detalhes da operação  APpID=51000000 OpreaID=2021101000004
  static Future<OperationData> buscaDetalhes(
      String ApplicationID, String OperationID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //idAccount = (sharedPreferences.getString("IdAccount") ?? "");
    var url = Uri.parse(
        'http://83.240.225.239:130/api/OperationData?ApplicationID=$ApplicationID&OperationID=$OperationID');
    //print(url);
    var token = (sharedPreferences.getString("access_token") ?? "");
    // print(token);
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    //Variaveis para os Dados
    List<Data0> listaData = [];
    List<Grelha> listaGrelha = [];
    //fim Variaveis
    var response = await http.get(url, headers: header);
    Map<String, dynamic> userMap = jsonDecode(response.body);

    OperationData detals;
    print(userMap['OperationData']['ApplicationID']);
    if (userMap.isNotEmpty) {
      //Para os dados do detalhes
      for (var item in userMap['OperationData']['Data']) {
        Data0 data = Data0(campo: item['Campo'], valor: item['Valor'] ?? "ok");
        listaData.add(data);
      }

      //Para a Construção da  Tabela

      return OperationData(
        applicationId: userMap['OperationData']['ApplicationID'],
        operationCodId: userMap['OperationData']['OperationCodID'],
        operationId: userMap['OperationData']['OperationID'].toString(),
        header: Header.fromJson(userMap['OperationData']['Header']),
        dados: listaData,
        grelha: Grelha.fromJson(userMap['OperationData']['Grelha']),
        anexo: Anexo.fromJson(userMap['OperationData']['Anexo']),
      );
    } else {
      print('Bug');
      return OperationData(
        applicationId: '',
        operationCodId: '',
        operationId: '',
        header: Header(campo: '', valor: ''),
        dados: [],
        grelha: Grelha(
            header: Header_grelha(coluna1: '', coluna2: '', coluna3: ''),
            data: []),
        anexo: Anexo(operationId: '', idConteudo: '', data: []),
      );
    }
  }
  //Fim da função pegar os detalhes da operação

  static Future<String> buscaPdf(String OperationID, String ContentID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //idAccount = (sharedPreferences.getString("IdAccount") ?? "");
    var url = Uri.parse(
        'http://83.240.225.239:130/api/File?OperationID=$OperationID&ContentID=$ContentID');
    //print(url);
    var token = (sharedPreferences.getString("access_token") ?? "");
    // print(token);
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    var response = await http.get(url, headers: header);
    //Map<String, dynamic> userMap = jsonDecode(response.body);
    
    //print(jsonDecode(response.body).toString());
    return jsonDecode(response.body).toString();
  }
}

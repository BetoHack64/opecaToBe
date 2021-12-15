import 'dart:convert';

import 'package:blurry/blurry.dart';
import 'package:flutter/material.dart';
//import 'package:local_auth/local_auth.dart';
import 'package:SOP/Home/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

String tokenValor = '';

class LoginTela extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<LoginTela> {
  bool _validate = false;
  //Autenticacao Biometrica
  /*
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  @override
  initState() {
    super.initState();
    authenticate();
  }
  
  authenticate() async {
    if (await _isBiometricAvailable()) {
      await _getListOfBiometricTypes();
      await _aunthenticateUser();
    }
  }

  Future<bool> _isBiometricAvailable() async {
    try {
      bool isAvailable = await _localAuthentication.canCheckBiometrics;
      return isAvailable;
    } catch (ex) {
      return false;
    }
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listOfBiometrics =
        await _localAuthentication.getAvailableBiometrics();
  }

  Future<void> _aunthenticateUser() async {
    bool isAuthenticated =
        await _localAuthentication.authenticateWithBiometrics(
            localizedReason: "Por favor efetue a autenticacao",
            useErrorDialogs: true,
            stickyAuth: true);
    if (isAuthenticated) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    }
  }
*/
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  late String _user, _pass;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
              color: Colors.white,
              gradient: LinearGradient(
                //Tornar o container Gradiante
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [(Colors.red), (Colors.redAccent)],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Image.asset(
                      "assets/images/logo.png",
                      color: Colors.white,
                      /*  height: 200,
                      width: 100,*/
                      scale: 0.6,
                    ), //logo da aplicação
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20, top: 20),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "LOgin".toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                          //Estilização do texto da tela de login "Login"
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          //Conteiner do usuario
          Container(
            margin: EdgeInsets.only(right: 20, left: 20, top: 50),
            padding: EdgeInsets.only(right: 20, left: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xfEEEEEE)),
                ]),
            alignment: Alignment.center,
            child: TextField(
              onChanged: (text) {
                setState(() {
                  _user = text;
                });
              },
              cursorColor: Color(0xFFf5851f),
              controller: user,
              //onChanged: (novoValor) => senha = novoValor,
              decoration: InputDecoration(
                  //errorText: (_validate) ? 'Utilizador errado' : null,
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.person,
                      color: (Colors.red),
                    ),
                  ),
                  hintText: 'Utilizador',
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none),
            ),
          ), //Termina aui o input do usuario
          Container(
            //Incio do input senha
            margin: EdgeInsets.only(right: 20, left: 20, top: 20),
            padding: EdgeInsets.only(right: 20, left: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xfEEEEEE)),
                ]),
            alignment: Alignment.center,
            child: TextField(
              onChanged: (text) {
                setState(() {
                  _pass = text;
                });
              },
              obscureText: true,
              controller: pass,
              //onChanged: (novoValor) => senha = novoValor,
              cursorColor: Color(0xFFf5851f),
              decoration: InputDecoration(
                  //errorText: (_validate) ? 'Senha errada' : null,
                  icon: Icon(
                    Icons.vpn_key,
                    color: (Colors.red),
                  ),
                  hintText: 'Senha',
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none),
            ),
          ), //Fim input Senha
          SizedBox(height: 10),
          GestureDetector(
            onTap: ((pass.text.isEmpty || user.text.isEmpty) == true)
                ? () {
                    setState(() {
                      _validate = true;
                    });

                    //print("escreva algo ${_validate}");
                  }
                : () {
                    /*Colocar o comando onClik Aqui!*/

                    //print(_user + ' - ' + _pass);
                    setState(() {
                      //_user = user.text;
                      //_pass = pass.text;
                      _validate = false;
                    });
                    token(_user, _pass);
                  },
            //Botão Entrar
            child: Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 10),
              padding: EdgeInsets.only(left: 30, right: 30),
              alignment: Alignment.center,
              height: 52,
              //color: Colors.red[200],
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [(Colors.red), (Colors.redAccent)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xfEEEEEE)),
                  ]),
              child: Text(
                'Entrar'.toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                    //Estilização do texto da tela de login "Login"
                    ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  /*
    *   Funcao para obter o token
    *   Recebe como parametro, o nome do usuario e a senha
    *   Depois de obter o token, armazena-o em um espaço alocado
  */
  token(String usuario, String password) async {
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

    //print("json enviado : $_body");

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
    } catch (e) {
      Blurry.error(
        title: 'Autenticação',
        description: 'Usuário ou senha inválidos',
        confirmButtonText: 'Ok',
        onConfirmButtonPressed: () {
          Navigator.pop(context);
        },
        displayCancelButton: false,
      ).show(context);
      user.clear();
      pass.clear();
    }
  }

  contaUsuario(String usuario, String password) async {
    var url = Uri.parse('http://83.240.225.239:130/api/Authenticate');

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var header = {"Content-Type": "application/json"};
    Map body = {"Username": usuario, "Password": password};
    var jsonResponse;
    var _body = json.encode(body);
    //print("Conta Usuario obtida com sucesso : $_body");

    var response = await http.post(url, body: body);

    Map mapResponse = json.decode(response.body);

    if (mapResponse['IsValid'] == true) {
      //print(mapResponse['User']['Description']);
      sharedPreferences.setString(
          "NomeBanco", mapResponse['User']['Description']);
      sharedPreferences.setString("Nome", usuario);
      token(usuario, password);
    } else {}
  }
}

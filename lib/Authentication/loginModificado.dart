import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:opeca_app/Home/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginTela2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<LoginTela2> {
  final _tUser = TextEditingController();
  final _tSenha = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void logar() {
    print(" Login efectuado ");
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  //Agrupadora de widget
  _body(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(90)),
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
              child: TextFormField(
                controller: _tUser,
                // validator: _validateLogin,
                keyboardType: TextInputType.text,
                cursorColor: Color(0xFFf5851f),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: (Colors.red),
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
              child: TextFormField(
                controller: _tSenha,
                //  validator: _validateLogin,
                keyboardType: TextInputType.text,
                obscureText: true,
                cursorColor: Color(0xFFf5851f),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.vpn_key,
                      color: (Colors.red),
                    ),
                    hintText: 'Senha',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
              ),
            ), //Fim input Senha
            Container(
              margin: EdgeInsets.only(right: 30, top: 10),
              alignment: Alignment.centerRight,
              child: GestureDetector(
                child: Text(
                  "Esqueci a senha",
                  style: TextStyle(color: Colors.red, fontSize: 14
                      //Estilização do texto da tela de login "Login"
                      ),
                ),
                onTap: () => {/*Colocar o comando onClik Aqui!*/},
              ),
            ), //Fim Lik Esqueci a senha

            //Botão Definição

            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 10),
              padding: EdgeInsets.only(left: 30, right: 30),
              alignment: Alignment.center,
              height: 52,
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
              child: ElevatedButton(
                //color: Colors.blue,
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                      //Estilização do texto da tela de login "Login"
                      ),
                ),
                onPressed: 
                  _tUser.text == "" || _tSenha.text == ""
                ? null
                : () {
                    /*Colocar o comando onClik Aqui!*/
                    setState(() {
                      tokenLogin(_tUser.text, _tSenha.text);
                    });

                },
              ),
            ),
            //Fim def. Botão
          ],
        ));
  }

  //--------------fim agrumpamento

  Widget initWidget() {
    return Scaffold(
      body:_body(context)
    );
  }
  //Final do widget principal

//Validador dos inputs
  /* String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Informe o login";
    }
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Informe a senha";
    }
    return null;
  }*/
//---------------------Fim Validador
  //widget _corpo
  
  tokenLogin(String usuario, String password) async {
    var url = Uri.parse('http://83.240.225.239:130/token');

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var header = {"Content-Type": "application/json"};

    String body = 'Username=' +
        usuario +
        '&Password=' +
        password +
        '&grant_type=password';
    var jsonResponse;
    var _body = json.encode(body);
    print("json enviado : $_body");

    var response = await http.post(url, headers: header, body: body);
    //var UsuarioNome = '';
    //print('Response body: ${response.body}');

    Map mapResponse = json.decode(response.body);

    try {
      int mensagem = mapResponse["expires_in"];
      String token = mapResponse["access_token"];
      sharedPreferences.setString("access_token", mapResponse["access_token"]);
      sharedPreferences.setBool("isLoggedIn", true);
      sharedPreferences.setString("usuarioNomeLogin", usuario);
      sharedPreferences.setString("usuarioSenhaLogin", password);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return Home();
          },
        ),
      );
      contaUsuario(usuario, password);
    } catch (e) {
      final snackBar = SnackBar(
        content: Text('Esse é o nosso SnackBar'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            // Algum código para desfazer alguma alteração
          },
        ),
      );

      // Aqui nós usamos a Scaffold do contexto para
      // exibir o SnackBar corretamente como explicado antes
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print("Usuario ou senha errado");
      _tUser.clear();
      _tSenha.clear();
    }

    //print("message $mensagem");
    //print("token $token");
    //print(token);
  }

  contaUsuario(String usuario, String password) async {
    var url = Uri.parse('http://83.240.225.239:130/api/Authenticate');

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var header = {"Content-Type": "application/json"};
    Map body = {"Username": usuario, "Password": password};
    var jsonResponse;
    var _body = json.encode(body);
    print("Conta Usuario obtida com sucesso : $_body");

    var response = await http.post(url, body: body);

    Map mapResponse = json.decode(response.body);
    print(mapResponse['User']['Description']);
    sharedPreferences.setString("Nome", mapResponse['User']['Description']);
  }
}
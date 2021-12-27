// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:ui';

import 'package:blurry/blurry.dart';
import 'package:flutter/material.dart';
import 'package:SOP/Home/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginScreem extends StatefulWidget {
  @override
  _LoginScreemState createState() => _LoginScreemState();
}

class _LoginScreemState extends State<LoginScreem> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  late String _user, _pass;
  bool _validate = false;
  bool lembraMe = false;

//get http => null;

  _constroiUser() {
    return;
  }

  _constroiSenha() {
    return;
  }

  //Botão para sair da aplicaçao
  _botaoSair() {
    return Container(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          print("Sair");
        },
        child: Text("Sair"),
      ),
    );
  }

//CheckBox Pra lembrar sempre a senha
  _lembraMeagora() {
    return Container(
      height: 20,
      child: Row(
        children: [
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: lembraMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  lembraMe = value!;
                });
              },
            ),
          ),
          Text("Lembra-me",
              style: TextStyle(
                color: Colors.white,
              ))
        ],
      ),
    );
  }

  _botaoEntrar() {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              // ignore: prefer_const_literals_to_create_immutables
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
              ],
              // ignore: prefer_const_literals_to_create_immutables
              stops: [0.1, 0.4, 0.7, 0.9],
            )),
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 65),
                    child: Image.asset(
                      "assets/images/sop.png",
                      //color: Colors.white,
                      /*  height: 200,
                      width: 100,*/
                      scale: 0.9,
                    ), //logo da aplicação
                  ),
                ],
              ),
            ),
          ),
          //Container de Autenticação
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: MediaQuery.of(context).size.height / 7,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 80, bottom: 1),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: MediaQuery.of(context).size.height / 1.6,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 1),
                                blurRadius: 12,
                                color: Color(0xFFE0E0E0)),
                          ],
                          /*border: Border.all(
                                color:  Color(0xFFD50000),
                              ),*/
                        ),
                        child: Column(
                          children: [
                            //SizedBox(height: 35.0),
                            Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.1,
                              margin: EdgeInsets.only(
                                top: 12.9,
                              ),
                              child: Image.asset(
                                "assets/images/keve_exe.jpg",
                                //color: Colors.white,
                                /*  height: 200,
                                width: 100,*/
                                //scale: 0.20,
                              ), //logo do Banco
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: Text(
                                "Autenticação",
                                style: TextStyle(
                                    color: Color(0xFF616161),
                                    fontFamily: "openSans",
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 21),
                                  child: Text(
                                    'Utilizador',
                                    style: TextStyle(
                                      color: Color(0xFF616161),
                                      fontSize: 18,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Container(
                                  margin: const EdgeInsets.only(
                                      right: 20, left: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFFEEEEEE),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 7),
                                          blurRadius: 40,
                                          color: Color(0xfEEEEEE)),
                                    ],
                                  ),
                                  height: 60,
                                  child: TextField(
                                    onChanged: (text) {
                                      setState(() {
                                        _user = text;
                                      });
                                    },
                                    controller: user,
                                    style: TextStyle(
                                      color: Color(0xFF303030),
                                      fontFamily: "openSans",
                                      fontSize: 20,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.only(top: 14.0),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: (Color(0xFF616161)),
                                      ),
                                      // hintText: 'Utilizador',
                                      //hintStyle: TextStyle(color:Color(0xFF616161)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 30.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 21),
                                  child: Text(
                                    'Senha',
                                    style: TextStyle(
                                      color: Color(0xFF303030),
                                      fontSize: 18,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "openSans",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.0),
                                Container(
                                  margin: const EdgeInsets.only(
                                      right: 20, left: 20),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFFEEEEEE),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 7),
                                          blurRadius: 40,
                                          color: Color(0xfEEEEEE)),
                                    ],
                                  ),
                                  height: 60,
                                  child: TextField(
                                    onChanged: (text) {
                                      setState(() {
                                        _pass = text;
                                      });
                                    },
                                    controller: pass,
                                    style: TextStyle(
                                      color: Color(0xFF303030),
                                      fontFamily: "openSans",
                                      fontSize: 20,
                                    ),
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.only(top: 14.0),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: (Color(0xFF616161)),
                                      ),
                                      // hintText: 'Senha',
                                      //hintStyle: TextStyle(color: Color(0xFF616161)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            //Botão
                            //Botão Entrar
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 20.0),
                              width: double.infinity,
                              margin:
                                  const EdgeInsets.only(right: 20, left: 20),
                              child: SizedBox(
                                height: 60, //altura do button
                                width: 150, //Largura button
                                child: ElevatedButton(
                                  //  elevation: 5.0,
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      //side: BorderSide(color: Colors.red)
                                    ),
                                    primary: Colors.red[900], // background
                                    onPrimary: Colors.white, // foreground
                                  ),
                                  onPressed: ((pass.text.isEmpty ||
                                              user.text.isEmpty) ==
                                          true)
                                      ? () {
                                          Blurry.error(
                                            title: 'Autenticação',
                                            description:
                                                'Usuário ou senha inválidos',
                                            confirmButtonText: 'Ok',
                                            onConfirmButtonPressed: () {
                                              Navigator.pop(context);
                                            },
                                            displayCancelButton: false,
                                          ).show(context);
                                          user.clear();
                                          pass.clear();
                                        }
                                      : () {
                                          setState(() {
                                            _validate = false;
                                          });
                                          contaUsuario(_user, _pass);
                                          //token(_user, _pass);
                                        },

                                  child: Text("LOGIN",
                                      style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 1.5,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

//FIMMMMMMMMMMMMMMMMMM
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
    } catch (e) {}
  }

  //---------------------------
  //Pega os dados do user
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
      sharedPreferences.setString(
          "IdAccount", mapResponse['User']['IdAccount'].toString());
          
      token(usuario, password);
    } else {
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
  //-------------------------------------------------------------------------

}

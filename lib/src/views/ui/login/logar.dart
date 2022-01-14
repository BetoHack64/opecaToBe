// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, prefer_const_literals_to_create_immutables
import 'package:SOP/src/business_logic/services/api_services/FuncoesAPI.dart';
import 'package:SOP/src/business_logic/blocs/login/events/loginEvent.dart';
import 'package:SOP/src/business_logic/blocs/login/loginBloc.dart';
import 'package:SOP/src/business_logic/blocs/login/states/loginState.dart';
import 'package:SOP/src/views/ui/login/mensagem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

LoginBloc teste = LoginBloc();

class LoginScreem extends StatefulWidget {
  @override
  _LoginScreemState createState() => _LoginScreemState();
}

class _LoginScreemState extends State<LoginScreem> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  late String _user = "", _pass = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
        bloc: BlocProvider.of<LoginBloc>(context),
        builder: (context, state) {
          if (state is LoginErrorConectionState) {
            Future.delayed(
                Duration.zero, () => MensagemLogin.erroConexao(context));
                BlocProvider.of<LoginBloc>(context).add(LoginProcessing1());
          }
          if (state is LoginErrorState) {
            Future.delayed(
                Duration.zero, () => MensagemLogin.erroLogin(context));
          }
          if (state is LoginSucessedState) {
            FuncoesAPI().contaUsuario(_user, _pass, user, pass, context);
          }

          return Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFFFFF),
                    Color(0xFFFFFFFF),
                    Color(0xFFFFFFFF),
                    Color(0xFFFFFFFF),
                  ],
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
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
                                    height: MediaQuery.of(context).size.height *
                                        0.0),
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
                                        height:
                                            MediaQuery.of(context).size.height *
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
                                  margin: const EdgeInsets.only(
                                      right: 20, left: 20),
                                  child: SizedBox(
                                    height: 60, //altura do button
                                    width: 150, //Largura button
                                    child: BlocBuilder<LoginBloc, LoginState>(
                                        //bloc: BlocProvider.of<LoginBloc>(context),
                                        builder: (context, state) {
                                      return ElevatedButton(
                                        //  elevation: 5.0,
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            //side: BorderSide(color: Colors.red)
                                          ),
                                          primary:
                                              Colors.red[900], // background
                                          onPrimary: Colors.white, // foreground
                                        ),
                                        onPressed: ((pass.text.isEmpty ||
                                                    user.text.isEmpty) ==
                                                true)
                                            ? () {
                                                BlocProvider.of<LoginBloc>(
                                                        context)
                                                    .add(LoginExecutedError());
                                              }
                                            : () {
                                                BlocProvider.of<LoginBloc>(
                                                        context)
                                                    .add(LoginProcessing());
                                                //FuncoesAPI().contaUsuario(
                                                //_user, _pass, context);
                                                //token(_user, _pass);
                                              },

                                        child: Text("LOGIN",
                                            style: TextStyle(
                                                color: Colors.white,
                                                letterSpacing: 1.5,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                      );
                                    }),
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
          );
          ;
        },
      ),
    );
  }
}

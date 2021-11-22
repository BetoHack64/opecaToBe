import 'package:flutter/material.dart';

class LoginTela extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<LoginTela> {
 void logar(){
   print(" Login efectuado ");
 }
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
                    margin: EdgeInsets.only(top: 20),
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
            child: TextField(
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
            child: TextField(
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
          GestureDetector(
            onTap: () => {/*Colocar o comando onClik Aqui!*/},
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
}

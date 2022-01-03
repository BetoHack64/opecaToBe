// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, prefer_const_literals_to_create_immutables
import 'package:SOP/src/business_logic/blocs/login/loginBloc.dart';
import 'package:SOP/src/business_logic/blocs/login/states/loginState.dart';
import 'package:SOP/src/views/ui/login/containerLogin.dart';
import 'package:SOP/src/views/ui/login/mensagem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreem extends StatefulWidget {
  @override
  _LoginScreemState createState() => _LoginScreemState();
}

class _LoginScreemState extends State<LoginScreem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
        bloc: BlocProvider.of<LoginBloc>(context),
        builder: (context, state) {
          if (state is LoginErrorConectionState) {
            Future.delayed(
                Duration.zero, () => MensagemLogin.erroConexao(context));
          }
          if (state is LoginErrorState) {
            Future.delayed(
                Duration.zero, () => MensagemLogin.erroLogin(context));
          }
          if (state is LoginSucessedState) {
           
          }

          return ContainerLogin();
        },
      ),
    );
  }
}

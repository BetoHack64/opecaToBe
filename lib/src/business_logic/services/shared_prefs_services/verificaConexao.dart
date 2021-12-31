import 'dart:io';

class VerificaConexao {
  
  
  teste() async{
    bool verifica = await conectar();
    return verifica;
  }
  Future<bool>  conectar()async {
    List resultado = [];
    try {
      resultado = await InternetAddress.lookup('google.com');
      print(resultado);
      return resultado.isNotEmpty;
    } catch (e) {}
    return resultado.isNotEmpty;
  }
}

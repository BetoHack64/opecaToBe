import 'package:dio/dio.dart';

class RequisicoesService {
  final dio = Dio();
  String api = "http://83.240.225.239:130/";
  suaRequisicao(parametros) async {
    Response response = await dio.get(api);
    return response.data;
  }
}

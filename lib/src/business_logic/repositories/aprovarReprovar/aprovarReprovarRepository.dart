import 'package:SOP/src/business_logic/dataProviders/aprovarReprovar/aprovarReprovarAPI.dart';
import 'package:SOP/src/business_logic/models/detalhes.dart';

class AprovarReprovarRepository {
  final AprovarReprovarAPI aprovarReprovarAPI = AprovarReprovarAPI();
  Future<OperationData> getDetalhesOperacao(
      String applicationID, String operationID) async {
    OperationData dadosObjecto = OperationData(
      applicationId: '',
      operationCodId: '',
      operationId: '',
      header: Header(campo: '', valor: ''),
      dados: [],
      grelha: Grelha(
          header: Header_grelha(coluna1: '', coluna2: '', coluna3: ''),
          data: []),
      anexo: [],
    );
    final Map<String, dynamic> detalhesJSON =
        await aprovarReprovarAPI.buscaDetalhes(applicationID, operationID);
    //Variaveis para os Dados
    List<Data0> listaData = [];
    List<Data2> listaData2 = [];
    List<Anexo> listaAnexos = [];
    List<Anexo> anexos = [];

    //OperationData detals;
    if (detalhesJSON.isNotEmpty) {
      //print(detalhesJSON['OperationData'].toString());
      //Para os dados do detalhes
      for (var item in detalhesJSON['OperationData']['Data']) {
        Data0 data = Data0(campo: item['Campo'], valor: item['Valor'] ?? "ok");
        listaData.add(data);
      }
      if (detalhesJSON['OperationData']['Anexo'] != null) {
        //Pear dados dos Anexos
        for (var item in detalhesJSON['OperationData']['Anexo']['Data']) {
          Data2 data2 =
              Data2(campo: item['Campo'], valor: item['Valor'] ?? "ok");
          listaData2.add(data2);
          //Pegar os Anexos
          anexos.add(Anexo.fromJson(detalhesJSON['OperationData']['Anexo']));
        }
      } else {
        print('buggs');
      }

      //Para a Construção da  Tabela
      dadosObjecto = OperationData(
        applicationId: detalhesJSON['OperationData']['ApplicationID'],
        operationCodId: detalhesJSON['OperationData']['OperationCodID'],
        operationId: detalhesJSON['OperationData']['OperationID'].toString(),
        header: Header.fromJson(detalhesJSON['OperationData']['Header']),
        dados: listaData,
        grelha: Grelha.fromJson(detalhesJSON['OperationData']['Grelha']),
        anexo: anexos.isNotEmpty ? anexos: [],
      );

      return dadosObjecto;
    } else {
      return dadosObjecto;
    }
  }

  Future<String> getPDFOperacao(String operationID, String contentID) async {
    final String pdfStringJSON =
        await aprovarReprovarAPI.buscaPdf(operationID, contentID);
    return pdfStringJSON;
  }
}

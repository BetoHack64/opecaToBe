import 'package:SOP/src/business_logic/dataProviders/listaOperacoes/cardDetailAPI.dart';
import 'package:SOP/src/business_logic/models/cardDetail.dart';

class CardDetailRepository {
  final CardDetailAPI cardDetailAPI = CardDetailAPI();
  
  Future<List<CardDetail>> getOperationsPerSystem(
      String appID, String accountID) async {
    final List<CardDetail> listaOperacoes = [];
    final Map<String, dynamic> operacoesJSON =
        await cardDetailAPI.getOperationsPerSystem(appID, accountID);
    if (operacoesJSON.isNotEmpty) {
      for (var item in operacoesJSON['Apps']['Operacao']) {
        listaOperacoes.add(
          CardDetail(
            unidadeOrcamental: item['Linha1Campo1'] ?? 'ok',
            title: item['Linha2Campo2'] ?? 'ok',
            subtitle: item['Linha2Campo1'] ?? 'ok',
            valor: item['Linha2Campo3'] ?? '23',
            fornecedor: item['Linha3Campo1'] ?? 'Teste',
            id: item['OperationID'] ?? 'ok'.toString(),
            moeda: item['Linha2Campo4'] ?? 'ok',
          ),
        );
      }
      return listaOperacoes;
    } else {
      return [];
    }
  }
}

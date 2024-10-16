import 'abstract_api.dart';
import 'dart:convert';

class TransacaoService extends AbstractApi {
  TransacaoService() : super('transacoes');

  Future<String> getAll() async {
    return await super.getAll();
  }

  Future<String> getById(String id) async {
    return await super.getById(id);
  }

  Future<String> create(Map<String, dynamic> data) async {
    String response = await getAll();
    List<dynamic> transacoes = json.decode(response) as List<dynamic>;
    
    int maxId = 0;
    for (var transacao in transacoes) {
      int idAtual = int.tryParse(transacao['id'].toString()) ?? 0;
      if (idAtual > maxId) {
        maxId = idAtual;
      }
    }

    data['id'] = (maxId + 1).toString();

    return await super.create(data);
  }

  Future<String> update(String id, Map<String, dynamic> data) async {
    return await super.update(id, data);
  }

  Future<String> delete(String id) async {
    return await super.delete(id);
  }
}

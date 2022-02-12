import 'dart:convert';

import 'package:gpp/src/models/reason_parts_replacement_model.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class ReasonPartsReplacementRepository {
  ApiService api;
  String path = '/motivos-troca-peca';

  ReasonPartsReplacementRepository({
    required this.api,
  });

  Future<List<MotivoTrocaPecaModel>> buscarTodos() async {
    Response response = await api.get(path);

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<MotivoTrocaPecaModel> reasonPartsReplacement = data
          .map<MotivoTrocaPecaModel>(
              (data) => MotivoTrocaPecaModel.fromJson(data))
          .toList();

      return reasonPartsReplacement;
    } else {
      var error = json.decode(response.body)['error'];
      throw Exception(error);
    }
  }

  Future<bool> create(MotivoTrocaPecaModel reasonPartsReplacement) async {
    Response response = await api.post(path, reasonPartsReplacement.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw error;
    }
  }

  Future<bool> update(MotivoTrocaPecaModel reasonPartsReplacement) async {
    Response response = await api.put(
        path + '/' + reasonPartsReplacement.idMotivoTrocaPeca.toString(),
        reasonPartsReplacement.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw error;
    }
  }

  Future<bool> excluir(MotivoTrocaPecaModel reasonPartsReplacement) async {
    Response response = await api.delete(
      path + '/' + reasonPartsReplacement.idMotivoTrocaPeca.toString(),
    );

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw Exception(error);
    }
  }
}

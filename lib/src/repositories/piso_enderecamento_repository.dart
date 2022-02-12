import 'dart:convert';

import 'package:gpp/src/models/piso_enderecamento_model.dart';
import 'package:gpp/src/shared/exceptions/piso_enderecamento_exception.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class PisoEnderecamentoRepository {
  ApiService api;

  PisoEnderecamentoRepository({
    required this.api,
  });

  Future<PisoEnderecamentoModel> fetch(String id) async {
    Response response = await api.get('/enderecamento-piso/' + id);

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      return PisoEnderecamentoModel.fromJson(data.first.first);
    } else {
      throw PisoEnderecamentoException("Piso não encontrado !");
    }
  }

  Future<List<PisoEnderecamentoModel>> fetchAll() async {
    Response response = await api.get('/enderecamento-piso');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<PisoEnderecamentoModel> pisoEnderecamento = data.first
          .map<PisoEnderecamentoModel>((data) => PisoEnderecamentoModel.fromJson(data))
          .toList();

      return pisoEnderecamento;
    } else {
      throw PisoEnderecamentoException("Piso não encontrada !");
    }
  }

  Future<bool> create(PisoEnderecamentoModel pisoEnderecamento) async {
    print(jsonEncode(pisoEnderecamento.toJson()));
    Response response =
        await api.post('/enderecamento-piso', pisoEnderecamento.toJson()); // alteração

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw PisoEnderecamentoException("Piso não foi cadastrado !");
    }
  }

  Future<bool> update(PisoEnderecamentoModel pisoEnderecamento) async {
    Response response = await api.put(
        '/enderecamento-piso/' + pisoEnderecamento.id_piso.toString(),
        pisoEnderecamento.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw PisoEnderecamentoException("Piso não foi atualizado !");
    }
  }

  Future<bool> delete(PisoEnderecamentoModel pisoEnderecamento) async {
    Response response = await api.delete(
      '/enderecamento-piso/' + pisoEnderecamento.id_piso.toString(),
    );

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw PisoEnderecamentoException("Piso não foi deletado !");
    }
  }
}

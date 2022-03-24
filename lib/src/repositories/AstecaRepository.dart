import 'dart:convert';

import 'package:gpp/src/models/PaginaModel.dart';
import 'package:gpp/src/models/asteca/asteca_model.dart';
import 'package:gpp/src/models/asteca/asteca_tipo_pendencia_model.dart';

import 'package:http/http.dart';

import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class AstecaRepository {
  late ApiService api;

  AstecaRepository() {
    api = ApiService();
  }

  Future<List> buscarAstecas(int pagina,
      {AstecaModel? filtroAsteca,
      String? pendencia,
      DateTime? dataInicio,
      DateTime? dataFim}) async {
    Map<String, String> queryParameters = {
      'pagina': pagina.toString(),
      'idAsteca': filtroAsteca?.idAsteca != null
          ? filtroAsteca!.idAsteca.toString()
          : '',
      'cpfCnpj': filtroAsteca?.documentoFiscal?.cpfCnpj?.toString() ?? '',
      'numeroNotaFiscalVenda':
          filtroAsteca?.documentoFiscal?.numDocFiscal?.toString() ?? '',
      'pendencia': pendencia?.toString() ?? '',
      'dataInicio': dataInicio != null ? dataInicio.toString() : '',
      'dataFim': dataFim != null ? dataFim.toString() : ''
    };

    Response response =
        await api.get('/astecas', queryParameters: queryParameters);

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<AstecaModel> astecas = data['astecas']
          .map<AstecaModel>((data) => AstecaModel.fromJson(data))
          .toList();

      //Obtém a pagina
      PaginaModel pagina = PaginaModel.fromJson(data['pagina']);
      return [astecas, pagina];
    } else {
      var error = json.decode(response.body)['error'];
      throw error;
    }
  }

  Future<AstecaModel> buscarAsteca(int id) async {
    Response response = await api.get('/astecas/${id.toString()}');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      return AstecaModel.fromJson(data);
    } else {
      var error = jsonDecode(response.body)['error'];
      throw error;
    }
  }
}

class AstecaTipoPendenciaRepository {
  late ApiService api;

  AstecaTipoPendenciaRepository() {
    api = ApiService();
  }

  Future<List<AstecaTipoPendenciaModel>> buscarAstecaTIpoPendencias() async {
    Response response = await api.get('/asteca-tipo-pendencias');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<AstecaTipoPendenciaModel> astecaTipoPendencia = data
          .map<AstecaTipoPendenciaModel>(
              (data) => AstecaTipoPendenciaModel.fromJson(data))
          .toList();
      return astecaTipoPendencia;
    } else {
      var error = jsonDecode(response.body)['error'];
      throw error;
    }
  }

  Future<bool> inserirAstecaPendencia(
      int id, AstecaTipoPendenciaModel astecaTipoPendencia) async {
    Response response = await api.post(
        '/astecas/${id}/pendencias', astecaTipoPendencia.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw error;
    }
  }
}

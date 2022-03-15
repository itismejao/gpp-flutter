
import 'dart:convert';
import 'package:gpp/src/models/pecas_model/pecas_estoque_model.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class PecaEstoqueRepository{

  ApiService api;

  PecaEstoqueRepository({
    required this.api
  });

  Future<PecasEstoqueModel> buscarEstoque(String id_peca, String? id_filial) async{

    Map<String, String> queryParameters = {
      'id_filial': id_filial != null ? id_filial.toString() : '',
    };

    Response response = await api.get('/pecas/$id_peca/peca-estoque', queryParameters: queryParameters);

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      return PecasEstoqueModel.fromJson(data[0]);

    } else {
      var error = json.decode(response.body)['error'];
      throw error;
    }

  }

  Future<List<PecasEstoqueModel>> consultarEstoque() async{

    Map<String, String> queryParameters = {
    };

    Response response = await api.get('/consulta-estoque', queryParameters: queryParameters);

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      return data['data'].map<PecasEstoqueModel>((data) =>  PecasEstoqueModel.fromJson(data)).toList();

    } else {
      var error = json.decode(response.body)['error'];
      throw error;
    }

  }







}
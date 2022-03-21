
import 'dart:convert';
import 'package:gpp/src/models/PaginaModel.dart';
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

  Future<List> consultarEstoque(int paginaAtual, String filial, String id_peca, String id_produto, String id_fornecedor, bool? endereco, bool disponivel, bool reservado, bool transferencia, String desc_corredor, String desc_estante, String desc_prateleira, String desc_box) async{

    Map<String, String> queryParameters = {
      'page': paginaAtual.toString(),
      'id_filial' : filial,
      'id_peca' : id_peca,
      'id_produto' : id_produto,
      'id_fornecedor' : id_fornecedor,
      'enderecado' : endereco.toString(),
      'disponivel' : disponivel.toString(),
      'reservado' : reservado.toString(),
      'transferencia' : transferencia.toString(),
      'desc_corredor' : desc_corredor,
      'desc_estante' : desc_estante,
      'desc_prateleira' : desc_prateleira,
      'desc_box' : desc_box,
    };

    Response response = await api.get('/consulta-estoque', queryParameters: queryParameters);

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      return [
        data['data'].map<PecasEstoqueModel>((data) =>  PecasEstoqueModel.fromJson(data)).toList(),
        PaginaModel(total: data['last_page'], atual: data['current_page'])
      ];

    } else {
      var error = json.decode(response.body)['error'];
      throw error;
    }

  }







}
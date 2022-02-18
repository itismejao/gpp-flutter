import 'package:flutter/material.dart';
import 'package:gpp/src/models/pecas_model/pecas_linha_model.dart';
import 'package:gpp/src/repositories/pecas_repository/pecas_linha_repository.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class PecasLinhaController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final PecasLinhaRepository pecasLinhaRepository = PecasLinhaRepository(api: gppApi);
  PecasLinhaModel pecasLinhaModel = PecasLinhaModel();

  Future<bool> create() async {
    return await pecasLinhaRepository.create(pecasLinhaModel);
  }

  Future<List<PecasLinhaModel>> buscarTodos() async {
    return await pecasLinhaRepository.buscarTodos();
  }

  Future<bool> excluir(PecasLinhaModel pecasLinhaModel) async {
    return await pecasLinhaRepository.excluir(pecasLinhaModel);
  }
}

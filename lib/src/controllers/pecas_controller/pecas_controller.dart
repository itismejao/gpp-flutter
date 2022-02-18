import 'package:flutter/material.dart';
import 'package:gpp/src/models/pecas_model/pecas_model.dart';
import 'package:gpp/src/repositories/pecas_repository/pecas_repository.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class PecasController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final PecasRepository pecasRepository = PecasRepository(api: gppApi);
  PecasModel pecasModel = PecasModel();

  Future<bool> create() async {
    // if (!formKey.currentState!.validate()) {
    //   return false;
    // }

    return await pecasRepository.create(pecasModel);
  }

  Future<List<PecasModel>> buscarTodos() async {
    // pecasRepository.buscarTodos().then((value) => print(value as Map<String, dynamic>));

    return await pecasRepository.buscarTodos();
  }

  Future<bool> excluir(PecasModel pecasModel) async {
    return await pecasRepository.excluir(pecasModel);
  }
}

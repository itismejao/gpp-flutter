import 'package:flutter/material.dart';
import 'package:gpp/src/models/pecas_model/pecas_especie_model.dart';
import 'package:gpp/src/repositories/pecas_repository/pecas_especie_repository.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class PecasEspecieController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final PecasEspecieRepository pecasEspecieRepository = PecasEspecieRepository(api: gppApi);
  PecasEspecieModel pecasEspecieModel = PecasEspecieModel();

  Future<bool> create() async {
    return await pecasEspecieRepository.create(pecasEspecieModel);
  }

  Future<List<PecasEspecieModel>> buscarTodos() async {
    return await pecasEspecieRepository.buscarTodos();
  }
}

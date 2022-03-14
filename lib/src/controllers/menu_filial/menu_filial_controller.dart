import 'package:flutter/material.dart';
import 'package:gpp/src/models/menu_filial/empresa_filial_model.dart';
import 'package:gpp/src/repositories/menu_filial/menu_filial_repository.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class MenuFilialController {
  late final MenuFilialRepository menuFilialRepository = MenuFilialRepository(api: gppApi);

  Future<List<EmpresaFilialModel>> buscarTodos() async {
    return await menuFilialRepository.buscarTodos();
  }
}

import 'package:flutter/material.dart';
import 'package:gpp/src/models/menu_filial/empresa_filial_model.dart';
import 'package:gpp/src/models/menu_filial/filial_model.dart';
import 'package:gpp/src/repositories/menu_filial/menu_filial_repository.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class FilialController {
  late final FilialRepository filialRepository = FilialRepository(api: gppApi);

  static EmpresaFilialModel? selectedFilial = EmpresaFilialModel(
    id_empresa: 1,
    id_filial: 500,
    filial: FilialModel(id_filial: 500, sigla: 'DP/ASTEC'),
  );

  Future<List<EmpresaFilialModel>> buscarTodos() async {
    return await filialRepository.buscarTodos();
  }
}

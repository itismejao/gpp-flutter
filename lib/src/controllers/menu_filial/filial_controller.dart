import 'package:flutter/material.dart';
import 'package:gpp/src/models/menu_filial/empresa_filial_model.dart';
import 'package:gpp/src/models/menu_filial/filial_model.dart';
import 'package:gpp/src/repositories/menu_filial/menu_filial_repository.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:gpp/src/shared/utils/Usuario.dart';

class FilialController {
  late final FilialRepository filialRepository = FilialRepository(api: gppApi);

  static EmpresaFilialModel? selectedFilial = EmpresaFilialModel(
    id_empresa: 1,
    id_filial: 500,
    filial: FilialModel(id_filial: 500, sigla: 'DP/ASTEC'),
  );

  static void filialLogin() {
    List filiaisAsteca = [89, 101, 106, 116, 119, 210, 217, 451, 500, 516, 519, 520, 529, 541, 545, 547, 548, 901];

    if (filiaisAsteca.contains(usuario.idFilial)) {
      selectedFilial = EmpresaFilialModel(id_filial: usuario.idFilial);
    } else {
      selectedFilial = EmpresaFilialModel(
        id_empresa: 1,
        id_filial: 500,
        filial: FilialModel(id_filial: 500, sigla: 'DP/ASTEC'),
      );
    }
  }

  Future<List<EmpresaFilialModel>> buscarTodos() async {
    return await filialRepository.buscarTodos();
  }
}

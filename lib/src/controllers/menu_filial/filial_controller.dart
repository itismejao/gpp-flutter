import 'package:gpp/src/models/filial/empresa_filial_model.dart';
import 'package:gpp/src/models/filial/filial_model.dart';
import 'package:gpp/src/repositories/menu_filial/menu_filial_repository.dart';
import 'package:gpp/src/shared/services/auth.dart';

import 'package:gpp/src/shared/utils/Usuario.dart';

class FilialController {
  late final FilialRepository filialRepository = FilialRepository();
  FilialModel filialModel = FilialModel();

  static void filialLogin() {
    List filiaisAsteca = [
      89,
      101,
      106,
      116,
      119,
      210,
      217,
      451,
      500,
      516,
      519,
      520,
      529,
      541,
      545,
      547,
      548,
      901
    ];

    if (filiaisAsteca.contains(usuario.idFilial)) {
      setFilial(filial: EmpresaFilialModel(id_filial: usuario.idFilial));
    } else {
      setFilial(
          filial: EmpresaFilialModel(
        id_empresa: 1,
        id_filial: 500,
        filial: FilialModel(id_filial: 500, sigla: 'DP/ASTEC'),
      ));
    }
  }

  Future<List<EmpresaFilialModel>> buscarTodos() async {
    return await filialRepository.buscarTodos();
  }
}

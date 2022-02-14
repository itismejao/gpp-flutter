import 'package:flutter/material.dart';
import 'package:gpp/src/models/pecas_model/pecas_material_model.dart';
import 'package:gpp/src/repositories/pecas_repository/pecas_material_repository.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class PecasMaterialController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final PecasMaterialRepository pecasMaterialRepository = PecasMaterialRepository(api: gppApi);
  PecasMaterialModel pecasMaterialModel = PecasMaterialModel();

  Future<bool> create() async {
    return await pecasMaterialRepository.create(pecasMaterialModel);
  }

  Future<List<PecasMaterialModel>> buscarTodos() async {
    return await pecasMaterialRepository.buscarTodos();
  }
}

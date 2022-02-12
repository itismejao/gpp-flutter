import 'package:flutter/material.dart';
import 'package:gpp/src/models/pecas_model/pecas_cor_model.dart';
import 'package:gpp/src/repositories/pecas_repository/pecas_cor_repository.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class PecasCorController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final PecasCorRepository pecasCorRepository = PecasCorRepository(api: gppApi);
  PecasCorModel pecasCorModel = PecasCorModel();

  Future<bool> create() async {
    return await pecasCorRepository.create(pecasCorModel);
  }
}

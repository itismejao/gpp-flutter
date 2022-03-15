import 'package:flutter/cupertino.dart';

import 'package:gpp/src/models/pecas_model/pecas_estoque_model.dart';
import 'package:gpp/src/repositories/pecas_repository/peca_estoque_repository.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class PecaEstoqueController{
  List<PecasEstoqueModel?> pecas_estoque = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final PecaEstoqueRepository pecasEstoqueRepository = PecaEstoqueRepository(api: gppApi);

  Future<PecasEstoqueModel?> buscarEstoque(String id_peca, int? id_filial) async {
    return pecasEstoqueRepository.buscarEstoque(id_peca, id_filial.toString());
  }

  void consultarEstoque() async {
    pecas_estoque = await pecasEstoqueRepository.consultarEstoque();
  }


}
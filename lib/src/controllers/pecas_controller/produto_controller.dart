import 'package:flutter/material.dart';
import 'package:gpp/src/models/pecas_model/produto_model.dart';
import 'package:gpp/src/repositories/pecas_repository/produto_repositoy.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class ProdutoController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final ProdutoRepository produtoRepository =
      ProdutoRepository(api: gppApi);

  ProdutoModel produtoModel = ProdutoModel();

  List<ProdutoModel> listaProdutos = [];

  Future<void> buscar(String id) async {
    produtoModel = await produtoRepository.buscar(id);
  }

  Future<ProdutoModel> buscar2(String id) async {
    return await produtoRepository.buscar(id);
  }
}

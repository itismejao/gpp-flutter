import 'package:flutter/material.dart';
import 'package:gpp/src/models/pecas_model/pecas_model.dart';
import 'package:gpp/src/models/pecas_model/pecas_pagina_model.dart';
import 'package:gpp/src/models/pecas_model/produto_peca_model.dart';
import 'package:gpp/src/repositories/pecas_repository/pecas_repository.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class PecasController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<PecasModel> pecas = [];
  late final PecasRepository pecasRepository = PecasRepository(api: gppApi);

  PecasModel pecasModel = PecasModel();
  List<PecasModel> listaPecas = [];
  PecasPaginaModel pecasPagina =
      PecasPaginaModel(paginaAtual: 1, paginaTotal: 0);

  bool carregado = false;

  ProdutoPecaModel produtoPecaModel = ProdutoPecaModel();

  Future<PecasModel> criarPeca() async {
    return await pecasRepository.criarPeca(pecasModel);
  }

  Future<bool> criarProdutoPeca() async {
    return await pecasRepository.criarProdutoPeca(produtoPecaModel);
  }

  Future<List> buscarTodos(int pagina) async {
    return await pecasRepository.buscarTodos(pagina);
  }

  Future<PecasModel> buscar(String codigo) async {
    return await pecasRepository.buscar(codigo);
  }

  Future<bool> excluir(PecasModel pecasModel) async {
    return await pecasRepository.excluir(pecasModel);
  }

  Future<bool> editar() async {
    return await pecasRepository.editar(pecasModel);
  }

  Future<bool> editarProdutoPeca() async {
    return await pecasRepository.editarProdutoPeca(produtoPecaModel);
  }
}

import 'package:flutter/material.dart';
import 'package:gpp/src/models/PaginaModel.dart';
import 'package:gpp/src/models/pecas_model/PecaModel.dart';

import 'package:gpp/src/models/pecas_model/produto_peca_model.dart';

import 'package:gpp/src/repositories/pecas_repository/produto_repositoy.dart';

import '../models/pecas_model/produto_model.dart';
import '../repositories/PecaRepository.dart';

class PecaController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<PecasModel> pecas = [];
  late final PecaRepository pecaRepository;
  late final ProdutoRepository produtoRepository;
  ProdutoModel produto = ProdutoModel();

  PecasModel pecasModel = PecasModel();
  List<PecasModel> listaPecas = [];
  PaginaModel pagina = PaginaModel(total: 0, atual: 1);

  bool carregado = false;

  ProdutoPecaModel produtoPecaModel = ProdutoPecaModel();

  PecaController() {
    pecaRepository = PecaRepository();
    produtoRepository = ProdutoRepository();
  }

  // Future<PecasModel> criarPeca() async {
  //   return await pecasRepository.criarPeca(pecasModel);
  // }

  // Future<bool> criarProdutoPeca() async {
  //   return await pecasRepository.criarProdutoPeca(produtoPecaModel);
  // }

  // Future<List> buscarTodos(int pagina) async {
  //   return await pecasRepository.buscarTodos(pagina);
  // }

  // Future<PecasModel> buscar(String codigo) async {
  //   return await pecasRepository.buscar(codigo);
  // }

  // Future<bool> excluir(PecasModel pecasModel) async {
  //   return await pecasRepository.excluir(pecasModel);
  // }

  // Future<bool> editar() async {
  //   return await pecasRepository.editar(pecasModel);
  // }

  // Future<bool> editarProdutoPeca() async {
  //   return await pecasRepository.editarProdutoPeca(produtoPecaModel);
  // }
}

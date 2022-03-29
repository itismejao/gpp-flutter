import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpp/src/models/PaginaModel.dart';
import 'package:gpp/src/models/pecas_model/peca_model.dart';
import 'package:gpp/src/models/produto/produto_model.dart';
import 'package:gpp/src/models/produto_peca_model.dart';
import 'package:gpp/src/repositories/pecas_repository/produto_repositoy.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/shared/utils/MaskFormatter.dart';
import 'package:gpp/src/utils/notificacao.dart';

import '../../../shared/components/CheckboxComponent.dart';
import '../../../shared/components/InputComponent.dart';

class ProdutoController extends GetxController {
  var carregando = true.obs;
  late ProdutoRepository produtoRepository;
  late List<ProdutoModel> produtos;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Rx<PaginaModel> pagina;

  int marcados = 0;

  ProdutoController() {
    produtoRepository = ProdutoRepository();
    produtos = <ProdutoModel>[].obs;
    pagina = PaginaModel(atual: 1, total: 0).obs;
  }

  @override
  void onInit() async {
    buscarProdutos();
    super.onInit();
  }

  buscarProdutos() async {
    try {
      carregando(true);
      var retorno =
          await produtoRepository.buscarProdutos(this.pagina.value.atual);

      this.produtos = retorno[0];
      this.pagina = retorno[1];
    } finally {
      carregando(false);
    }
  }

  pesquisarProduto(value) async {
    try {
      carregando(true);
      var retorno =
          await produtoRepository.buscarProdutos(this.pagina.value.atual);

      this.produtos = retorno[0];
      this.pagina = retorno[1];
    } finally {
      carregando(false);
    }
  }
}

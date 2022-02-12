import 'package:flutter/material.dart';
import 'package:gpp/src/models/asteca_model.dart';
import 'package:gpp/src/models/documento_fiscal_model.dart';
import 'package:gpp/src/models/subfuncionalities_model.dart';
import 'package:gpp/src/repositories/asteca_repository.dart';

import 'package:gpp/src/shared/enumeration/asteca_enum.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class PisoEnderecamentoController {
  int step = 1;
  bool isOpenFilter = false;
  int pagina = 1;
  bool carregado = false;
  GlobalKey<FormState> filtroFormKey = GlobalKey<FormState>();
  AstecaRepository repository = AstecaRepository();
  AstecaModel filtroAsteca =
      AstecaModel(documentoFiscal: DocumentoFiscalModel());
  List<AstecaModel> astecas = [];

}

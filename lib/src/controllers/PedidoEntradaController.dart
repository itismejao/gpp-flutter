import 'package:flutter/material.dart';
import 'package:gpp/src/models/PaginaModel.dart';
import 'package:gpp/src/models/PedidoEntradaModel.dart';
import 'package:gpp/src/models/PedidoSaidaModel.dart';
import 'package:gpp/src/models/fornecedor_model.dart';
import 'package:gpp/src/repositories/PedidoEntradaRepository.dart';
import 'package:gpp/src/repositories/PedidoRepository.dart';
import 'package:intl/intl.dart';

class PedidoEntradaController {
  int? idPedidoEntrada;

  DateTime? dataInicio;
  DateTime? dataFim;
  int? situacao;
  PedidoEntradaRepository pedidoEntradaRepository = PedidoEntradaRepository();
  bool carregado = false;
  List<PedidoEntradaModel> pedidosEntrada = [];
  PedidoSaidaModel pedido = PedidoSaidaModel();
  GlobalKey<FormState> filtroFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> filtroExpandidoFormKey = GlobalKey<FormState>();
  bool abrirFiltro = false; // false
  PaginaModel pagina = PaginaModel(total: 0, atual: 1);
  NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
}

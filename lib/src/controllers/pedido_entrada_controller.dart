import 'package:flutter/material.dart';
import 'package:gpp/src/models/PaginaModel.dart';
import 'package:gpp/src/models/pedido_entrada_model.dart';
import 'package:gpp/src/repositories/pedido_entrada_repository.dart';
import 'package:intl/intl.dart';

class PedidoEntradaController {
  int? idPedidoEntrada;
  bool pedidoEntradaCriado = false;
  DateTime? dataInicio;
  DateTime? dataFim;
  int? situacao;
  PedidoEntradaRepository repository = PedidoEntradaRepository();
  bool carregado = false;
  List<PedidoEntradaModel> pedidosEntrada = [];
  PedidoEntradaModel pedidoEntrada = PedidoEntradaModel();
  GlobalKey<FormState> filtroFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> filtroExpandidoFormKey = GlobalKey<FormState>();
  bool abrirFiltro = false; // false
  PaginaModel pagina = PaginaModel(total: 0, atual: 1);
  NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
}

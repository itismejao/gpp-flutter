import 'package:flutter/material.dart';
import 'package:gpp/src/models/PaginaModel.dart';
import 'package:gpp/src/models/PedidoEntradaModel.dart';
import 'package:gpp/src/repositories/PedidoEntradaRepository.dart';
import 'package:intl/intl.dart';

class PedidoEntradaController {
  int? idPedidoEntrada;

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

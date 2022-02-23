import 'package:flutter/material.dart';
import 'package:gpp/src/models/PaginaModel.dart';
import 'package:gpp/src/models/PedidoSaidaModel.dart';
import 'package:gpp/src/repositories/PedidoRepository.dart';

class PedidoController {
  int? idPedido;
  DateTime? dataInicio;
  DateTime? dataFim;
  int? situacao;
  PedidoRepository pedidoRepository = PedidoRepository();
  bool carregado = false;
  List<PedidoSaidaModel> pedidos = [];
  GlobalKey<FormState> filtroFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> filtroExpandidoFormKey = GlobalKey<FormState>();
  bool abrirFiltro = false; // false
  PaginaModel pagina = PaginaModel(total: 0, atual: 1);
}

import 'package:flutter/material.dart';
import 'package:gpp/src/models/PaginaModel.dart';
import 'package:gpp/src/models/PedidoSaidaModel.dart';
import 'package:gpp/src/repositories/pedido_saida_repository.dart';
import 'package:intl/intl.dart';

class PedidoController {
  int? idPedido;
  DateTime? dataInicio;
  DateTime? dataFim;
  int? situacao;
  PedidoSaidaRepository pedidoRepository = PedidoSaidaRepository();
  bool carregado = false;
  List<PedidoSaidaModel> pedidos = [];
  PedidoSaidaModel pedido = PedidoSaidaModel();
  GlobalKey<FormState> filtroFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> filtroExpandidoFormKey = GlobalKey<FormState>();
  bool abrirFiltro = false; // false
  PaginaModel pagina = PaginaModel(total: 0, atual: 1);
  NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');

  camelCaseAll(String? value) {
    String? nome = '';
    value!.split(" ").forEach((element) {
      if (element.length > 3) {
        nome = nome! +
            " ${toBeginningOfSentenceCase(element.toString().toLowerCase())}";
      } else {
        nome = nome! + " ${element.toString().toLowerCase()}";
      }
    });
    return nome;
  }

  camelCaseFirst(String? value) {
    return toBeginningOfSentenceCase(value.toString().toLowerCase());
  }
}

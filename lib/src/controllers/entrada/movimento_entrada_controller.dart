
import 'package:gpp/src/models/ItemPedidoEntradaModel.dart';
import 'package:gpp/src/models/entrada/item_movimento_entrada_model.dart';
import 'package:gpp/src/models/entrada/movimento_entrada_model.dart';
import 'package:gpp/src/repositories/entrada/movimento_entrada_repository.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

import '../../models/PedidoEntradaModel.dart';

class MovimentoEntradaController{

  MovimentoEntradaModel? movimentoEntradaModel = MovimentoEntradaModel();

  List<ItemPedidoEntradaModel> listaItensSomados = [];

  int? id_fornecedor;

  late final MovimentoEntradaRepository movimentoEntradaRepository = MovimentoEntradaRepository(api: gppApi);

  Future<List<MovimentoEntradaModel>> buscarTodos(String? id_filial, {String? id_funcionario}) async{
    return await movimentoEntradaRepository.buscarTodos(id_filial,id_funcionario: id_funcionario);
  }

  somarLista(List<ItemPedidoEntradaModel>? listaItensPedido){
    listaItensPedido?.forEach((itemPedido) {
      ItemPedidoEntradaModel ip;
      //ip = listaItensSomados.firstWhere((itemSomado) => itemPedido.idItemPedidoEntrada == itemSomado.idItemPedidoEntrada, orElse: ()=>ItemPedidoEntradaModel());
      int index = listaItensSomados.indexWhere((element) => itemPedido.idItemPedidoEntrada == element.idItemPedidoEntrada);
      if (index == -1){
        listaItensSomados.add(itemPedido);
      }
      else {
        listaItensSomados[index].quantidade = listaItensSomados[index].quantidade! + itemPedido.quantidade!;
      }
    });


  }

  ItensPedidoToItensEntrada(PedidoEntradaModel pedidoEntradaModel){
    pedidoEntradaModel.itensPedidoEntrada?.forEach((element) {
      movimentoEntradaModel?.itemMovimentoEntradaModel?.add(ItemMovimentoEntradaModel(

      ));
    });
  }

}

import 'package:gpp/src/models/ItemPedidoEntradaModel.dart';
import 'package:gpp/src/models/entrada/item_movimento_entrada_model.dart';
import 'package:gpp/src/models/entrada/movimento_entrada_model.dart';
import 'package:gpp/src/repositories/entrada/movimento_entrada_repository.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

import '../../models/PedidoEntradaModel.dart';

class MovimentoEntradaController{

  MovimentoEntradaModel? movimentoEntradaModel = MovimentoEntradaModel();

  List<ItemPedidoEntradaModel> listaItensSomados = [];

  late final MovimentoEntradaRepository movimentoEntradaRepository = MovimentoEntradaRepository(api: gppApi);

  Future<List<MovimentoEntradaModel>> buscarTodos(String? id_filial, {String? id_funcionario}) async{
    return await movimentoEntradaRepository.buscarTodos(id_filial,id_funcionario: id_funcionario);
  }

  somarLista(List<ItemPedidoEntradaModel> listaItensPedido){
    listaItensPedido.forEach((itemPedido) {
      ItemPedidoEntradaModel ip;
      ip = listaItensSomados.firstWhere((itemSomado) => itemPedido.idItemPedidoEntrada == itemSomado.idItemPedidoEntrada, orElse: ()=>ItemPedidoEntradaModel());
      if (ip.quantidade == null){
        listaItensSomados.add(itemPedido);
      } else {
        //Soma na quantidade
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
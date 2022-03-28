import 'package:gpp/src/models/ItemPedidoEntradaModel.dart';
import 'package:gpp/src/models/entrada/item_movimento_entrada_model.dart';
import 'package:gpp/src/models/entrada/movimento_entrada_model.dart';
import 'package:gpp/src/repositories/entrada/movimento_entrada_repository.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class MovimentoEntradaController {
  MovimentoEntradaModel? movimentoEntradaModel = MovimentoEntradaModel();

  List<ItemPedidoEntradaModel> listaItensSomados = [];

  List<ItemMovimentoEntradaModel> listaItens = [];

  int? id_fornecedor;

  late final MovimentoEntradaRepository movimentoEntradaRepository = MovimentoEntradaRepository();

  Future<List<MovimentoEntradaModel>> buscarTodos(String? id_filial, {String? id_funcionario}) async {
    return await movimentoEntradaRepository.buscarTodos(id_filial, id_funcionario: id_funcionario);
  }

  Future<bool> create() async {
    movimentoEntradaModel?.id_funcionario = 1033293;
    movimentoEntradaModel?.itemMovimentoEntradaModel = listaItens;
    return await movimentoEntradaRepository.create(movimentoEntradaModel);
  }

  somarLista(List<ItemPedidoEntradaModel>? listaItensPedido) {
    listaItensPedido?.forEach((itemPedido) {
      //ip = listaItensSomados.firstWhere((itemSomado) => itemPedido.idItemPedidoEntrada == itemSomado.idItemPedidoEntrada, orElse: ()=>ItemPedidoEntradaModel());
      int index = listaItensSomados.indexWhere((element) => itemPedido.peca?.id_peca == element.peca?.id_peca);
      if (index == -1) {
        listaItensSomados.add(itemPedido);
      } else {
        listaItensSomados[index].quantidade = listaItensSomados[index].quantidade! + itemPedido.quantidade!;
        print(itemPedido.quantidade!);
      }
    });
  }

  subtrairLista(List<ItemPedidoEntradaModel>? listaItensPedido) {
    listaItensPedido?.forEach((itemPedido) {
      //ip = listaItensSomados.firstWhere((itemSomado) => itemPedido.idItemPedidoEntrada == itemSomado.idItemPedidoEntrada, orElse: ()=>ItemPedidoEntradaModel());
      int index = listaItensSomados.indexWhere((element) => itemPedido.peca?.id_peca == element.peca?.id_peca);
      if (index != -1) {
        print(itemPedido.quantidade!);
        listaItensSomados[index].quantidade = listaItensSomados[index].quantidade! - itemPedido.quantidade!;
        if (listaItensSomados[index].quantidade == 0){
          listaItensSomados.removeAt(index);
        }
      }
    });
  }

  bool ItensPedidoToItensEntrada() {
    bool sucess = true;
    movimentoEntradaModel!.custo_total = 0;
    movimentoEntradaModel!.data_entrada = DateTime.now();
    listaItensSomados.forEach((element) {
      if (element.quantidade_recebida == null) {
        sucess = false;
      } else {
        ItemMovimentoEntradaModel itemEntrada = ItemMovimentoEntradaModel(
            quantidade: element.quantidade_recebida,
            quantidade_pedido: element.quantidade,
            id_peca: element.peca!.id_peca,
            pecaModel: element.peca,
            valor_unitario: element.custo);
        listaItens.add(itemEntrada);
        movimentoEntradaModel!.custo_total = (movimentoEntradaModel!.custo_total! + element.custo!);
      }
    });
    return sucess;
  }
}

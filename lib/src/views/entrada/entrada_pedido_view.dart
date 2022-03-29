import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpp/src/controllers/pedido_entrada_controller.dart';
import 'package:gpp/src/controllers/entrada/movimento_entrada_controller.dart';

import 'package:gpp/src/models/pedido_entrada_model.dart';
import 'package:gpp/src/shared/components/ButtonComponentExpanded.dart';
import 'package:gpp/src/shared/utils/CurrencyPtBrInputFormatter.dart';
import 'package:gpp/src/utils/notificacao.dart';

import '../../shared/components/TextComponent.dart';
import '../../shared/components/TitleComponent.dart';
import '../../shared/repositories/styles.dart';

class EntradaPedidoView extends StatefulWidget {
  const EntradaPedidoView({Key? key}) : super(key: key);

  @override
  _EntradaPedidoViewState createState() => _EntradaPedidoViewState();
}

class _EntradaPedidoViewState extends State<EntradaPedidoView> {
  GlobalKey<FormState> filtroFormKey = GlobalKey<FormState>();
  PedidoEntradaController pedidoEntradaController = PedidoEntradaController();
  MovimentoEntradaController movimentoEntradaController =
      MovimentoEntradaController();

  TextEditingController _controllerNumPedido = TextEditingController();
  TextEditingController _controllerFornecedor = TextEditingController();
  TextEditingController _controllerNotaFiscal = TextEditingController();
  TextEditingController _controllerSerie = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16, bottom: 16),
              child: Row(
                children: [
                  const Padding(padding: EdgeInsets.only(left: 20)),
                  const Icon(Icons.input),
                  const Padding(padding: EdgeInsets.only(right: 12)),
                  const TitleComponent('Entrada via Pedido'),
                ],
              ),
            ),
            const Divider(),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 5)),
                Flexible(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: _controllerNotaFiscal,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Nota Fiscal',
                        labelText: 'Nota Fiscal',
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.only(top: 15, bottom: 10, left: 10),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 10)),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: _controllerSerie,
                      //maxLength: 2,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Série',
                        labelText: 'Série',
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.only(top: 15, bottom: 10, left: 10),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 5)),
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            const Divider(),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 5)),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Form(
                      key: filtroFormKey,
                      child: TextFormField(
                        controller: _controllerNumPedido,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onFieldSubmitted: (value) {
                          if (_controllerNumPedido != '') {
                            adicionarPedido(value);
                            filtroFormKey.currentState!.reset();
                          }
                        },
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          //suffix: CircularProgressIndicator(),
                          hintText: 'Pedido',
                          labelText: 'Digite o número do pedido',
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.only(top: 15, bottom: 10, left: 10),
                          suffixIcon: IconButton(
                            tooltip: 'Buscar',
                            onPressed: () {
                              if (_controllerNumPedido != '') {
                                adicionarPedido(_controllerNumPedido.text);
                                filtroFormKey.currentState!.reset();
                              }
                            },
                            icon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 5)),
                Flexible(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: _controllerFornecedor,
                      enabled: false,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Fornecedor',
                        labelText: 'Fornecedor',
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.only(top: 15, bottom: 10, left: 10),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 5)),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            pedidoEntradaController.pedidosEntrada.isEmpty
                ? Container()
                : Container(
                    height: 45,
                    width: media.width,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: pedidoEntradaController.pedidosEntrada.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              width: 80,
                              child: Card(
                                color: secundaryColor,
                                child: Expanded(
                                  child: Text(
                                    'Pedido\n' +
                                        pedidoEntradaController
                                            .pedidosEntrada[index]
                                            .idPedidoEntrada
                                            .toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 88,
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () {
                                  removerPedido(pedidoEntradaController
                                      .pedidosEntrada[index].idPedidoEntrada);
                                },
                                icon: Icon(
                                  Icons.close,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
            const Padding(padding: EdgeInsets.only(top: 15)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.handyman,
                    size: 32,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const TitleComponent('Peças'),
                  //new Spacer(),
                  //ButtonComponent(onPressed: () {}, text: 'Adicionar Peça'),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: const TextComponent(
                      'Cod. Peça',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: const TextComponent('Descrição Peça'),
                  ),
                  Expanded(
                    child: const TextComponent(
                      'Qtd. Pedida',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: const TextComponent(
                      'Qtd. Recebida',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: const TextComponent(
                      'Valor Unitário',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: const TextComponent(
                      'Ações',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Center(
              child: Container(
                height: media.height / 2,
                child: ListView.builder(
                  primary: false,
                  itemCount:
                      movimentoEntradaController.listaItensSomados.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextComponent(
                                movimentoEntradaController
                                        .listaItensSomados[index].peca?.id_peca
                                        .toString() ??
                                    '-',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextComponent(
                                movimentoEntradaController
                                        .listaItensSomados[index]
                                        .peca
                                        ?.descricao ??
                                    '-',
                              ),
                            ),
                            Expanded(
                              child: TextComponent(
                                movimentoEntradaController
                                    .listaItensSomados[index].quantidade
                                    .toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Qtd',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: 5, bottom: 5, left: 5, right: 5),
                                  ),
                                  onChanged: (value) {
                                    if (value == '')
                                      movimentoEntradaController
                                          .listaItensSomados[index]
                                          .quantidade_recebida = null;
                                    else
                                      movimentoEntradaController
                                              .listaItensSomados[index]
                                              .quantidade_recebida =
                                          int.parse(value);
                                  },
                                ),
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(left: 5)),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CurrencyPtBrInputFormatter()
                                  ],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: '0,00',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: 5, bottom: 5, left: 5, right: 5),
                                    prefixText: 'R\$ ',
                                  ),
                                  onChanged: (value) {
                                    if (value == '')
                                      movimentoEntradaController
                                          .listaItensSomados[index].custo = 0;
                                    else
                                      movimentoEntradaController
                                              .listaItensSomados[index].custo =
                                          (double.parse(value
                                              .replaceAll('.', '')
                                              .replaceAll(',', '.')));
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: IconButton(
                                    tooltip: 'Excluir Item',
                                    icon: Icon(
                                      Icons.delete_outlined,
                                      color: Colors.grey.shade400,
                                    ),
                                    onPressed: () async {
                                      try {
                                        if (await Notificacao.confirmacao(
                                            'Deseja remover a entrada da peça ${movimentoEntradaController.listaItensSomados[index].peca?.descricao}?')) {
                                          setState(() {
                                            movimentoEntradaController
                                                .listaItensSomados
                                                .removeAt(index);
                                          });
                                          Notificacao.snackBar(
                                              'Item removido com sucesso!');
                                        }
                                      } catch (e) {
                                        Notificacao.snackBar(e.toString());
                                      }
                                    },
                                  ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            const Divider(),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(padding: EdgeInsets.only(left: 5)),
                Expanded(
                  child: ButtonComponentExpanded(
                    onPressed: () {
                      lancarEntrada();
                    },
                    text: 'Lançar Entrada',
                    color: primaryColor,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 5)),
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 30)),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }

  adicionarPedido(String numPedido) async {
    PedidoEntradaModel pedidoEntradaBusca;

    try {
      pedidoEntradaBusca = await pedidoEntradaController.repository
          .buscarPedidoEntrada(int.parse(numPedido));

      //Testa se fornecedor ja foi carregado e o carrega caso não
      if (movimentoEntradaController.id_fornecedor == null) {
        movimentoEntradaController.id_fornecedor = pedidoEntradaBusca.asteca
            ?.compEstProd!.first.produto!.fornecedores!.first.idFornecedor;
        setState(() {
          _controllerFornecedor.text = pedidoEntradaBusca.asteca?.compEstProd!
                  .first.produto!.fornecedores!.first.cliente?.nome ??
              '';
        });
      }

      //Testa se o fornecedor do pedido buscado é o mesmo do já indexado
      if (movimentoEntradaController.id_fornecedor ==
          pedidoEntradaBusca.asteca?.compEstProd!.first.produto!.fornecedores!
              .first.idFornecedor) {
        //Testa se o pedido ja foi adicionado
        if (pedidoEntradaController.pedidosEntrada.any((element) =>
            element.idPedidoEntrada == pedidoEntradaBusca.idPedidoEntrada)) {
          Notificacao.snackBar('Pedido já adicionado!');
        } else {
          setState(() {
            pedidoEntradaController.pedidosEntrada.add(pedidoEntradaBusca);
            movimentoEntradaController.somarLista(
                pedidoEntradaController.pedidosEntrada.last.itensPedidoEntrada);
          });
          movimentoEntradaController.movimentoEntradaModel?.id_pedido_entrada!
              .add(pedidoEntradaBusca.idPedidoEntrada!);
        }
      } else {
        Notificacao.snackBar(
            'Pedido não adicionado pois não pertence ao mesmo fornecedor!');
      }
    } catch (e) {
      Notificacao.snackBar(e.toString());
    }
  }

  removerPedido(int? id_pedido) {
    try {
      setState(() {
        int index = pedidoEntradaController.pedidosEntrada.indexWhere(
            (element) =>
                element.idPedidoEntrada == id_pedido); //Pega o indice do pedido
        movimentoEntradaController.subtrairLista(pedidoEntradaController
            .pedidosEntrada[index]
            .itensPedidoEntrada); //Subtrai o remove a quantidade dos itens
        pedidoEntradaController.pedidosEntrada
            .removeAt(index); //Remove o pedido
      });
      Notificacao.snackBar('Pedido removido com sucesso!');

      //verifica se todos os pedidos foram excluidos e remove o fornecedor
      if (pedidoEntradaController.pedidosEntrada.length == 0) {
        movimentoEntradaController.id_fornecedor = null;
        _controllerFornecedor.text = '';
      }
    } catch (e) {
      Notificacao.snackBar('Erro ao remover pedido');
    }
  }

  lancarEntrada() async {
    if (_controllerNotaFiscal.text == '' || _controllerSerie.text == '') {
      Notificacao.snackBar('Numero da Nota Fiscal e Série são obrigatórios!');
    } else if (movimentoEntradaController.listaItensSomados.isEmpty) {
      Notificacao.snackBar('É necessário adionar as peças para dar a entrada!');
    } else {
      movimentoEntradaController.movimentoEntradaModel?.num_nota_fiscal =
          int.parse(_controllerNotaFiscal.text);
      movimentoEntradaController.movimentoEntradaModel?.serie =
          _controllerNotaFiscal.text;
      bool success = movimentoEntradaController.ItensPedidoToItensEntrada();
      if (success) {
        try {
          if (await movimentoEntradaController.create()) {
            Notificacao.snackBar('Entrada realizada com sucesso');
            Navigator.pushNamed(context, 'astecas');
          }
        } catch (e) {
          Notificacao.snackBar(e.toString());
        }
      } else {
        Notificacao.snackBar(
            'Existem items com a quantidade recebida não informada!');
      }
    }
  }
}

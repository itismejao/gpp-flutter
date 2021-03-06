import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/pedido_entrada_controller.dart';
import 'package:gpp/src/models/ItemPedidoEntradaModel.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/InputComponent.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/utils/MaskFormatter.dart';

class PedidoEntradaDetalheView extends StatefulWidget {
  final int id;

  PedidoEntradaDetalheView({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _PedidoEntradaDetalheViewState createState() =>
      _PedidoEntradaDetalheViewState();
}

class _PedidoEntradaDetalheViewState extends State<PedidoEntradaDetalheView> {
  late PedidoEntradaController controller;
  late MaskFormatter maskFormatter;

  buscar() async {
    setState(() {
      controller.carregado = false;
    });
    controller.pedidoEntrada =
        await controller.repository.buscarPedidoEntrada(widget.id);

    setState(() {
      controller.carregado = true;
    });
  }

  @override
  void initState() {
    super.initState();
    //Inicializa pedido controller
    controller = PedidoEntradaController();
    //Inicializa mask formatter
    maskFormatter = MaskFormatter();
    //buscar o pedido
    buscar();
  }

  Widget _buildListItem(List<ItemPedidoEntradaModel> itensPedido, int index,
      BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
            onTap: () {
              // Navigator.pushNamed(
              //     context, '/pedidos-entrada/' + pedido[index].idPedidoSaida.toString());
            },
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                    color:
                        (index % 2) == 0 ? Colors.white : Colors.grey.shade50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextComponent(
                                '#' +
                                    itensPedido[index]
                                        .idItemPedidoEntrada
                                        .toString(),
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: TextComponent(
                                  itensPedido[index].peca!.descricao!,
                                )),
                            Expanded(
                                child: TextComponent(
                              itensPedido[index].quantidade.toString(),
                            )),
                            Expanded(
                              child: TextComponent(
                                  itensPedido[index].custo != null
                                      ? controller.formatter
                                          .format(itensPedido[index].custo)
                                      : ''),
                            ),
                            Expanded(
                                child: TextComponent(
                              itensPedido[index].custo != null
                                  ? controller.formatter.format(
                                      (itensPedido[index].custo! *
                                          itensPedido[index].quantidade!))
                                  : '',
                            )),
                          ],
                        ),

                        // border: Border(
                        //   left: BorderSide(
                        //     color:
                        //         situacao(pedidoController.pedidos[index].dataEmissao!),
                        //     width: 7.0,
                        //   ),
                        // ),
                      ]),
                    ))));
      },
    );
  }

  _buildSituacaoPedido(value) {
    if (value == 1) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8.0),
          child: TextComponent(
            'Em aberto',
            color: Colors.white,
          ),
        ),
      );
    } else if (value == 2) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.orange, borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8.0),
          child: TextComponent(
            'Pendente',
            color: Colors.white,
          ),
        ),
      );
    } else if (value == 3) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8.0),
          child: TextComponent(
            'Conclu??do',
            color: Colors.white,
          ),
        ),
      );
    } else if (value == 4) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8.0),
          child: TextComponent(
            'Cancelado',
            color: Colors.white,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: controller.carregado
          ? Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TitleComponent('Pedido de entrada'),
                          _buildSituacaoPedido(
                              controller.pedidoEntrada.situacao)
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InputComponent(
                              enable: false,
                              label: 'ID',
                              initialValue: controller
                                  .pedidoEntrada.idPedidoEntrada
                                  .toString(),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: InputComponent(
                              enable: false,
                              label: 'CPF/CNPJ',
                              initialValue: controller
                                      .pedidoEntrada
                                      .asteca!
                                      .compEstProd!
                                      .first
                                      .produto!
                                      .fornecedores!
                                      .first
                                      .cliente!
                                      .cpfCnpj ??
                                  '',
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: InputComponent(
                              enable: false,
                              label: 'Fornecedor',
                              initialValue: controller
                                      .pedidoEntrada
                                      .asteca!
                                      .compEstProd!
                                      .first
                                      .produto!
                                      .fornecedores!
                                      .first
                                      .cliente!
                                      .nome ??
                                  '',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InputComponent(
                                enable: false,
                                label: 'Funcion??rio',
                                initialValue: controller
                                        .pedidoEntrada
                                        .funcionario!
                                        .clienteFunc!
                                        .cliente!
                                        .nome ??
                                    ''),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: InputComponent(
                              enable: false,
                              label: 'Data de emiss??o',
                              initialValue: maskFormatter
                                  .dataFormatter(
                                      value: controller
                                          .pedidoEntrada.dataEmissao
                                          .toString())
                                  .getMaskedText(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InputComponent(
                                enable: false,
                                label: 'Valor total R\$',
                                initialValue: controller.formatter.format(
                                    controller.pedidoEntrada.valorTotal)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [TitleComponent('Asteca')],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: InputComponent(
                                  enable: false,
                                  label: 'ID',
                                  initialValue: controller
                                              .pedidoEntrada.asteca!.idAsteca ==
                                          null
                                      ? ''
                                      : controller
                                          .pedidoEntrada.asteca!.idAsteca
                                          .toString()),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            ButtonComponent(
                              icon: Icon(
                                Icons.wysiwyg_outlined,
                                color: Colors.white,
                              ),
                              color: secundaryColor,
                              onPressed: () {
                                Navigator.pushNamed(context,
                                    "/astecas/${controller.pedidoEntrada.asteca!.idAsteca}");
                              },
                              text: 'Ver mais',
                            )
                          ]),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [TitleComponent('Itens do pedido')],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextComponent(
                              'ID',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                              flex: 4,
                              child: TextComponent(
                                'Descri????o',
                                fontWeight: FontWeight.bold,
                              )),
                          Expanded(
                              child: TextComponent(
                            'Quantidade',
                            fontWeight: FontWeight.bold,
                          )),
                          Expanded(
                              child: TextComponent(
                            'Valor R\$',
                            fontWeight: FontWeight.bold,
                          )),
                          Expanded(
                              child: TextComponent(
                            'Subtotal R\$',
                            fontWeight: FontWeight.bold,
                          )),
                        ],
                      ),
                      Divider(),
                      Container(
                        height: 400,
                        child: ListView.builder(
                          itemCount: controller
                              .pedidoEntrada.itensPedidoEntrada!.length,
                          itemBuilder: (context, index) {
                            return _buildListItem(
                                controller.pedidoEntrada.itensPedidoEntrada!,
                                index,
                                context);
                          },
                        ),
                      ),
                      Row(
                        children: [
                          ButtonComponent(
                              color: primaryColor,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              text: 'Voltar')
                        ],
                      )
                    ]),
              ))
          : LoadingComponent(),
    );
  }
}

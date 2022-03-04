import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/PedidoController.dart';
import 'package:gpp/src/models/ItemPedidoSaidaModel.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/InputComponent.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/utils/MaskFormatter.dart';

class PedidoSaidaDetalheView extends StatefulWidget {
  final int id;

  PedidoSaidaDetalheView({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _PedidoSaidaDetalheViewState createState() => _PedidoSaidaDetalheViewState();
}

class _PedidoSaidaDetalheViewState extends State<PedidoSaidaDetalheView> {
  late PedidoController pedidoController;
  late MaskFormatter maskFormatter;

  buscar() async {
    setState(() {
      pedidoController.carregado = false;
    });
    pedidoController.pedido =
        await pedidoController.pedidoRepository.buscar(widget.id);

    setState(() {
      pedidoController.carregado = true;
    });
  }

  @override
  void initState() {
    super.initState();
    //Inicializa pedido controller
    pedidoController = PedidoController();
    //Inicializa mask formatter
    maskFormatter = MaskFormatter();
    //buscar o pedido
    buscar();
    
  }

  Widget _buildListItem(
      List<ItemPedidoSaidaModel> itensPedido, int index, BuildContext context) {
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
                                        .idItemPedidoSaida
                                        .toString(),
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: TextComponent(
                                  itensPedido[index].peca!.descricao,
                                )),
                            Expanded(
                                child: TextComponent(
                              itensPedido[index].quantidade.toString(),
                            )),
                            Expanded(
                              child: TextComponent(pedidoController.formatter
                                  .format(itensPedido[index].valor)),
                            ),
                            Expanded(
                                child: TextComponent(
                              pedidoController.formatter.format(
                                  (itensPedido[index].valor *
                                      itensPedido[index].quantidade)),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: pedidoController.carregado
          ? Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleComponent('Pedido de saída'),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InputComponent(
                          enable: false,
                          label: 'ID',
                          initialValue:
                              pedidoController.pedido.idPedidoSaida.toString(),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: InputComponent(
                          enable: false,
                          label: 'CPF/CNPJ',
                          initialValue:
                              pedidoController.pedido.cpfCnpj.toString(),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: InputComponent(
                          enable: false,
                          label: 'Filial de venda',
                          initialValue:
                              pedidoController.pedido.filialVenda.toString(),
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
                          label: 'Nº Documento Fiscal',
                          initialValue:
                              pedidoController.pedido.numDocFiscal.toString(),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: InputComponent(
                          enable: false,
                          label: 'Série Documento Fiscal',
                          initialValue: pedidoController.pedido.serieDocFiscal,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: InputComponent(
                          enable: false,
                          label: 'Data de emissão',
                          initialValue: maskFormatter
                              .dataFormatter(
                                  value: pedidoController.pedido.dataEmissao
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
                            initialValue: pedidoController.formatter
                                .format(pedidoController.pedido.valorTotal)),
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
                    children: [
                      Expanded(
                        child: InputComponent(
                            enable: false,
                            label: 'ID',
                            initialValue:
                                pedidoController.pedido.asteca!.idAsteca == null
                                    ? ''
                                    : pedidoController.pedido.asteca!.idAsteca
                                        .toString()),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: InputComponent(
                            enable: false,
                            label: 'Cliente',
                            initialValue: pedidoController.camelCaseAll(
                                pedidoController.pedido.cliente!.nome == null
                                    ? ''
                                    : pedidoController.pedido.cliente!.nome
                                        .toString())),
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
                            label: 'Produto',
                            initialValue: pedidoController.camelCaseFirst(
                                pedidoController.pedido.asteca!.produto?[0]
                                            .resumida ==
                                        null
                                    ? ''
                                    : pedidoController
                                        .pedido.asteca!.produto?[0].resumida
                                        .toString())),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonComponent(
                        icon: Icon(
                          Icons.wysiwyg_outlined,
                          color: Colors.white,
                        ),
                        color: secundaryColor,
                        onPressed: () {
                          Navigator.pushNamed(context,
                              "/astecas/${pedidoController.pedido.asteca!.idAsteca}");
                        },
                        text: 'Ver mais',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [TitleComponent('Itens do pedido')],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 200,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  TextComponent(
                                    'ID',
                                    fontWeight: FontWeight.bold,
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: TextComponent(
                                  'Descrição',
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
                        Expanded(
                          child: ListView.builder(
                            itemCount: pedidoController
                                .pedido.itemsPedidoSaida!.length,
                            itemBuilder: (context, index) {
                              return _buildListItem(
                                  pedidoController.pedido.itemsPedidoSaida!,
                                  index,
                                  context);
                            },
                          ),
                        ),
                      ],
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
                ],
              ),
            )
          : LoadingComponent(),
    );
  }
}

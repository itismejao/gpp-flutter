import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/PedidoEntradaController.dart';
import 'package:gpp/src/models/PedidoEntradaModel.dart';
import 'package:gpp/src/shared/components/DropdownButtonFormFieldComponent.dart';
import 'package:intl/intl.dart';

import 'package:gpp/src/controllers/PedidoController.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/models/PedidoSaidaModel.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/InputComponent.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/utils/MaskFormatter.dart';

class Situacao {
  int? id;
  String? descricao;
  Situacao({
    this.id,
    this.descricao,
  });
}

class PedidoEntradaListView extends StatefulWidget {
  const PedidoEntradaListView({Key? key}) : super(key: key);

  @override
  _PedidoEntradaListViewState createState() => _PedidoEntradaListViewState();
}

class _PedidoEntradaListViewState extends State<PedidoEntradaListView> {
  final ResponsiveController _responsive = ResponsiveController();
  ScrollController scrollController = ScrollController();

  late final PedidoEntradaController controller;
  late MaskFormatter maskFormatter;

  buscarTodas() async {
    NotifyController notify = NotifyController(context: context);
    try {
      setState(() {
        controller.carregado = false;
      });
      //parei aqui

      List retorno = await controller.repository.buscarTodos(
          controller.pagina.atual,
          idPedido: controller.idPedidoEntrada,
          dataInicio: controller.dataInicio,
          dataFim: controller.dataFim,
          situacao: controller.situacao);

      controller.pedidosEntrada = retorno[0];
      controller.pagina = retorno[1];

      //Limpa filtros;
      limparFiltro();
      //Atualiza o status para carregado
      setState(() {
        controller.carregado = true;
      });
    } catch (e) {
      setState(() {
        controller.pedidosEntrada = [];
        controller.carregado = true;
      });
      notify.error(e.toString());
    }
  }

  limparFiltro() {
    controller.idPedidoEntrada = null;
    controller.dataInicio = null;
    controller.dataFim = null;
    controller.situacao = null;
  }

  _buildSituacaoPedido(value) {
    if (value == 1) {
      return TextComponent(
        'Em aberto',
        color: Colors.green,
      );
    }
  }

  @override
  initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    //Iniciliza o controlador de pedido
    controller = PedidoEntradaController();
    //Inicializa mask formatter
    maskFormatter = MaskFormatter();

    //Função responsável por buscar a lista de pedidos
    buscarTodas();
  }

  situacao(DateTime data) {
    int diasEmAtraso = DateTime.now().difference(data).inDays;
    //Se os dias em atraso for menor que 15 dias, situação = verde
    if (diasEmAtraso < 15) {
      return Colors.green;
    }
    //Se os dias em atraso for maior que 15 e menor que 30, situação = amarela
    if (diasEmAtraso > 15 && diasEmAtraso < 30) {
      return Colors.yellow;
    }
    //Se os dias em atraso for maior que 30, situação = vermelha

    return Colors.red;
  }

  tipoAsteca(int? tipoAsteca) {
    switch (tipoAsteca) {
      case 1:
        return 'Cliente';
      case 2:
        return 'Estoque';
      default:
        return 'Aguardando tipo de asteca';
    }
  }

  Widget _buildList() {
    Widget widget = LayoutBuilder(
      builder: (context, constraints) {
        if (_responsive.isMobile(constraints.maxWidth)) {
          return ListView.builder(
              itemCount: controller.pedidosEntrada.length,
              itemBuilder: (context, index) {
                return _buildListItem(
                    controller.pedidosEntrada, index, context);
              });
        }

        return ListView.builder(
            itemCount: controller.pedidosEntrada.length,
            itemBuilder: (context, index) {
              return _buildListItem(controller.pedidosEntrada, index, context);
            });
      },
    );

    return Container(color: Colors.white, child: widget);
  }

  Widget _buildListItem(
      List<PedidoEntradaModel> pedido, int index, BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (_responsive.isMobile(constraints.maxWidth)) {
          // return GestureDetector(
          //   onTap: () {
          //     Navigator.pushNamed(
          //         context, '/asteca/' + pedido[index].idPedidoSaida.toString());
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Column(
          //       children: [
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Expanded(
          //               child: Text(
          //                 pedido[index].idPedidoSaida.toString(),
          //                 style: textStyle(
          //                     color: Colors.black,
          //                     fontWeight: FontWeight.w900,
          //                     fontSize: 18.0),
          //               ),
          //             ),
          //             Align(
          //               alignment: Alignment.centerLeft,
          //               child: Text(
          //                 'ID: ' + pedido[index].idPedidoSaida.toString(),
          //                 style: textStyle(
          //                     color: Colors.black, fontWeight: FontWeight.w700),
          //               ),
          //             ),
          //           ],
          //         ),
          //         Divider(),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Expanded(
          //               child: TextComponent('Nota Fiscal: ' +
          //                   controller
          //                       .astecas[index].documentoFiscal!.numDocFiscal
          //                       .toString()),
          //             ),
          //             Align(
          //               alignment: Alignment.centerLeft,
          //               child: TextComponent('Serie: ' +
          //                   controller.astecas[index].documentoFiscal!
          //                       .serieDocFiscal!),
          //             ),
          //           ],
          //         ),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Expanded(
          //               child: TextComponent(
          //                 'Filial de Venda: ' +
          //                     controller
          //                         .astecas[index].documentoFiscal!.idFilialVenda
          //                         .toString(),
          //               ),
          //             ),
          //             Align(
          //               alignment: Alignment.centerLeft,
          //               child: TextComponent(
          //                 'Data de Abertura: ' +
          //                     DateFormat('dd-MM-yyyy').format(
          //                         controller.astecas[index].dataEmissao!),
          //               ),
          //             ),
          //           ],
          //         ),
          //         Padding(padding: const EdgeInsets.all(8.0)),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Expanded(
          //               child: TextComponent(
          //                 'Defeito: ' +
          //                     asteca[index].defeitoEstadoProd.toString(),
          //               ),
          //             ),
          //           ],
          //         ),
          //         Padding(padding: const EdgeInsets.all(4.0)),
          //       ],
          //     ),
          //   ),
          // );
        }

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context,
                '/pedidos-entrada/' + pedido[index].idPedidoEntrada.toString());
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 9,
                    offset: Offset(0, 5), // changes position of shadow
                  ),
                ],
                border: Border(
                  left: BorderSide(
                    color:
                        situacao(controller.pedidosEntrada[index].dataEmissao!),
                    width: 7.0,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                              'Nome',
                              fontWeight: FontWeight.bold,
                            )),
                        Expanded(
                            flex: 2,
                            child: TextComponent(
                              'Data de abertura',
                              fontWeight: FontWeight.bold,
                            )),
                        Expanded(
                            flex: 2,
                            child: TextComponent(
                              'CPF/CNPJ',
                              fontWeight: FontWeight.bold,
                            )),
                        Expanded(
                            flex: 2,
                            child: TextComponent(
                              'Situação',
                              fontWeight: FontWeight.bold,
                            )),
                        Expanded(
                            flex: 3,
                            child: TextComponent(
                              'Valor total',
                              fontWeight: FontWeight.bold,
                            ))
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              pedido[index].idPedidoEntrada != null
                                  ? TextComponent(
                                      '#' +
                                          pedido[index]
                                              .idPedidoEntrada
                                              .toString(),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: TextComponent(
                              pedido[index]
                                          .asteca!
                                          .produto!
                                          .first
                                          .fornecedor!
                                          .cliente!
                                          .nome! !=
                                      null
                                  ? pedido[index]
                                      .asteca!
                                      .produto!
                                      .first
                                      .fornecedor!
                                      .cliente!
                                      .nome!
                                  : '',
                            )),
                        Expanded(
                            flex: 2,
                            child: pedido[index].dataEmissao != null
                                ? TextComponent(
                                    DateFormat('dd/MM/yyyy')
                                        .format(pedido[index].dataEmissao!),
                                  )
                                : Container()),
                        Expanded(
                            flex: 2,
                            child: TextComponent(
                              maskFormatter.cpfCnpjFormatter(
                                          value: pedido[index]
                                              .asteca!
                                              .produto!
                                              .first
                                              .fornecedor!
                                              .cliente!
                                              .cpfCnpj
                                              .toString()) !=
                                      null
                                  ? maskFormatter
                                      .cpfCnpjFormatter(
                                          value: pedido[index]
                                              .asteca!
                                              .produto!
                                              .first
                                              .fornecedor!
                                              .cliente!
                                              .cpfCnpj
                                              .toString())!
                                      .getMaskedText()
                                  : '',
                            )),
                        Expanded(
                            flex: 2,
                            child: _buildSituacaoPedido(
                                        pedido[index].situacao) !=
                                    null
                                ? _buildSituacaoPedido(pedido[index].situacao)
                                : Container()),
                        Expanded(
                            flex: 3,
                            child: TextComponent(
                                pedido[index].valorTotal != null
                                    ? controller.formatter
                                        .format(pedido[index].valorTotal)
                                    : controller.formatter.format(0)
                                // maskFormatter.realInputFormmater(pedido[index].valorTotal.toString()).getMaskedText(),
                                ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Expanded(child: TitleComponent('Pedidos de entrada')),
                Expanded(
                  child: Form(
                    key: controller.filtroFormKey,
                    child: InputComponent(
                      maxLines: 1,
                      onFieldSubmitted: (value) {
                        controller.idPedidoEntrada = int.tryParse(value);
                        //Limpa o formúlario
                        controller.filtroFormKey.currentState!.reset();
                        buscarTodas();
                      },
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      hintText: 'Digite o número de identificação do pedido',
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                ButtonComponent(
                    icon: Icon(Icons.add, color: Colors.white),
                    color: secundaryColor,
                    onPressed: () {
                      setState(() {
                        controller.abrirFiltro = !(controller.abrirFiltro);
                      });
                    },
                    text: 'Adicionar filtro')
              ],
            ),
          ),
          Container(
            color: Colors.grey.shade50,
            height: controller.abrirFiltro ? null : 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: controller.filtroExpandidoFormKey,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextComponent('Situação'),
                              SizedBox(
                                height: 8,
                              ),
                              DropdownButtonFormFieldComponent(
                                onChanged: (value) {
                                  controller.situacao = value.id;
                                },
                                hintText: 'Em aberto',
                                items: <Situacao>[
                                  Situacao(id: 1, descricao: 'Em aberto'),
                                  Situacao(id: 2, descricao: 'Pendente'),
                                  Situacao(id: 3, descricao: 'Em separação'),
                                  Situacao(id: 4, descricao: 'Fechado')
                                ].map<DropdownMenuItem<Situacao>>(
                                    (Situacao value) {
                                  return DropdownMenuItem<Situacao>(
                                    value: value,
                                    child: TextComponent(value.descricao!),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: InputComponent(
                            inputFormatter: [maskFormatter.dataFormatter()],
                            label: 'Período:',
                            maxLines: 1,
                            onSaved: (value) {
                              if (value.length == 10) {
                                controller.dataInicio =
                                    DateFormat("dd/MM/yyyy").parse(value);
                              }
                            },
                            hintText: '24/02/2022',
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: InputComponent(
                            inputFormatter: [maskFormatter.dataFormatter()],
                            label: '',
                            maxLines: 1,
                            onSaved: (value) {
                              if (value.length == 10) {
                                controller.dataFim =
                                    DateFormat("dd/MM/yyyy").parse(value);
                              }
                            },
                            hintText: '25/02/2022',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ButtonComponent(
                            onPressed: () {
                              controller.filtroExpandidoFormKey.currentState!
                                  .save();
                              controller.filtroExpandidoFormKey.currentState!
                                  .reset();
                              buscarTodas();

                              setState(() {
                                controller.abrirFiltro = false;
                              });
                            },
                            text: 'Pesquisar')
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: media.height * 0.7,
            child: controller.carregado ? _buildList() : LoadingComponent(),
          ),
          Container(
            height: media.height * 0.10,
            width: media.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextComponent(
                    'Total de páginas: ' + controller.pagina.total.toString()),
                Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.first_page),
                        onPressed: () {
                          controller.pagina.atual = 1;
                          buscarTodas();
                        }),
                    IconButton(
                        icon: const Icon(
                          Icons.navigate_before_rounded,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          if (controller.pagina.atual > 0) {
                            controller.pagina.atual =
                                controller.pagina.atual - 1;
                            buscarTodas();
                          }
                        }),
                    TextComponent(controller.pagina.atual.toString()),
                    IconButton(
                        icon: Icon(Icons.navigate_next_rounded),
                        onPressed: () {
                          if (controller.pagina.atual !=
                              controller.pagina.total) {
                            controller.pagina.atual =
                                controller.pagina.atual + 1;
                          }

                          buscarTodas();
                        }),
                    IconButton(
                        icon: Icon(Icons.last_page),
                        onPressed: () {
                          controller.pagina.atual = controller.pagina.total;
                          buscarTodas();
                        }),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

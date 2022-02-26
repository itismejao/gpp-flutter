import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/models/ItemPedidoSaidaModel.dart';
import 'package:gpp/src/models/PedidoSaidaModel.dart';
import 'package:gpp/src/models/ProdutoPecaModel.dart';
import 'package:gpp/src/shared/utils/GerarPedidoPDF.dart';
import 'package:intl/intl.dart';

import 'package:gpp/src/controllers/MotivoTrocaPecaController.dart';
import 'package:gpp/src/controllers/AstecaController.dart';

import 'package:gpp/src/models/AstecaModel.dart';
import 'package:gpp/src/models/asteca_tipo_pendencia_model.dart';
import 'package:gpp/src/models/reason_parts_replacement_model.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/CheckboxComponent.dart';
import 'package:gpp/src/shared/components/drop_down_component.dart';
import 'package:gpp/src/shared/components/InputComponent.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/utils/MaskFormatter.dart';
import 'package:gpp/src/views/asteca/components/item_menu.dart';

class ItemPeca {
  bool marcado = false;
  late ProdutoPecaModel produtoPeca;
  ItemPeca({
    required this.marcado,
    required this.produtoPeca,
  });
}

class AstecaDetalheView extends StatefulWidget {
  final int id;
  const AstecaDetalheView({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _AstecaDetalheViewState createState() => _AstecaDetalheViewState();
}

class _AstecaDetalheViewState extends State<AstecaDetalheView> {
  late AstecaController astecaController;

  List<ItemPeca> itemsPeca = [];
  List<ItemPeca> itemsPecaBusca = [];
  int marcados = 0;
  bool abrirFiltro = false;
  late MotivoTrocaPecaController motivoTrocaPecaController;

  late ResponsiveController _responsive;
  late MaskFormatter maskFormatter;

  buscar() async {
    setState(() {
      astecaController.carregado = false;
    });
    astecaController.asteca = await astecaController.repository.buscar(widget.id);

    setState(() {
      astecaController.carregado = true;
    });
  }

  buscarPendencias() async {
    setState(() {
      astecaController.carregado = false;
    });

    astecaController.astecaTipoPendencias = await astecaController.repository.pendencia.buscarPendencias();

    setState(() {
      astecaController.carregado = true;
    });
  }

  buscarMotivosTrocaPeca() async {
    setState(() {
      astecaController.carregado = false;
    });

    motivoTrocaPecaController.motivoTrocaPecas = await motivoTrocaPecaController.repository.buscarTodos();

    setState(() {
      astecaController.carregado = true;
    });
  }

  handlePendencia(AstecaModel asteca, AstecaTipoPendenciaModel pendencia) async {
    await astecaController.repository.pendencia.criar(asteca, pendencia);
    //Atualiza asteca
    await buscar();
  }

  gerarItemPeca() {
    itemsPeca =
        astecaController.produtoPecas.map<ItemPeca>((produtoPeca) => ItemPeca(marcado: false, produtoPeca: produtoPeca)).toList();
  }

  /**
   * Função utilizada para marcar todas as checkbox das pecas
   */
  marcarTodosCheckbox(bool value) {
    if (value) {
      marcados = itemsPeca.length;
    } else {
      marcados = 0;
    }
    for (var itemPeca in itemsPeca) {
      itemPeca.marcado = value;
    }
  }

  //Nova lógica
  marcarCheckbox(index, value) {
    if (value) {
      marcados++;
    } else {
      marcados--;
    }
    itemsPeca[index].marcado = value;
  }

  /**
   * Adicionar pecas ao carrinho
   */

  adicionarPeca() {
    setState(() {
      for (var itemPeca in itemsPeca) {
        //Verifica se o item está marcado
        if (itemPeca.marcado) {
          //Verifica se já existe item com o mesmo id adicionado na lista
          int index = astecaController.pedidoSaida.itemsPedidoSaida!
              .indexWhere((element) => element.peca!.idPeca == itemPeca.produtoPeca.peca.idPeca);
          //Se não existe item adiciona na lista
          if (index < 0) {
            astecaController.pedidoSaida.itemsPedidoSaida!.add(
                ItemPedidoSaidaModel(peca: itemPeca.produtoPeca.peca, valor: itemPeca.produtoPeca.peca.custo, quantidade: 1));
          } else {
            //Caso exista item na lista incrementa a quantidade;
            astecaController.pedidoSaida.itemsPedidoSaida![index].quantidade++;
            astecaController.pedidoSaida.itemsPedidoSaida![index].valor += itemPeca.produtoPeca.peca.custo;
            //  astecaController.pedidoSaida.itemsPedidoSaida![index].valor += 0;
          }
          //Soma o total
          calcularValorTotal();
        }
        itemPeca.marcado = false;
      }
      marcados = 0;
    });

    print(astecaController.pedidoSaida.itemsPedidoSaida!.length);
  }

/**
   * Remover peça
   */
  removerPeca(index) {
    setState(() {
      astecaController.pedidoSaida.itemsPedidoSaida!.removeAt(index);
    });
    calcularValorTotal();
  }

  calcularValorTotal() {
    setState(() {
      astecaController.pedidoSaida.valorTotal = 0.0;
      for (var item in astecaController.pedidoSaida.itemsPedidoSaida!) {
        astecaController.pedidoSaida.valorTotal = astecaController.pedidoSaida.valorTotal! + item.quantidade * item.valor;
      }
    });
  }

  selecionarMotivoTrocaPeca(index, value) {
    setState(() {
      astecaController.pedidoSaida.itemsPedidoSaida![index].motivoTrocaPeca = value;
    });
  }

  void adicionarQuantidade(index) {
    setState(() {
      astecaController.pedidoSaida.itemsPedidoSaida![index].quantidade++;
    });
    calcularValorTotal();
  }

  void removerQuantidade(index) {
    if (astecaController.pedidoSaida.itemsPedidoSaida![index].quantidade > 1) {
      setState(() {
        astecaController.pedidoSaida.itemsPedidoSaida![index].quantidade--;
      });
      calcularValorTotal();
    } else {
      removerPeca(index);
    }
  }

  bool verificaEstoque() {
    bool verificaEstoque = true;
    for (var item in astecaController.pedidoSaida.itemsPedidoSaida!) {
      if (item.peca!.estoque.isEmpty) {
        verificaEstoque = false;
        break;
      } else {
        if (item.quantidade > item.peca!.estoque.first.saldoDisponivel) {
          verificaEstoque = false;
          break;
        }
      }
    }
    return verificaEstoque;
  }

  verificarSelecaoMotivoTrocaPeca() {
    bool verificaSelecaoMotivoTrocaPeca = true;
    for (var item in astecaController.pedidoSaida.itemsPedidoSaida!) {
      if (item.motivoTrocaPeca == null) {
        verificaSelecaoMotivoTrocaPeca = false;
        break;
      }
    }
    return verificaSelecaoMotivoTrocaPeca;
  }

  myShowDialog(String text) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(actions: <Widget>[
            Padding(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.warning_amber, color: Colors.amber, size: 45.0),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        TextComponent(
                          text,
                          fontSize: 20.0,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ButtonComponent(
                            color: primaryColor,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            text: 'Ok'),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    )
                  ],
                ),
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0))
          ]);
        });
  }

  /**
   * Função destinada a finalizar o pedido
   */

  finalizarPedido() async {
    try {
      if (!verificarSelecaoMotivoTrocaPeca()) {
        myShowDialog('Selecione o motivo de troca da peça');
      }

      if (verificaEstoque()) {
        print('as');

        //Criar o pedido
        astecaController.pedidoSaida.cpfCnpj = astecaController.asteca.documentoFiscal!.cpfCnpj.toString();
        astecaController.pedidoSaida.filialVenda = astecaController.asteca.documentoFiscal!.idFilialVenda;
        astecaController.pedidoSaida.numDocFiscal = astecaController.asteca.documentoFiscal!.numDocFiscal;
        astecaController.pedidoSaida.serieDocFiscal = astecaController.asteca.documentoFiscal!.serieDocFiscal;

        astecaController.pedidoSaida.situacao = 1;
        astecaController.pedidoSaida.asteca = astecaController.asteca;
        astecaController.pedidoSaida.funcionario = astecaController.asteca.funcionario;
        astecaController.pedidoSaida.cliente = astecaController.asteca.documentoFiscal!.cliente;
        //Solicita o endpoint a criação do pedido
        PedidoSaidaModel pedidoResposta = await astecaController.pedidoRepository.criar(astecaController.pedidoSaida);

        //Notificação
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(actions: <Widget>[
                Row(
                  children: [
                    Padding(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: TextComponent(
                                'Nº Pedido: #${pedidoResposta.idPedidoSaida}',
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: TextComponent('Nome do cliente: ${pedidoResposta.cliente!.nome}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: TextComponent('Filial venda: ${pedidoResposta.filialVenda}'),
                            )
                          ],
                        ),
                        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0))
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    ButtonComponent(
                        color: primaryColor,
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, '/pedidos');
                        },
                        text: 'Ok'),
                    SizedBox(
                      width: 8,
                    ),
                    ButtonComponent(
                        icon: Icon(
                          Icons.print,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          GerarPedidoPDF(pedido: pedidoResposta).imprimirPDF();
                        },
                        text: 'Imprimir')
                  ],
                )
              ]);
            });
      } else {
        myShowDialog('Não é possível finalizar o pedido, existe peças adicionadas sem estoque');
      }
    } catch (e) {
      print(e);
    }
  }

  pesquisarPecas(value) {
    itemsPecaBusca = itemsPeca
        .where((element) =>
            element.produtoPeca.peca.descricao.toLowerCase().contains(value.toString().toLowerCase()) ||
            element.produtoPeca.peca.idPeca.toString().contains(value))
        .toList();
  }

  pesquisarPendencia(value) {
    setState(() {
      astecaController.astecaTipoPendenciasBuscar = astecaController.astecaTipoPendencias
          .where((element) =>
              element.descricao!.toLowerCase().contains(value.toString().toLowerCase()) ||
              element.idTipoPendencia.toString().contains(value))
          .toList();
    });
  }

  buscarProdutoPecas() async {
    setState(() {
      astecaController.carregaProdutoPeca = false;
    });
    astecaController.produtoPecas =
        await astecaController.pecaRepository.buscarTodos(astecaController.asteca.produto!.first.idProduto!);
    setState(() {
      astecaController.carregaProdutoPeca = true;
    });

    //gerarItemPeca
    gerarItemPeca();
  }

  @override
  void initState() {
    super.initState();

    astecaController = AstecaController();
    _responsive = ResponsiveController();

    //Instância máscaras
    maskFormatter = MaskFormatter();

    //Instância motivo de troca de peca controller
    motivoTrocaPecaController = MotivoTrocaPecaController();

    //Busca a asteca, utilizando o id como parâmetro
    buscar();

    //Busca lista de pendências
    buscarPendencias();

    //Buscar motivos de troca de peças
    buscarMotivosTrocaPeca();
  }

  inserirQuantidade(index, value) {
    int quantidade = int.parse(value);

    if (quantidade == 0) {
      removerPeca(index);
    } else if (quantidade > 0) {
      setState(() {
        astecaController.pedidoSaida.itemsPedidoSaida![index].quantidade = quantidade;
      });
      calcularValorTotal();
    }
  }

  _buildSituacaoEstoque(index) {
    if (astecaController.pedidoSaida.itemsPedidoSaida![index].peca!.estoque.isEmpty) {
      return Colors.red.shade100;
    } else {
      if (astecaController.pedidoSaida.itemsPedidoSaida![index].peca!.estoque.first.saldoDisponivel <
          astecaController.pedidoSaida.itemsPedidoSaida![index].quantidade) {
        return Colors.red.shade100;
      } else {
        if (index % 2 == 0) {
          return Colors.white;
        } else {}
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    if (_responsive.isMobile(media.size.width)) {
      return Scaffold(
        body: Container(
            child: Column(
          children: [
            Container(
              height: media.size.height * 0.10,
              child: _buildAstecaMenu(media),
            ),
            Container(
              height: media.size.height * 0.90,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildAstecaNavigator(media),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          astecaController.step > 1
                              ? ButtonComponent(
                                  color: primaryColor,
                                  onPressed: () {
                                    setState(() {
                                      astecaController.step--;
                                    });
                                  },
                                  text: 'Voltar')
                              : Container(),
                          Row(
                            children: [
                              astecaController.step != 4
                                  ? ButtonComponent(
                                      color: primaryColor,
                                      onPressed: () {
                                        setState(() {
                                          astecaController.step++;
                                        });
                                      },
                                      text: 'Avançar')
                                  : Container(),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )),
      );
    } else {
      return astecaController.carregado
          ? Column(
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: const TitleComponent(
                                  'Asteca',
                                ),
                              ),
                              // Expanded(
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //         color: Colors.pink,
                              //         borderRadius: BorderRadius.circular(5)),
                              //     child: DropdownButtonFormField<String>(
                              //       icon: Visibility(
                              //           visible: false,
                              //           child: Icon(Icons.arrow_downward)),
                              //       hint: Row(
                              //         children: [
                              //           TextComponent(
                              //             'A FAZER',
                              //             color: Colors.white,
                              //           ),
                              //         ],
                              //       ),
                              //       decoration: InputDecoration(
                              //           contentPadding: EdgeInsets.only(
                              //               left: 16, top: 6, bottom: 6),
                              //           border: InputBorder.none),
                              //       items: <String>['A', 'B', 'C', 'D']
                              //           .map((String value) {
                              //         return DropdownMenuItem<String>(
                              //           value: value,
                              //           child: Row(
                              //             children: [
                              //               Container(
                              //                 width: 16,
                              //                 height: 16,
                              //                 decoration: BoxDecoration(
                              //                     color: Colors.pink,
                              //                     borderRadius:
                              //                         BorderRadius.circular(2)),
                              //               ),
                              //               SizedBox(
                              //                 width: 8,
                              //               ),
                              //               TextComponent(value),
                              //             ],
                              //           ),
                              //         );
                              //       }).toList(),
                              //       onChanged: (_) {},
                              //     ),
                              //   ),
                              // ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      astecaController.abrirDropDownButton = !astecaController.abrirDropDownButton;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(color: secundaryColor, borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                        padding: const EdgeInsets.only(left: 12, top: 12, bottom: 12),
                                        child: astecaController.asteca.astecaTipoPendencias!.isNotEmpty
                                            ? TextComponent(
                                                astecaController.asteca.astecaTipoPendencias!.last.idTipoPendencia.toString() +
                                                    ' - ' +
                                                    astecaController.asteca.astecaTipoPendencias!.last.descricao!,
                                                color: Colors.white)
                                            : const TextComponent('Aguardando Pendência', color: Colors.white)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildAstecaMenu(media)),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    _buildAstecaNavigator(media),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [],
                                        )),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: const Divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              ButtonComponent(
                                  color: primaryColor,
                                  onPressed: () {
                                    finalizarPedido();
                                  },
                                  text: 'Finalizar pedido'),
                              const SizedBox(
                                width: 8,
                              ),
                              ButtonComponent(
                                  color: Colors.red,
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/astecas');
                                  },
                                  text: 'Fechar')
                            ],
                          ),
                        )
                      ],
                    ),
                    astecaController.abrirDropDownButton
                        ? Positioned(
                            top: 60,
                            right: 14,
                            child: AnimatedOpacity(
                              opacity: 1,
                              duration: const Duration(seconds: 1),
                              child: Container(
                                height: 240,
                                width: 700,
                                decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: InputComponent(
                                            onChanged: (value) {
                                              pesquisarPendencia(value);
                                            },
                                            hintText: 'Buscar',
                                          ),
                                        )
                                      ],
                                    ),
                                    Expanded(
                                      child: astecaController.astecaTipoPendenciasBuscar.isEmpty
                                          ? ListView.builder(
                                              itemCount: astecaController.astecaTipoPendencias.length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      handlePendencia(
                                                          astecaController.asteca, astecaController.astecaTipoPendencias[index]);

                                                      astecaController.abrirDropDownButton = false;
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 16,
                                                          height: 16,
                                                          decoration: BoxDecoration(
                                                              color: secundaryColor, borderRadius: BorderRadius.circular(2)),
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        TextComponent(
                                                          astecaController.astecaTipoPendencias[index].idTipoPendencia
                                                                  .toString() +
                                                              ' - ' +
                                                              astecaController.astecaTipoPendencias[index].descricao.toString(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                          : ListView.builder(
                                              itemCount: astecaController.astecaTipoPendenciasBuscar.length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      handlePendencia(astecaController.asteca,
                                                          astecaController.astecaTipoPendenciasBuscar[index]);

                                                      astecaController.abrirDropDownButton = false;
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 16,
                                                          height: 16,
                                                          decoration: BoxDecoration(
                                                              color: secundaryColor, borderRadius: BorderRadius.circular(2)),
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        TextComponent(
                                                          astecaController.astecaTipoPendenciasBuscar[index].idTipoPendencia
                                                                  .toString() +
                                                              ' - ' +
                                                              astecaController.astecaTipoPendenciasBuscar[index].descricao
                                                                  .toString(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        : Container()
                  ],
                ),
              ],
            )
          : LoadingComponent();
    }
  }

  _buildAstecaMenu(MediaQueryData media) {
    if (_responsive.isMobile(media.size.width)) {
      return Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  astecaController.step = 1;
                });
              },
              child: Container(
                color: astecaController.step == 1 ? Colors.white : primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextComponent('Informações',
                          color: astecaController.step == 1 ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.20),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  astecaController.step = 2;
                });
              },
              child: Container(
                color: astecaController.step == 2 ? Colors.white : primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextComponent('Endereço',
                          color: astecaController.step == 2 ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.20),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  astecaController.step = 3;
                });
              },
              child: Container(
                color: astecaController.step == 3 ? Colors.white : primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextComponent('Produto',
                          color: astecaController.step == 3 ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.20),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  astecaController.step = 4;
                });
              },
              child: Container(
                color: astecaController.step == 4 ? Colors.white : primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextComponent('Peças',
                          color: astecaController.step == 4 ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    astecaController.step = 1;
                    astecaController.abrirDropDownButton = false;
                  });
                },
                child: ItemMenu(
                  data: 'Informações',
                  color: astecaController.step == 1 ? Colors.grey.shade50 : Colors.transparent,
                  borderColor: astecaController.step == 1 ? secundaryColor : Colors.transparent,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    astecaController.step = 2;
                    astecaController.abrirDropDownButton = false;
                  });
                },
                child: ItemMenu(
                  data: 'Endereço',
                  color: astecaController.step == 2 ? Colors.grey.shade50 : Colors.transparent,
                  borderColor: astecaController.step == 2 ? secundaryColor : Colors.transparent,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    astecaController.step = 3;
                    astecaController.abrirDropDownButton = false;
                  });
                },
                child: ItemMenu(
                  data: 'Produto',
                  color: astecaController.step == 3 ? Colors.grey.shade50 : Colors.transparent,
                  borderColor: astecaController.step == 3 ? secundaryColor : Colors.transparent,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    astecaController.step = 4;
                    astecaController.abrirDropDownButton = false;
                  });
                },
                child: ItemMenu(
                  data: 'Peças',
                  color: astecaController.step == 4 ? Colors.grey.shade50 : Colors.transparent,
                  borderColor: astecaController.step == 4 ? secundaryColor : Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _buildAstecaNavigator(MediaQueryData media) {
    switch (astecaController.step) {
      case 1:
        return _buildAstecaInformation(media);

      case 2:
        return _buildAstecaAndress(media);

      case 3:
        return _buildAstecaProduct(media);
      case 4:
        return _buildAstecaParts(media);
    }
  }

  _buildAstecaInformation(MediaQueryData media) {
    if (_responsive.isMobile(media.size.width)) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.description,
                    size: 32,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  TitleComponent('Informações'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Nº Asteca',
                initialValue: astecaController.asteca.idAsteca,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'CPF/CNPJ',
                initialValue: '001.463.861-40',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Nº Fiscal',
                initialValue: astecaController.asteca.idAsteca.toString(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Filial de saída',
                initialValue: '10',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Tipo',
                initialValue: 'Cliente',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Nome',
                initialValue: 'Maria Angela Rocha da Fonseca',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Série',
                initialValue: '10',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Filial venda',
                initialValue: '10',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Data de abertura',
                initialValue: '30/06/2021',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Data de compra',
                initialValue: '30/06/2021',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Filial Asteca',
                initialValue: '500',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.badge,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  TitleComponent('Funcionário (a)'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Divider(),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'RE',
                initialValue: '1032445',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Nome',
                initialValue: 'Kesley Alves de Oliveira',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.build,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  TitleComponent('Defeito'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Divider(),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Defeito',
                initialValue: 'Defeito de fabricação',
              ),
            ),
            Container(
              child: InputComponent(
                label: 'Observação',
                initialValue: 'Solicitado pelo técnico, enviar 30 unidades de adesivos/ tapa furos.',
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Icon(
                Icons.description,
                size: 32,
              ),
              SizedBox(
                width: 12,
              ),
              TitleComponent('Informações'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Nº Asteca',
                  initialValue: astecaController.asteca.idAsteca.toString(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 2,
                child: InputComponent(
                  key: UniqueKey(),
                  initialValue: astecaController.asteca.documentoFiscal!.cpfCnpj == null
                      ? ''
                      : maskFormatter
                          .cpfCnpjFormatter(value: astecaController.asteca.documentoFiscal!.cpfCnpj.toString())!
                          .getMaskedText(),
                  label: 'CPF/CNPJ',
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 2,
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Nome',
                  initialValue:
                      astecaController.asteca.documentoFiscal!.nome == null ? '' : astecaController.asteca.documentoFiscal!.nome,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Nº Fiscal',
                  initialValue: astecaController.asteca.documentoFiscal!.numDocFiscal == null
                      ? ''
                      : astecaController.asteca.documentoFiscal!.numDocFiscal.toString(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Série',
                  initialValue: astecaController.asteca.documentoFiscal!.serieDocFiscal == null
                      ? ''
                      : astecaController.asteca.documentoFiscal!.serieDocFiscal,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Filial de saída',
                  initialValue: astecaController.asteca.documentoFiscal!.idFilialSaida == null
                      ? ''
                      : astecaController.asteca.documentoFiscal!.idFilialSaida.toString(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Filial venda',
                  initialValue: astecaController.asteca.documentoFiscal!.idFilialVenda == null
                      ? ''
                      : astecaController.asteca.documentoFiscal!.idFilialVenda.toString(),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Tipo',
                  initialValue: 'Cliente',
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Data de abertura',
                  initialValue: astecaController.asteca.dataEmissao == null
                      ? ''
                      : DateFormat('yyyy/MM/dd').format(astecaController.asteca.dataEmissao!),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Data de compra',
                  initialValue: astecaController.asteca.documentoFiscal!.dataEmissao == null
                      ? ''
                      : DateFormat('yyyy/MM/dd').format(astecaController.asteca.documentoFiscal!.dataEmissao!),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Filial Asteca',
                  initialValue:
                      astecaController.asteca.idFilialRegistro == null ? '' : astecaController.asteca.idFilialRegistro.toString(),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Icon(
                Icons.badge,
              ),
              SizedBox(
                width: 12,
              ),
              TitleComponent('Funcionário (a)'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'RE',
                  initialValue: astecaController.asteca.funcionario!.idFuncionario == null
                      ? ''
                      : astecaController.asteca.funcionario!.idFuncionario.toString(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 2,
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Nome',
                  initialValue:
                      astecaController.asteca.funcionario!.nome == null ? '' : astecaController.asteca.funcionario!.nome,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Icon(
                Icons.build,
              ),
              SizedBox(
                width: 12,
              ),
              TitleComponent('Defeito ou motivo'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Defeito',
                  initialValue:
                      astecaController.asteca.defeitoEstadoProd == null ? '' : astecaController.asteca.defeitoEstadoProd!,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  maxLines: 5,
                  label: 'Observação',
                  initialValue: astecaController.asteca.observacao == null ? '' : astecaController.asteca.observacao,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildAstecaAndress(MediaQueryData media) {
    if (_responsive.isMobile(media.size.width)) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 32,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Endereço',
                      style: TextStyle(letterSpacing: 0.15, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'Logradouro',
                  initialValue: 'Avenida Perimental Norte NR 1 AP 1903  Torre Itaparica',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'Complemento',
                  initialValue: 'AP 1903 Torre Itaparica',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'Bairro',
                  initialValue: 'Setor Candida de Morais',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'Referência',
                  initialValue: 'Cond. Borges Landeiro',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'Número',
                  initialValue: '01',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'Cidade',
                  initialValue: ' Goiânia',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'Estado',
                  initialValue: 'GO',
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.call,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Telefone para contato',
                      style: TextStyle(letterSpacing: 0.15, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Divider(),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'Telefone',
                  initialValue: '(62) 99999-9999',
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                size: 32,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                'Endereço',
                style: TextStyle(letterSpacing: 0.15, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Logradouro',
                  initialValue: astecaController.asteca.astecaEndCliente?.logradouro == null
                      ? ''
                      : astecaController.asteca.astecaEndCliente?.logradouro.toString(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 3,
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Complemento',
                  initialValue: astecaController.asteca.astecaEndCliente?.complemento == null
                      ? ''
                      : astecaController.asteca.astecaEndCliente?.complemento.toString(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Número',
                  initialValue: astecaController.asteca.astecaEndCliente?.numero == null
                      ? ''
                      : astecaController.asteca.astecaEndCliente?.numero.toString(),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Bairro',
                  initialValue: astecaController.asteca.astecaEndCliente?.bairro == null
                      ? ''
                      : astecaController.asteca.astecaEndCliente?.bairro.toString(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Cidade',
                  initialValue: astecaController.asteca.astecaEndCliente?.cep == null
                      ? ''
                      : maskFormatter.cepInputFormmater(astecaController.asteca.astecaEndCliente?.cep.toString()).getMaskedText(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Cidade',
                  initialValue: astecaController.asteca.astecaEndCliente?.localidade == null
                      ? ''
                      : astecaController.asteca.astecaEndCliente?.localidade.toString(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Estado',
                  initialValue: astecaController.asteca.astecaEndCliente?.uf == null
                      ? ''
                      : astecaController.asteca.astecaEndCliente?.uf.toString(),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Referência',
                  initialValue: astecaController.asteca.astecaEndCliente!.pontoReferencia1 ?? '',
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Icon(
                Icons.call,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                'Telefone para contato',
                style: TextStyle(letterSpacing: 0.15, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Telefone',
                  initialValue: astecaController.asteca.astecaEndCliente?.ddd == null ||
                          astecaController.asteca.astecaEndCliente?.telefone == null
                      ? ''
                      : maskFormatter
                          .telefoneInputFormmater(
                              '${astecaController.asteca.astecaEndCliente?.ddd.toString()} ${astecaController.asteca.astecaEndCliente?.telefone.toString()}')
                          .getMaskedText(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildAstecaProduct(MediaQueryData media) {
    if (_responsive.isMobile(media.size.width)) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.shopping_bag,
                      size: 32,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Produto',
                      style: TextStyle(letterSpacing: 0.15, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Divider(),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'ID',
                  initialValue: '121245',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'Nome',
                  initialValue: 'Coz Jazz 3 Pçs IPLDA IP2 IPH1G BEGE',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'LD',
                  initialValue: '02',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Fornecedor',
                  style: TextStyle(letterSpacing: 0.15, fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Divider(),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'ID',
                  initialValue: '4545',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'Nome',
                  initialValue: 'Itatiaia',
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Icon(
                Icons.shopping_bag,
                size: 32,
              ),
              SizedBox(
                width: 12,
              ),
              TitleComponent('Produto'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'ID',
                  initialValue: astecaController.asteca.produto?[0].idProduto == null
                      ? ''
                      : astecaController.asteca.produto?[0].idProduto.toString(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 2,
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Nome',
                  initialValue:
                      astecaController.asteca.produto?[0].resumida == null ? '' : astecaController.asteca.produto?[0].resumida,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'LD',
                  initialValue: astecaController.asteca.documentoFiscal?.itemDocFiscal?.idLd == null
                      ? ''
                      : astecaController.asteca.documentoFiscal?.itemDocFiscal?.idLd.toString(),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              const Icon(
                Icons.local_shipping,
              ),
              const SizedBox(
                width: 12,
              ),
              const TitleComponent('Fornecedor'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'ID',
                  initialValue: astecaController.asteca.produto?[0].fornecedor?.idFornecedor == null
                      ? ''
                      : astecaController.asteca.produto?[0].fornecedor?.idFornecedor.toString(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 2,
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Nome',
                  initialValue: astecaController.asteca.produto?[0].fornecedor?.cliente?.nome == null
                      ? ''
                      : astecaController.asteca.produto?[0].fornecedor?.cliente?.nome,
                ),
              ),
              SizedBox(
                width: 12,
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildAstecaParts(media) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.settings,
                    size: 32,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  TitleComponent('Peças'),
                ],
              ),
              ButtonComponent(
                  color: primaryColor,
                  onPressed: () {
                    exibirPecas(context);
                  },
                  text: 'Adicionar peças')
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 16.0),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: InputComponent(
        //           prefixIcon: Icon(
        //             Icons.search,
        //           ),
        //           hintText: 'Buscar',
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: const TextComponent('ID'),
              ),
              Expanded(
                child: const TextComponent('Nome'),
              ),
              Expanded(
                flex: 2,
                child: const TextComponent('Quantidade'),
              ),
              Expanded(
                child: const TextComponent('Valor R\$'),
              ),
              Expanded(
                child: const TextComponent('Subtotal R\$'),
              ),
              Expanded(
                flex: 3,
                child: const TextComponent('Motivo'),
              ),
              Expanded(
                child: const TextComponent('Ações'),
              ),
            ],
          ),
        ),
        const Divider(),
        Container(
          height: media.size.height * 0.40,
          child: ListView.builder(
              itemCount: astecaController.pedidoSaida.itemsPedidoSaida!.length,
              itemBuilder: (context, index) {
                return Container(
                  color: _buildSituacaoEstoque(index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextComponent(astecaController.pedidoSaida.itemsPedidoSaida![index].peca!.idPeca.toString()),
                        ),
                        Expanded(
                          child: TextComponent(astecaController.pedidoSaida.itemsPedidoSaida![index].peca!.descricao),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              IconButton(
                                color: Colors.red,
                                onPressed: () {
                                  removerQuantidade(index);
                                },
                                icon: Icon(
                                  Icons.remove_circle_outlined,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: InputComponent(
                                  key: UniqueKey(),
                                  maxLines: 1,
                                  initialValue: astecaController.pedidoSaida.itemsPedidoSaida![index].quantidade.toString(),
                                  onFieldSubmitted: (value) {
                                    inserirQuantidade(index, value);
                                  },
                                ),
                              ),
                              IconButton(
                                color: Colors.green,
                                onPressed: () {
                                  adicionarQuantidade(index);
                                },
                                icon: Icon(
                                  Icons.add_circle_outlined,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TextComponent(
                              astecaController.formatter.format(astecaController.pedidoSaida.itemsPedidoSaida![index].valor)),
                        ),
                        Expanded(
                          child: TextComponent('R\$: ' +
                              astecaController.formatter.format(
                                  (astecaController.pedidoSaida.itemsPedidoSaida![index].quantidade *
                                      astecaController.pedidoSaida.itemsPedidoSaida![index].valor))),
                        ),
                        Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)),
                                child: DropDownComponent(
                                  onChanged: (value) {
                                    selecionarMotivoTrocaPeca(index, value);
                                  },
                                  items: motivoTrocaPecaController.motivoTrocaPecas.map((value) {
                                    return DropdownMenuItem<MotivoTrocaPecaModel>(
                                      value: value,
                                      child: Text(value.nome.toString()),
                                    );
                                  }).toList(),
                                  hintText: 'Selecione o motivo',
                                ),
                              ),
                            )),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.grey.shade400,
                                  ),
                                  onPressed: () {
                                    removerPeca(index);
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
        const Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: const Divider(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: ${astecaController.pedidoSaida.itemsPedidoSaida!.length} peças selecionadas',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Text(
              'Valor total R\$: ' + astecaController.formatter.format(astecaController.pedidoSaida.valorTotal),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    );
  }

  exibirPecas(context) async {
    //Carrega peças
    await buscarProdutoPecas();

    MediaQueryData media = MediaQuery.of(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Row(
                children: [
                  const Icon(
                    Icons.settings,
                    size: 32,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const TitleComponent('Peças'),
                ],
              ),
              content: Container(
                width: media.size.width * 0.80,
                height: media.size.height * 0.80,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          const TextComponent(
                            'Selecione uma ou mais peças para realizar a manutenção do produto',
                            letterSpacing: 0.15,
                            fontSize: 16,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: InputComponent(
                              onChanged: (value) {
                                setState(() {
                                  pesquisarPecas(value);
                                });
                              },
                              maxLines: 1,
                              prefixIcon: const Icon(
                                Icons.search,
                              ),
                              hintText: 'Digite o número de identificação da peça ou o nome',
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          ButtonComponent(
                              icon: Icon(Icons.add, color: Colors.white),
                              color: secundaryColor,
                              onPressed: () {
                                setState(() {
                                  abrirFiltro = !abrirFiltro;
                                });
                              },
                              text: 'Adicionar filtro')
                        ],
                      ),
                    ),
                    Container(
                      height: abrirFiltro ? null : 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          children: [
                            Container(
                              width: 220,
                              child: DropDownComponent(
                                icon: const Icon(
                                  Icons.swap_vert,
                                ),
                                items: <String>['Ordem crescente', 'Ordem decrescente'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                hintText: 'Nome',
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: 220,
                              child: DropDownComponent(
                                icon: const Icon(
                                  Icons.swap_vert,
                                ),
                                items: <String>['Ordem crescente', 'Ordem decrescente'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                hintText: 'Estoque disponível',
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: 220,
                              child: DropDownComponent(
                                icon: const Icon(
                                  Icons.swap_vert,
                                ),
                                items: <String>['Último dia', 'Último 15 dias', 'Último 30 dias', 'Último semestre', 'Último ano']
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                hintText: 'Período',
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade50,
                      height: astecaController.abrirFiltro ? null : 0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: InputComponent(
                                label: 'Data de criação:',
                                hintText: 'Digite a data de criação da peça',
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: InputComponent(
                                label: 'Data de criação:',
                                hintText: 'Digite a data de criação da peça',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        CheckboxComponent(
                          value: marcados == itemsPeca.length,
                          onChanged: (bool value) {
                            setState(() {
                              marcarTodosCheckbox(value);
                            });
                          },
                        ),
                        Expanded(
                          child: const TextComponent('ID'),
                        ),
                        Expanded(
                          child: const TextComponent('Nome'),
                        ),
                        Expanded(
                          child: const TextComponent('Valor R\$', letterSpacing: 0.15, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: const TextComponent('Estoque disponível'),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: const Divider(),
                    ),
                    Expanded(
                      child: itemsPecaBusca.length == 0
                          ? ListView.builder(
                              itemCount: itemsPeca.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  color: (index % 2) == 0 ? Colors.white : Colors.grey.shade50,
                                  child: Row(
                                    children: [
                                      CheckboxComponent(
                                          value: itemsPeca[index].marcado,
                                          onChanged: (bool value) => {
                                                setState(() {
                                                  marcarCheckbox(index, value);
                                                })
                                              }),
                                      Expanded(
                                        child: TextComponent(astecaController.produtoPecas[index].peca.idPeca.toString()),
                                      ),
                                      Expanded(
                                        child: TextComponent(astecaController.produtoPecas[index].peca.descricao),
                                      ),
                                      Expanded(
                                          child: TextComponent(astecaController.formatter
                                              .format(astecaController.produtoPecas[index].peca.custo))),
                                      Expanded(
                                        child: astecaController.produtoPecas[index].peca.estoque.length != 0
                                            ? TextComponent(astecaController
                                                .produtoPecas[index].peca.estoque.first.saldoDisponivel
                                                .toString())
                                            : TextComponent('0'),
                                      ),
                                    ],
                                  ),
                                );
                              })
                          : ListView.builder(
                              itemCount: itemsPecaBusca.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  color: (index % 2) == 0 ? Colors.white : Colors.grey.shade50,
                                  child: Row(
                                    children: [
                                      CheckboxComponent(
                                          value: itemsPecaBusca[index].marcado,
                                          onChanged: (bool value) => {
                                                setState(() {
                                                  marcarCheckbox(index, value);
                                                })
                                              }),
                                      Expanded(
                                        child: TextComponent(itemsPecaBusca[index].produtoPeca.peca.idPeca.toString()),
                                      ),
                                      Expanded(
                                        child: TextComponent(itemsPecaBusca[index].produtoPeca.peca.descricao),
                                      ),
                                      Expanded(
                                        child: TextComponent(itemsPecaBusca[index].produtoPeca.peca.custo.toString()),
                                      ),
                                      Expanded(
                                        child: astecaController.produtoPecas[index].peca.estoque.length != 0
                                            ? TextComponent(astecaController
                                                .produtoPecas[index].peca.estoque.first.saldoDisponivel
                                                .toString())
                                            : TextComponent('0'),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextComponent('Total de peças selecionadas: ${marcados}'),
                          Row(
                            children: [
                              ButtonComponent(
                                  color: Colors.red,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  text: 'Cancelar'),
                              const SizedBox(
                                width: 12,
                              ),
                              ButtonComponent(
                                  color: secundaryColor,
                                  onPressed: () {
                                    adicionarPeca();
                                    Navigator.pop(context);
                                  },
                                  text: 'Adicionar')
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        });
  }
}

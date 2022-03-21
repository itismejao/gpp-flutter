import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:gpp/src/controllers/notify_controller.dart';

import 'package:gpp/src/models/produto_peca_model.dart';
import 'package:gpp/src/models/pecas_model/peca_model.dart';
import 'package:gpp/src/models/pecas_model/produto_model.dart';

import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/InputComponent.dart';
import 'package:gpp/src/shared/components/PaginacaoComponent.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/utils/MaskFormatter.dart';

import '../../controllers/peca_controller.dart';

import '../../shared/components/CheckboxComponent.dart';

class ItemPeca {
  bool marcado = false;
  late ProdutoPecaModel produtoPeca;
  ItemPeca({required this.marcado, required this.produtoPeca});
}

class PecasListView extends StatefulWidget {
  const PecasListView({Key? key}) : super(key: key);

  @override
  State<PecasListView> createState() => _PecasListViewState();
}

class _PecasListViewState extends State<PecasListView> {
  int marcados = 0;
  int ativos = 0;
  bool ativar = false;
  List<ItemPeca> itemsPeca = [];
  bool importado = false;
  late MaskFormatter maskFormatter;
  late GlobalKey<FormState> formKey;

  late PecaController pecaController;

  selecionarTodos(bool value) {
    if (value) {
      marcados = itemsPeca.length;
    } else {
      marcados = 0;
    }
    for (var itemPeca in itemsPeca) {
      itemPeca.marcado = value;
    }
  }

  ativarInativarTodos(bool value) {
    ativar = value;
    for (var item in itemsPeca) {
      item.produtoPeca.peca!.active = value ? 1 : 0;
    }
  }

  selecionar(index, value) {
    if (value) {
      marcados++;
    } else {
      marcados--;
    }
    itemsPeca[index].marcado = value;
  }

  void importarCSV() async {
    FilePickerResult? arquivo = await FilePicker.platform.pickFiles(
        allowedExtensions: ['csv'],
        type: FileType.custom,
        allowMultiple: false);

    if (arquivo != null) {
      //importado
      extrairDadosCSV(arquivo);
      preVisualizarArquivo();
    } else {
      //não importado
    }
  }

  void extrairDadosCSV(arquivo) {
    try {
      //Decodifica em bytes para utf8
      final bytes = utf8.decode(arquivo.files.first.bytes);

      List<List<dynamic>> dados = const CsvToListConverter().convert(bytes);

      //Limpa a lista de itens de peças
      itemsPeca.clear();
      marcados = 0;

      for (var dado in dados.skip(1)) {
        marcados++;

        /** 
     * Falta adicionar a cor e qtd
     */
        itemsPeca.add(ItemPeca(
            marcado: true,
            produtoPeca: new ProdutoPecaModel(
              quantidadePorProduto: int.tryParse(dado.elementAt(3).toString()),
              peca: new PecasModel(
                codigo_fabrica: dado.elementAt(0).toString(), //Descrição
                volumes: dado.elementAt(1).toString(), // Volumes
                descricao: dado.elementAt(2).toString(),
                profundidade: double.tryParse(dado.elementAt(4).toString()),
                altura: double.tryParse(dado.elementAt(5).toString()), // Altura
                largura: double.tryParse(
                  dado.elementAt(6).toString(),
                ),
                cor: dado.elementAt(7).toString(),
                // Largura
              ),
            )));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  decodeUnidadeMedida(value) {
    switch (value.toString().toLowerCase()) {
      case 'mm':
        return 0;
      case 'cm':
        return 1;
      case 'm':
        return 2;
      case 'pol':
        return 3;
    }
  }

  encodeUnidadeMedida(value) {
    switch (value) {
      case 0:
        return 'mm';
      case 1:
        return 'cm';
      case 2:
        return 'm';
      case 3:
        return 'pol';
    }
  }

  inserirPecas(setState, context) async {
    NotifyController notificacao = NotifyController(context: context);

    try {
      if (pecaController.produto.id_produto == null) {
        notificacao.alerta(
            'E necessário informa o produto para realizar a importação das peças');
      } else if (await notificacao.alerta(
          'Gostaria de importar as ${marcados} peças selecionadas ? pressione sim para continuar ou não para cancelar.')) {
        adicionarProdutoPecas();
        //Chama o endpoint
        await pecaController.produtoRepository.inserirPecasProduto(
            pecaController.produto!.id_produto.toString(),
            pecaController.produto!);

        //Limpa
        pecaController.produto = ProdutoModel();

        //Fecha a caixa de dialogo
        Navigator.pop(context);

        notificacao.sucess('Peças cadastradas com sucesso.');
        buscarTodas();
      }
    } catch (e) {
      //Imprime erro
      notificacao.error2(e.toString());
    }
  }

  adicionarProdutoPecas() {
    pecaController.produto!.produtoPecas = [];
    itemsPeca.forEach((itemPeca) async {
      //Se o item estiver marcado, realiza a inserção
      if (itemPeca.marcado) {
        pecaController.produto!.produtoPecas!.add(itemPeca.produtoPeca);
      }
    });
  }

  preVisualizarArquivo() async {
    await showDialog(
      context: context,
      builder: (context) {
        final media = MediaQuery.of(context);

        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return AlertDialog(
              actions: <Widget>[
                Container(
                  width: media.size.width * 0.9,
                  height: media.size.height * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [TitleComponent('Produto')],
                                ),
                              ),
                              Divider(),
                              Form(
                                  child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InputComponent(
                                          maxLines: 1,
                                          label: 'Código do produto',
                                          hintText: '4584544',
                                          onFieldSubmitted: (value) {
                                            buscarProduto(value);
                                            print(pecaController
                                                .produto!.resumida);
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: InputComponent(
                                          key: UniqueKey(),
                                          initialValue:
                                              pecaController.produto!.resumida,
                                          label: 'Descrição',
                                          hintText: 'Guarda roupa',
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: InputComponent(
                                          key: UniqueKey(),
                                          initialValue: pecaController
                                                  .produto!
                                                  .fornecedor
                                                  ?.first
                                                  .cliente
                                                  ?.nome ??
                                              '',
                                          label: 'Fornecedor',
                                          hintText: 'Guarda roupa',
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 24.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.upload_file_rounded,
                                      size: 32,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    TitleComponent('Importar peças')
                                  ],
                                ),
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CheckboxComponent(
                                    value: marcados == itemsPeca.length,
                                    onChanged: (bool value) {
                                      setState(() {
                                        selecionarTodos(value);
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  const Expanded(
                                    child: const TextComponent(
                                      'Código da peça',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  const Expanded(
                                    child: const TextComponent(
                                      'Volumes',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  const Expanded(
                                    child: const TextComponent(
                                      'Descrição',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  // const Expanded(
                                  //   child: const TextComponent(
                                  //     'Unidade',
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  const Expanded(
                                    child: const TextComponent(
                                      'QTD',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  const Expanded(
                                    child: const TextComponent(
                                      'Comprimento',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  const Expanded(
                                    child: const TextComponent(
                                      'Altura',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  const Expanded(
                                    child: const TextComponent(
                                      'Largura',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(
                                    width: 8,
                                  ),
                                  const Expanded(
                                    child: const TextComponent(
                                      'Cor',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  // const Expanded(
                                  //   child: const TextComponent(
                                  //     'Classificação de custo',
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   width: 8,
                                  // ),
                                  // const Expanded(
                                  //   child: const TextComponent(
                                  //     'Tipo de classificação de custo',
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   width: 8,
                                  // ),
                                  // Expanded(
                                  //   child: Wrap(children: [
                                  //     Switch(
                                  //         activeColor: primaryColor,
                                  //         value: ativar,
                                  //         onChanged: (bool value) {
                                  //           setState(() {
                                  //             ativarInativarTodos(value);
                                  //           });
                                  //         }),
                                  //     SizedBox(
                                  //       width: 8,
                                  //     ),
                                  //     const TextComponent(
                                  //       'Ativo/inativo',
                                  //       fontWeight: FontWeight.bold,
                                  //     ),
                                  //   ]),
                                  // ),
                                ],
                              ),
                              Divider(),
                              Expanded(
                                child: Form(
                                  key: formKey,
                                  child: ListView.builder(
                                    itemCount: itemsPeca.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CheckboxComponent(
                                                  value:
                                                      itemsPeca[index].marcado,
                                                  onChanged: (bool value) => {
                                                        setState(() {
                                                          selecionar(
                                                              index, value);
                                                        })
                                                      }),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: InputComponent(
                                                  initialValue: itemsPeca[index]
                                                      .produtoPeca
                                                      .peca!
                                                      .codigo_fabrica
                                                      .toString(),
                                                  onSaved: (value) {
                                                    itemsPeca[index]
                                                        .produtoPeca
                                                        .peca!
                                                        .codigo_fabrica = value;
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: InputComponent(
                                                  initialValue: itemsPeca[index]
                                                      .produtoPeca
                                                      .peca!
                                                      .volumes
                                                      .toString(),
                                                  onSaved: (value) {
                                                    itemsPeca[index]
                                                        .produtoPeca
                                                        .peca!
                                                        .volumes = value;
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: InputComponent(
                                                  onSaved: (value) {
                                                    itemsPeca[index]
                                                        .produtoPeca
                                                        .peca!
                                                        .descricao = value;
                                                  },
                                                  initialValue: itemsPeca[index]
                                                      .produtoPeca
                                                      .peca!
                                                      .descricao
                                                      .toString(),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: InputComponent(
                                                  initialValue: itemsPeca[index]
                                                          .produtoPeca
                                                          .quantidadePorProduto
                                                          ?.toString() ??
                                                      '',
                                                  onSaved: (value) {
                                                    itemsPeca[index]
                                                            .produtoPeca
                                                            .quantidadePorProduto =
                                                        int.tryParse(value);
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: InputComponent(
                                                  initialValue: maskFormatter
                                                      .medida(
                                                          value:
                                                              itemsPeca[index]
                                                                  .produtoPeca
                                                                  .peca!
                                                                  .profundidade
                                                                  .toString())
                                                      .getMaskedText(),
                                                  inputFormatter: [
                                                    maskFormatter.medida()
                                                  ],
                                                  onSaved: (value) {
                                                    itemsPeca[index]
                                                            .produtoPeca
                                                            .peca!
                                                            .profundidade =
                                                        double.tryParse(
                                                            UtilBrasilFields
                                                                .removeCaracteres(
                                                                    value));
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: InputComponent(
                                                  initialValue: maskFormatter
                                                      .medida(
                                                          value:
                                                              itemsPeca[index]
                                                                  .produtoPeca
                                                                  .peca!
                                                                  .altura
                                                                  .toString())
                                                      .getMaskedText(),
                                                  inputFormatter: [
                                                    maskFormatter.medida()
                                                  ],
                                                  onSaved: (value) {
                                                    itemsPeca[index]
                                                            .produtoPeca
                                                            .peca!
                                                            .largura =
                                                        double.tryParse(
                                                            UtilBrasilFields
                                                                .removeCaracteres(
                                                                    value));
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: InputComponent(
                                                  initialValue: maskFormatter
                                                      .medida(
                                                          value:
                                                              itemsPeca[index]
                                                                  .produtoPeca
                                                                  .peca!
                                                                  .largura
                                                                  .toString())
                                                      .getMaskedText(),
                                                  inputFormatter: [
                                                    maskFormatter.medida()
                                                  ],
                                                  onSaved: (value) {
                                                    itemsPeca[index]
                                                            .produtoPeca
                                                            .peca!
                                                            .largura =
                                                        double.tryParse(
                                                            UtilBrasilFields
                                                                .removeCaracteres(
                                                                    value));
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                  child: InputComponent(
                                                initialValue: itemsPeca[index]
                                                    .produtoPeca
                                                    .peca!
                                                    .cor,
                                                onSaved: (value) {
                                                  itemsPeca[index]
                                                      .produtoPeca
                                                      .peca!
                                                      .cor = value; //Cor
                                                },
                                              )),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              // Expanded(
                                              //     child: InputComponent(
                                              //   initialValue: itemsPeca[index]
                                              //       .peca
                                              //       .classificacao_custo
                                              //       .toString(),
                                              //   onSaved: (value) {
                                              //     itemsPeca[index]
                                              //             .peca
                                              //             .classificacao_custo =
                                              //         int.tryParse(value);
                                              //   },
                                              // )),
                                              // SizedBox(
                                              //   width: 8,
                                              // ),
                                              // Expanded(
                                              //     child: InputComponent(
                                              //   initialValue: itemsPeca[index]
                                              //       .peca
                                              //       .tipo_classificacao_custo
                                              //       .toString(),
                                              //   onSaved: (value) {
                                              //     itemsPeca[index]
                                              //             .peca
                                              //             .tipo_classificacao_custo =
                                              //         int.tryParse(value);
                                              //   },
                                              // )),
                                              // SizedBox(
                                              //   width: 8,
                                              // ),
                                              // Expanded(
                                              //     child: Switch(
                                              //         activeColor: primaryColor,
                                              //         value: itemsPeca[index]
                                              //                     .peca
                                              //                     .active ==
                                              //                 1
                                              //             ? true
                                              //             : false,
                                              //         onChanged: (bool value) {
                                              //           setState((() {
                                              //             itemsPeca[index]
                                              //                     .peca
                                              //                     .active =
                                              //                 value ? 1 : 0;
                                              //           }));
                                              //         }))
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: const Divider(),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextComponent(
                                        'Total de peças selecionadas: ${marcados}'),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ButtonComponent(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          text: 'Cancelar',
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        ButtonComponent(
                                            onPressed: () {
                                              print('as');
                                              //formKey save
                                              formKey.currentState!.save();

                                              inserirPecas(setState, context);
                                            },
                                            text: 'Cadastrar peças'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        importado
                            ? LinearProgressIndicator(
                                color: secundaryColor,
                                backgroundColor: primaryColor,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  buscarProduto(value) async {
    NotifyController notify = NotifyController(context: context);
    try {
      pecaController.produto =
          await pecaController.produtoRepository.buscar(value);
    } catch (e) {
      notify.confirmacao(e.toString());
    }
  }

  buscarTodas() async {
    NotifyController notify = NotifyController(context: context);
    try {
      setState(() {
        pecaController.carregado = false;
      });
      //parei aqui
      List retorno = await pecaController.pecaRepository
          .buscarTodos(pecaController.pagina.atual);

      pecaController.pecas = retorno[0];
      pecaController.pagina = retorno[1];

      //Limpa filtros;
      //limparFiltro();
      //Atualiza o status para carregado
      setState(() {
        pecaController.carregado = true;
      });
    } catch (e) {
      // limparFiltro();
      notify.error2(e.toString());
      setState(() {
        pecaController.pecas = [];
        pecaController.carregado = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    //Inicializa o controlador de peça
    pecaController = new PecaController();

    //Inicializa maskFormatter
    maskFormatter = new MaskFormatter();

    //Inicializa form key
    formKey = GlobalKey<FormState>();

    //Buscar peças
    buscarTodas();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: TitleComponent('Peças')),
                Expanded(
                  child: Form(
                    //    key: pedidoController.filtroFormKey,
                    child: InputComponent(
                      maxLines: 1,
                      onFieldSubmitted: (value) {
                        //     pedidoController.idPedido = int.tryParse(value);
                        //Limpa o formúlario
                        //   pedidoController.filtroFormKey.currentState!.reset();
                        //    buscarTodas();
                      },
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      hintText: 'Buscar',
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                ButtonComponent(
                    icon: Icon(Icons.tune_rounded, color: Colors.white),
                    color: secundaryColor,
                    onPressed: () {
                      setState(() {
                        // pedidoController.abrirFiltro =
                        //     !(pedidoController.abrirFiltro);
                      });
                    },
                    text: 'Adicionar filtro'),
                SizedBox(
                  width: 8,
                ),
                ButtonComponent(
                  onPressed: () => importarCSV(),
                  text: 'Importar peças',
                  icon: Icon(
                    Icons.upload_file_rounded,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
                child: pecaController.carregado
                    ? ListView.builder(
                        itemCount: pecaController.pecas.length,
                        itemBuilder: (context, index) {
                          return ItemList(pecaController.pecas[index]);
                        },
                      )
                    : LoadingComponent()),
            PaginacaoComponent(
              total: pecaController.pagina.total,
              atual: pecaController.pagina.atual,
              primeiraPagina: () {
                pecaController.pagina.primeira();
                buscarTodas();
                setState(() {});
              },
              anteriorPagina: () {
                pecaController.pagina.anterior();
                buscarTodas();
                setState(() {});
              },
              proximaPagina: () {
                pecaController.pagina.proxima();
                buscarTodas();
                setState(() {});
              },
              ultimaPagina: () {
                pecaController.pagina.ultima();
                buscarTodas();
                setState(() {});
              },
            )
          ],
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final PecasModel peca;
  const ItemList(
    this.peca, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context,
        //     '/pedidos-entrada/' + pedido[index].idPedidoEntrada.toString());
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
                color: Theme.of(context).primaryColor,
                //color:
                //     situacao(controller.pedidosEntrada[index].dataEmissao!),
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
                        child: TextComponent(
                      'Descrição',
                      fontWeight: FontWeight.bold,
                    )),
                    Expanded(
                        child: TextComponent(
                      'Comprimento',
                      fontWeight: FontWeight.bold,
                    )),
                    Expanded(
                        child: TextComponent(
                      'Altura',
                      fontWeight: FontWeight.bold,
                    )),
                    Expanded(
                        child: TextComponent(
                      'Largura',
                      fontWeight: FontWeight.bold,
                    )),
                    Expanded(
                        child: TextComponent(
                      'Cor',
                      fontWeight: FontWeight.bold,
                    ))
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: TextComponent(
                      '# ${peca.id_peca}',
                    )),
                    Expanded(
                        child: TextComponent(
                      '${peca.descricao}',
                    )),
                    Expanded(
                        child: TextComponent(
                      '${peca.profundidade ?? ''}',
                    )),
                    Expanded(
                        child: TextComponent(
                      '${peca.altura ?? ''}',
                    )),
                    Expanded(
                        child: TextComponent(
                      '${peca.largura ?? ''}',
                    )),
                    Expanded(
                        child: TextComponent(
                      '${peca.cor ?? ''}',
                    ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

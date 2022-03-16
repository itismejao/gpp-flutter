import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/PecasController.dart';

import 'package:gpp/src/models/pecas_model/pecas_model.dart';
import 'package:gpp/src/models/pecas_model/produto_model.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/InputComponent.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/utils/MaskFormatter.dart';

import '../../controllers/pecas_controller/produto_controller.dart';
import '../../shared/components/CheckboxComponent.dart';

class ItemPeca {
  bool marcado = false;
  late PecasModel peca;
  ItemPeca({required this.marcado, required this.peca});
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

  late PecasController pecaController;
  late ProdutoController produtoController;

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
      item.peca.active = value ? 1 : 0;
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

  void importCSV() async {
    FilePickerResult? arquivo = await FilePicker.platform.pickFiles(
        allowedExtensions: ['csv'],
        type: FileType.custom,
        allowMultiple: false);

    if (arquivo != null) {
      //importado
      gerarListaPecas(arquivo);
      preVisualizarArquivo();
    } else {
      //não importado
    }
  }

  void gerarListaPecas(arquivo) {
    //Decodifica em bytes para utf8
    final bytes = utf8.decode(arquivo.files.first.bytes);
    List<List<dynamic>> dados = const CsvToListConverter().convert(bytes);

    //Limpa a lista de itens de peças
    itemsPeca.clear();
    marcados = 0;

    for (var dado in dados.skip(1)) {
      marcados++;

      itemsPeca.add(ItemPeca(
        marcado: true,
        peca: new PecasModel(
            descricao: dado.elementAt(0), //Descrição
            unidade: int.tryParse(dado.elementAt(1).toString()), //Unidade
            altura: double.tryParse(dado.elementAt(2).toString()), // Altura
            largura: double.tryParse(dado.elementAt(3).toString()), // Largura
            profundidade: double.tryParse(dado.elementAt(4).toString()),
            volumes: dado.elementAt(5).toString(), // Volumes
            custo: double.tryParse(dado.elementAt(6).toString()), // Custo
            codigo_fabrica: dado.elementAt(7), // Código de fabricação
            numero: dado.elementAt(8), // Número
            unidade_medida:
                decodeUnidadeMedida(dado.elementAt(9)), // Unidade de medida
            classificacao_custo: int.tryParse(
                dado.elementAt(10).toString()), // Classificação de custo
            tipo_classificacao_custo:
                int.tryParse(dado.elementAt(11).toString()),
            active: int.tryParse(dado.elementAt(12).toString()) // Ativo/inativo

            ),
        // profundidade
      ));
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
      if (await notificacao.alert(
          'Gostaria de importar as ${marcados} peças selecionadas ? pressione sim para continuar ou não para cancelar.')) {
        produtoController.produtoModel.pecas = [];

        //Chama o endpoint
        await produtoController.produtoRepository.inserirPecasProduto(
            produtoController.produtoModel.id_produto.toString(),
            produtoController.produtoModel);

        //Limpa
        produtoController.produtoModel = ProdutoModel();

        //Fecha a caixa de dialogo
        Navigator.pop(context);
        notificacao.sucess('Peças cadastradas com sucesso.');
      }
    } catch (e) {
      //Imprime erro
      notificacao.error2(e.toString());
    }
  }

  adicionarProdutoPecas() {
    itemsPeca.forEach((itemPeca) async {
      //Se o item estiver marcado, realiza a inserção
      if (itemPeca.marcado) {
        produtoController.produtoModel.pecas!.add(itemPeca.peca);
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
                                            carregarProduto(value);
                                            print(produtoController
                                                .produtoModel.resumida);
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
                                          initialValue: produtoController
                                              .produtoModel.resumida,
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
                                          initialValue: produtoController
                                                  .produtoModel
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
                                    flex: 2,
                                    child: const TextComponent(
                                      'Descrição',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  const Expanded(
                                    child: const TextComponent(
                                      'Unidade',
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
                                      'Profundidade',
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
                                      'Custo',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  const Expanded(
                                    child: const TextComponent(
                                      'Código de fabricação',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  const Expanded(
                                    child: const TextComponent(
                                      'Número',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  const Expanded(
                                    child: const TextComponent(
                                      'Unidade de medida',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
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
                                                flex: 2,
                                                child: InputComponent(
                                                  onSaved: (value) {
                                                    itemsPeca[index]
                                                        .peca
                                                        .descricao = value;
                                                  },
                                                  initialValue: itemsPeca[index]
                                                      .peca
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
                                                      .peca
                                                      .unidade
                                                      .toString(),
                                                  onSaved: (value) {
                                                    itemsPeca[index]
                                                            .peca
                                                            .unidade =
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
                                                                  .peca
                                                                  .altura
                                                                  .toString())
                                                      .getMaskedText(),
                                                  inputFormatter: [
                                                    maskFormatter.medida()
                                                  ],
                                                  onSaved: (value) {
                                                    itemsPeca[index]
                                                            .peca
                                                            .altura =
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
                                                                  .peca
                                                                  .largura
                                                                  .toString())
                                                      .getMaskedText(),
                                                  inputFormatter: [
                                                    maskFormatter.medida()
                                                  ],
                                                  onSaved: (value) {
                                                    itemsPeca[index]
                                                            .peca
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
                                                                  .peca
                                                                  .profundidade
                                                                  .toString())
                                                      .getMaskedText(),
                                                  inputFormatter: [
                                                    maskFormatter.medida()
                                                  ],
                                                  onSaved: (value) {
                                                    print(value);
                                                    itemsPeca[index]
                                                            .peca
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
                                                  initialValue: itemsPeca[index]
                                                      .peca
                                                      .volumes
                                                      .toString(),
                                                  onSaved: (value) {
                                                    itemsPeca[index]
                                                        .peca
                                                        .volumes = value;
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: InputComponent(
                                                  initialValue: maskFormatter
                                                      .realInputFormmater(
                                                          itemsPeca[index]
                                                              .peca
                                                              .custo),
                                                  onSaved: (value) {
                                                    itemsPeca[index]
                                                            .peca
                                                            .custo =
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
                                                    .peca
                                                    .codigo_fabrica
                                                    .toString(),
                                                onSaved: (value) {
                                                  itemsPeca[index]
                                                      .peca
                                                      .codigo_fabrica = value;
                                                },
                                              )),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                  child: InputComponent(
                                                initialValue: itemsPeca[index]
                                                    .peca
                                                    .numero
                                                    .toString(),
                                                onSaved: (value) {
                                                  itemsPeca[index].peca.numero =
                                                      value;
                                                },
                                              )),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                  child: InputComponent(
                                                initialValue:
                                                    encodeUnidadeMedida(
                                                        itemsPeca[index]
                                                            .peca
                                                            .unidade_medida),
                                                onSaved: (value) {
                                                  itemsPeca[index]
                                                          .peca
                                                          .unidade_medida =
                                                      int.tryParse(value);
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

  carregarProduto(value) async {
//busca o produto
    produtoController.produtoModel =
        await produtoController.produtoRepository.buscar(value);
  }

  @override
  void initState() {
    super.initState();

    //Inicializa o controlador de peça
    pecaController = new PecasController();

    //Inicializa o controlador de produto
    produtoController = new ProdutoController();

    //Inicializa maskFormatter
    maskFormatter = new MaskFormatter();

    //Inicializa form key
    formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleComponent('Peças'),
                ButtonComponent(
                  onPressed: () => importCSV(),
                  text: 'Importar peças',
                  icon: Icon(
                    Icons.upload_file_rounded,
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

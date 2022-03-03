import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:gpp/src/controllers/AstecaController.dart';

import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/models/AstecaModel.dart';
import 'package:gpp/src/models/asteca_tipo_pendencia_model.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/DropdownButtonFormFieldComponent.dart';

import 'package:gpp/src/shared/components/InputComponent.dart';

import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';

import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/utils/MaskFormatter.dart';
import 'package:gpp/src/shared/utils/Validator.dart';

import 'package:intl/intl.dart';

class AstecaListView extends StatefulWidget {
  const AstecaListView({Key? key}) : super(key: key);

  @override
  _AstecaListViewState createState() => _AstecaListViewState();
}

class _AstecaListViewState extends State<AstecaListView> {
  final ResponsiveController _responsive = ResponsiveController();
  ScrollController scrollController = ScrollController();

  late final AstecaController astecaController;
  late MaskFormatter maskFormatter;
  late Validator validator;

  buscarTodas() async {
    NotifyController notify = NotifyController(context: context);
    try {
      setState(() {
        astecaController.carregado = false;
      });
      var retorno = await astecaController.repository.buscarTodas(astecaController.pagina.atual,
          filtroAsteca: astecaController.filtroAsteca,
          pendencia: astecaController.pendenciaFiltro,
          dataInicio: astecaController.dataInicio,
          dataFim: astecaController.dataFim);

      astecaController.astecas = retorno[0];
      astecaController.pagina = retorno[1];

      limparFiltro();

      //Atualiza o status para carregado
      setState(() {
        astecaController.carregado = true;
      });
    } catch (e) {
      setState(() {
        astecaController.astecas = [];
        astecaController.carregado = true;
      });
      notify.error(e.toString());
    }
  }

  limparFiltro() {
    astecaController.filtroAsteca.idAsteca = '';
    astecaController.filtroAsteca.documentoFiscal!.cpfCnpj = '';
    astecaController.filtroAsteca.documentoFiscal!.numDocFiscal = null;
    astecaController.dataInicio = null;
    astecaController.dataFim = null;
  }

  proximaPagina() async {
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        //proxima página
        astecaController.pagina.atual = astecaController.pagina.atual + 1;
        await buscarTodas();
      }
    });
  }

  buscarTipoPendencias() async {
    setState(() {
      astecaController.carregado = false;
    });

    astecaController.astecaTipoPendencias = await astecaController.repository.pendencia.buscarPendencias();

    setState(() {
      astecaController.carregado = true;
    });
  }

  @override
  initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    //Iniciliza o controlador de asteca
    astecaController = AstecaController();

    //Inicializa mask formatter
    maskFormatter = MaskFormatter();
    //Inicializa validator
    validator = Validator();

    //Função responsável por buscar a lista de astecas
    buscarTodas();

    //Buscar pendências

    buscarTipoPendencias();

    //ScrollController
    proximaPagina();
  }

  void dispose() {
    super.dispose();
    scrollController.dispose();
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
              itemCount: astecaController.astecas.length,
              itemBuilder: (context, index) {
                return _buildListItem(astecaController.astecas, index, context);
              });
        }

        return ListView.builder(
            itemCount: astecaController.astecas.length,
            itemBuilder: (context, index) {
              return _buildListItem(astecaController.astecas, index, context);
            });
      },
    );

    return Container(color: Colors.white, child: widget);
  }

  Widget _buildListItem(List<AstecaModel> asteca, int index, BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (_responsive.isMobile(constraints.maxWidth)) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/astecas/' + asteca[index].idAsteca.toString());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          asteca[index].idAsteca.toString(),
                          style: textStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 18.0),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'ID: ' + asteca[index].idAsteca.toString(),
                          style: textStyle(color: Colors.black, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextComponent(
                            'Nota Fiscal: ' + astecaController.astecas[index].documentoFiscal!.numDocFiscal.toString()),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextComponent('Serie: ' + astecaController.astecas[index].documentoFiscal!.serieDocFiscal!),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextComponent(
                          'Filial de Venda: ' + astecaController.astecas[index].documentoFiscal!.idFilialVenda.toString(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextComponent(
                          'Data de Abertura: ' + DateFormat('dd/MM/yyyy').format(astecaController.astecas[index].dataEmissao!),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: const EdgeInsets.all(8.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextComponent(
                          'Defeito: ' + asteca[index].defeitoEstadoProd.toString(),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: const EdgeInsets.all(4.0)),
                ],
              ),
            ),
          );
        }

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/astecas/' + asteca[index].idAsteca.toString());
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
                    color: situacao(astecaController.astecas[index].dataEmissao!),
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
                            flex: 2,
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
                            child: TextComponent(
                          'Tipo asteca',
                          fontWeight: FontWeight.bold,
                        )),
                        Expanded(
                            flex: 2,
                            child: TextComponent(
                              'Pendência',
                              fontWeight: FontWeight.bold,
                            )),
                        Expanded(
                            flex: 3,
                            child: TextComponent(
                              'Defeito',
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
                              TextComponent(
                                '#' + asteca[index].idAsteca.toString(),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: TextComponent(
                              astecaController.camelCaseAll(asteca[index].documentoFiscal?.nome ?? ''),
                            )),
                        VerticalDivider(
                          color: Colors.red,
                        ),
                        Expanded(
                            flex: 2,
                            child: TextComponent(
                              DateFormat('dd/MM/yyyy').format(asteca[index].dataEmissao!),
                            )),
                        Expanded(
                            child: TextComponent(
                          tipoAsteca(asteca[index].tipoAsteca),
                        )),
                        Expanded(
                            flex: 2,
                            child: asteca[index].astecaTipoPendencias!.isNotEmpty
                                ? TextComponent(
                                    astecaController.camelCaseFirst(asteca[index].astecaTipoPendencias!.last.descricao!),
                                  )
                                : TextComponent('Aguardando pendência')),
                        Expanded(
                            flex: 3,
                            child: TextComponent(
                              astecaController.camelCaseFirst(asteca[index].defeitoEstadoProd!),
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
                Expanded(child: TitleComponent('Astecas')),
                Expanded(
                  child: Form(
                    key: astecaController.filtroFormKey,
                    child: InputComponent(
                      maxLines: 1,
                      onFieldSubmitted: (value) {
                        astecaController.filtroAsteca.idAsteca = value;
                        //Limpa o formúlario
                        astecaController.filtroFormKey.currentState!.reset();
                        buscarTodas();
                      },
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      hintText: 'Digite o número de identificação da asteca',
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
                        astecaController.abrirFiltro = !(astecaController.abrirFiltro);
                      });
                    },
                    text: 'Adicionar filtro')
              ],
            ),
          ),
          Container(
            color: Colors.grey.shade50,
            height: astecaController.abrirFiltro ? null : 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: astecaController.filtroExpandidoFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextComponent('Pendência'),
                              SizedBox(
                                height: 8,
                              ),
                              DropdownButtonFormFieldComponent(
                                hintText: "651 - PEÇA SOLICITADA AO FORNECEDOR",
                                onChanged: (AstecaTipoPendenciaModel value) {
                                  astecaController.pendenciaFiltro = value.idTipoPendencia.toString();
                                },
                                items: astecaController.astecaTipoPendencias
                                    .map<DropdownMenuItem<AstecaTipoPendenciaModel>>((value) {
                                  return DropdownMenuItem<AstecaTipoPendenciaModel>(
                                    value: value,
                                    child: TextComponent(value.idTipoPendencia.toString() + ' - ' + value.descricao!),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: InputComponent(
                            inputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                              CpfOuCnpjFormatter(),
                            ],
                            label: 'CPF ou CNPJ:',
                            maxLines: 1,
                            validator: (value) {
                              validator.cpfOuCnpj(UtilBrasilFields.removeCaracteres(value));
                            },
                            onSaved: (value) {
                              if (value.toString().isNotEmpty) {
                                astecaController.filtroAsteca.documentoFiscal!.cpfCnpj = UtilBrasilFields.removeCaracteres(value);
                              }
                            },
                            hintText: 'Digite o CPF ou CNPJ',
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
                            label: 'Número da nota fiscal:',
                            maxLines: 1,
                            onChanged: (value) {
                              astecaController.filtroAsteca.documentoFiscal!.numDocFiscal = value;
                            },
                            hintText: 'Digite o número da nota fiscal',
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
                                astecaController.dataInicio = DateFormat("dd/MM/yyyy").parse(value);
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
                                astecaController.dataFim = DateFormat("dd/MM/yyyy").parse(value);
                              }
                            },
                            hintText: '25/02/2022',
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ButtonComponent(
                              onPressed: () {
                                // if (astecaController.filtroExpandidoFormKey.currentState!.validate()) {
                                astecaController.filtroExpandidoFormKey.currentState!.save();
                                astecaController.filtroExpandidoFormKey.currentState!.reset();
                                buscarTodas();

                                setState(() {
                                  astecaController.abrirFiltro = false;
                                });
                                //}
                              },
                              text: 'Pesquisar'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: media.height * 0.7,
            child: astecaController.carregado ? _buildList() : LoadingComponent(),
          ),
          Container(
            height: media.height * 0.10,
            width: media.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextComponent('Total de páginas: ' + astecaController.pagina.total.toString()),
                Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.first_page),
                        onPressed: () {
                          astecaController.pagina.atual = 1;
                          buscarTodas();
                        }),
                    IconButton(
                        icon: const Icon(
                          Icons.navigate_before_rounded,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          if (astecaController.pagina.atual > 0) {
                            astecaController.pagina.atual = astecaController.pagina.atual - 1;
                            buscarTodas();
                          }
                        }),
                    TextComponent(astecaController.pagina.atual.toString()),
                    IconButton(
                        icon: Icon(Icons.navigate_next_rounded),
                        onPressed: () {
                          if (astecaController.pagina.atual != astecaController.pagina.total) {
                            astecaController.pagina.atual = astecaController.pagina.atual + 1;
                          }

                          buscarTodas();
                        }),
                    IconButton(
                        icon: Icon(Icons.last_page),
                        onPressed: () {
                          astecaController.pagina.atual = astecaController.pagina.total;
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

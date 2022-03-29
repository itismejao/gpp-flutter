import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:gpp/src/controllers/asteca_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';

import 'package:gpp/src/models/asteca/asteca_model.dart';
import 'package:gpp/src/models/asteca/asteca_tipo_pendencia_model.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/DropdownButtonFormFieldComponent.dart';
import 'package:gpp/src/shared/components/InputComponent.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/utils/MaskFormatter.dart';
import 'package:gpp/src/shared/utils/Validator.dart';
import 'package:gpp/src/views/asteca/AstecaDetalheView.dart';

import '../../shared/components/PaginacaoComponent.dart';

class AstecaView extends StatefulWidget {
  const AstecaView({Key? key}) : super(key: key);

  @override
  _AstecaViewState createState() => _AstecaViewState();
}

class _AstecaViewState extends State<AstecaView> {
  late final AstecaController astecaController;
  late MaskFormatter maskFormatter;
  late Validator validator;

  buscarTodas() async {
    NotifyController notify = NotifyController(context: context);
    try {
      setState(() {
        astecaController.carregado = false;
      });
      var retorno = await astecaController.repository.buscarAstecas(
          astecaController.pagina.atual,
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
      limparFiltro();
      setState(() {
        astecaController.astecas = [];
        astecaController.carregado = true;
      });

      notify.error2(e.toString());
    }
  }

  limparFiltro() {
    astecaController.filtroAsteca.idAsteca = null;
    astecaController.filtroAsteca.documentoFiscal!.cpfCnpj = '';
    astecaController.filtroAsteca.documentoFiscal!.numDocFiscal = null;
    astecaController.dataInicio = null;
    astecaController.dataFim = null;
  }

  buscarTipoPendencias() async {
    setState(() {
      astecaController.carregado = false;
    });

    astecaController.astecaTipoPendencias = await astecaController
        .astecaTipoPendenciaRepository
        .buscarAstecaTIpoPendencias();

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
  }

  exibirDetalhe(id) {
    AlertDialog alert = AlertDialog(
      content: Container(
          height: 1000,
          width: 1200,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                AstecaDetalheView(id: int.tryParse(id)!),
              ],
            ),
          )),
      actions: [],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          astecaController.filtroAsteca.idAsteca =
                              int.tryParse(value);
                          //Limpa o formúlario
                          astecaController.filtroFormKey.currentState!.reset();
                          buscarTodas();
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
                          astecaController.abrirFiltro =
                              !(astecaController.abrirFiltro);
                        });
                      },
                      text: 'Adicionar filtro')
                ],
              ),
            ),
            Container(
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
                                  hintText:
                                      '651 - Peça solicitada ao fornecedor',
                                  onChanged: (AstecaTipoPendenciaModel value) {
                                    astecaController.pendenciaFiltro =
                                        value.idTipoPendencia.toString();
                                  },
                                  items: astecaController.astecaTipoPendencias
                                      .map<
                                              DropdownMenuItem<
                                                  AstecaTipoPendenciaModel>>(
                                          (value) {
                                    return DropdownMenuItem<
                                        AstecaTipoPendenciaModel>(
                                      value: value,
                                      child: TextComponent(
                                          value.idTipoPendencia.toString() +
                                              ' - ' +
                                              astecaController.camelCaseFirst(
                                                  value.descricao)!),
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
                                validator.cpfOuCnpj(
                                    UtilBrasilFields.removeCaracteres(value));
                              },
                              onSaved: (value) {
                                if (value.toString().isNotEmpty) {
                                  astecaController.filtroAsteca.documentoFiscal!
                                          .cpfCnpj =
                                      UtilBrasilFields.removeCaracteres(value);
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
                              onSaved: (value) {
                                astecaController.filtroAsteca.documentoFiscal!
                                    .numDocFiscal = int.tryParse(value);
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
                                  astecaController.dataInicio =
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
                                  astecaController.dataFim =
                                      DateFormat("dd/MM/yyyy").parse(value);
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
                                  astecaController
                                      .filtroExpandidoFormKey.currentState!
                                      .save();
                                  astecaController
                                      .filtroExpandidoFormKey.currentState!
                                      .reset();
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
            Expanded(
                child: astecaController.carregado
                    ? ListView.builder(
                        itemCount: astecaController.astecas.length,
                        itemBuilder: (context, index) {
                          return ItemList(
                              astecaController.astecas[index], exibirDetalhe);
                        })
                    : LoadingComponent()),
            PaginacaoComponent(
              total: astecaController.pagina.total,
              atual: astecaController.pagina.atual,
              primeiraPagina: () {
                astecaController.pagina.primeira();
                buscarTodas();
                setState(() {});
              },
              anteriorPagina: () {
                astecaController.pagina.anterior();
                buscarTodas();
                setState(() {});
              },
              proximaPagina: () {
                astecaController.pagina.proxima();
                buscarTodas();
                setState(() {});
              },
              ultimaPagina: () {
                astecaController.pagina.ultima();
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
  final AstecaModel asteca;
  final Function astecaDetalhe;
  const ItemList(this.asteca, this.astecaDetalhe, {Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Navigator.pushNamed(
          //     context, '/astecas/' + asteca[index].idAsteca.toString());

          astecaDetalhe(asteca.idAsteca.toString());
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
                  color: situacao(asteca.dataEmissao!),
                  width: 7.0,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
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
                            '#' + asteca.idAsteca.toString(),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextComponent(
                          asteca.documentoFiscal?.nome.toString() ?? ''),
                    ),
                    Expanded(
                        child: TextComponent(
                      DateFormat('dd/MM/yyyy').format(asteca.dataEmissao!),
                    )),
                    Expanded(
                        child: TextComponent(
                      tipoAsteca(asteca.tipoAsteca),
                    )),
                    Expanded(
                        flex: 2,
                        child: asteca.astecaPendencias != null
                            ? TextComponent(asteca.astecaPendencias!.first
                                    .astecaTipoPendencia!.descricao ??
                                '')
                            : TextComponent('Aguardando pendência')),
                  ],
                ),
              ]),
            ),
          ),
        ));
  }
}

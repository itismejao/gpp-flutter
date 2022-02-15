import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/MotivoTrocaPecaController.dart';

import 'package:gpp/src/controllers/asteca_controller.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/models/asteca_model.dart';
import 'package:gpp/src/models/asteca_tipo_pendencia_model.dart';

import 'package:gpp/src/models/reason_parts_replacement_model.dart';
import 'package:gpp/src/shared/components/button_component.dart';
import 'package:gpp/src/shared/components/checkbox_component.dart';
import 'package:gpp/src/shared/components/drop_down_component.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/components/text_component.dart';
import 'package:gpp/src/shared/components/title_component.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/utils/mask_formatter.dart';
import 'package:gpp/src/views/asteca/components/item_menu.dart';
import 'package:intl/intl.dart';

class AstecaDetailView extends StatefulWidget {
  final int id;
  const AstecaDetailView({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _AstecaDetailViewState createState() => _AstecaDetailViewState();
}

class _AstecaDetailViewState extends State<AstecaDetailView> {
  late AstecaController _controller;

  late MotivoTrocaPecaController motivoTrocaPecaController;

  late ResponsiveController _responsive;
  late MaskFormatter maskFormatter;

  buscar() async {
    setState(() {
      _controller.carregado = false;
    });
    _controller.asteca = await _controller.repository.buscar(widget.id);

    setState(() {
      _controller.carregado = true;
    });
  }

  buscarPendencias() async {
    setState(() {
      _controller.carregado = false;
    });

    _controller.astecaTipoPendencias =
        await _controller.repository.pendencia.buscarPendencias();

    setState(() {
      _controller.carregado = true;
    });
  }

  buscarMotivosTrocaPeca() async {
    setState(() {
      _controller.carregado = false;
    });

    motivoTrocaPecaController.motivoTrocaPecas =
        await motivoTrocaPecaController.repository.buscarTodos();

    setState(() {
      _controller.carregado = true;
    });
  }

  handlePendencia(
      AstecaModel asteca, AstecaTipoPendenciaModel pendencia) async {
    await _controller.repository.pendencia.criar(asteca, pendencia);
    //Atualiza asteca
    await buscar();
  }

  @override
  void initState() {
    super.initState();

    _controller = AstecaController();
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _controller.step > 1
                              ? ButtonComponent(
                                  color: primaryColor,
                                  onPressed: () {
                                    setState(() {
                                      _controller.step--;
                                    });
                                  },
                                  text: 'Voltar')
                              : Container(),
                          Row(
                            children: [
                              _controller.step != 4
                                  ? ButtonComponent(
                                      color: primaryColor,
                                      onPressed: () {
                                        setState(() {
                                          _controller.step++;
                                        });
                                      },
                                      text: 'Avançar')
                                  : Container(),
                              SizedBox(
                                width: 10,
                              ),
                              ButtonComponent(
                                  color: secundaryColor,
                                  icon: Icon(Icons.save, color: Colors.white),
                                  onPressed: () {},
                                  text: 'Salvar')
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
      return _controller.carregado
          ? Column(
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 2,
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
                                      _controller.abrirDropDownButton =
                                          !_controller.abrirDropDownButton;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: secundaryColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12, top: 12, bottom: 12),
                                        child: _controller
                                                .asteca
                                                .astecaTipoPendencias!
                                                .isNotEmpty
                                            ? TextComponent(
                                                _controller
                                                        .asteca
                                                        .astecaTipoPendencias!
                                                        .last
                                                        .idTipoPendencia
                                                        .toString() +
                                                    ' - ' +
                                                    _controller
                                                        .asteca
                                                        .astecaTipoPendencias!
                                                        .last
                                                        .descricao!,
                                                color: Colors.white)
                                            : TextComponent(
                                                'Aguardando Pendência',
                                                color: Colors.white)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Divider(),
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
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ButtonComponent(
                                                color: secundaryColor,
                                                icon: Icon(Icons.save,
                                                    color: Colors.white),
                                                onPressed: () {},
                                                text: 'Salvar')
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    _controller.abrirDropDownButton
                        ? Positioned(
                            top: 60,
                            right: 14,
                            child: AnimatedOpacity(
                              opacity: 1,
                              duration: const Duration(seconds: 1),
                              child: Container(
                                height: 240,
                                width: 700,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(5)),
                                child: ListView.builder(
                                  itemCount:
                                      _controller.astecaTipoPendencias.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          handlePendencia(
                                              _controller.asteca,
                                              _controller
                                                  .astecaTipoPendencias[index]);

                                          _controller.abrirDropDownButton =
                                              false;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 16),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 16,
                                              height: 16,
                                              decoration: BoxDecoration(
                                                  color: secundaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(2)),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            TextComponent(
                                              _controller
                                                      .astecaTipoPendencias[
                                                          index]
                                                      .idTipoPendencia
                                                      .toString() +
                                                  ' - ' +
                                                  _controller
                                                      .astecaTipoPendencias[
                                                          index]
                                                      .descricao
                                                      .toString(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
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
                  _controller.step = 1;
                });
              },
              child: Container(
                color: _controller.step == 1 ? Colors.white : primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Informações',
                        style: TextStyle(
                            color: _controller.step == 1
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.20),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _controller.step = 2;
                });
              },
              child: Container(
                color: _controller.step == 2 ? Colors.white : primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Endereço',
                        style: TextStyle(
                            color: _controller.step == 2
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.20),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _controller.step = 3;
                });
              },
              child: Container(
                color: _controller.step == 3 ? Colors.white : primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Produto',
                        style: TextStyle(
                            color: _controller.step == 3
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.20),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _controller.step = 4;
                });
              },
              child: Container(
                color: _controller.step == 4 ? Colors.white : primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Peças',
                        style: TextStyle(
                            color: _controller.step == 4
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.20),
                      ),
                    )
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
                    _controller.step = 1;
                    _controller.abrirDropDownButton = false;
                  });
                },
                child: ItemMenu(
                  data: 'Informações',
                  color: _controller.step == 1
                      ? Colors.grey.shade50
                      : Colors.transparent,
                  borderColor: _controller.step == 1
                      ? secundaryColor
                      : Colors.transparent,
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
                    _controller.step = 2;
                    _controller.abrirDropDownButton = false;
                  });
                },
                child: ItemMenu(
                  data: 'Endereço',
                  color: _controller.step == 2
                      ? Colors.grey.shade50
                      : Colors.transparent,
                  borderColor: _controller.step == 2
                      ? secundaryColor
                      : Colors.transparent,
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
                    _controller.step = 3;
                    _controller.abrirDropDownButton = false;
                  });
                },
                child: ItemMenu(
                  data: 'Produto',
                  color: _controller.step == 3
                      ? Colors.grey.shade50
                      : Colors.transparent,
                  borderColor: _controller.step == 3
                      ? secundaryColor
                      : Colors.transparent,
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
                    _controller.step = 4;
                    _controller.abrirDropDownButton = false;
                  });
                },
                child: ItemMenu(
                  data: 'Peças',
                  color: _controller.step == 4
                      ? Colors.grey.shade50
                      : Colors.transparent,
                  borderColor: _controller.step == 4
                      ? secundaryColor
                      : Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _buildAstecaNavigator(MediaQueryData media) {
    switch (_controller.step) {
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
                initialValue: _controller.asteca.idAsteca,
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
                initialValue: _controller.asteca.idAsteca.toString(),
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
                initialValue:
                    'Solicitado pelo técnico, enviar 30 unidades de adesivos/ tapa furos.',
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
                  initialValue: _controller.asteca.idAsteca.toString(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 2,
                child: InputComponent(
                  key: UniqueKey(),
                  initialValue: _controller.asteca.documentoFiscal!.cpfCnpj
                              .toString()
                              .length ==
                          11
                      ? maskFormatter
                          .cpf(_controller.asteca.documentoFiscal!.cpfCnpj
                              .toString())
                          .getMaskedText()
                      : maskFormatter
                          .cnpj(_controller.asteca.documentoFiscal!.cpfCnpj
                              .toString())
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
                  initialValue: _controller.asteca.documentoFiscal!.nome,
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
                  initialValue: _controller.asteca.documentoFiscal!.numDocFiscal
                      .toString(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Série',
                  initialValue:
                      _controller.asteca.documentoFiscal!.serieDocFiscal,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Filial de saída',
                  initialValue: _controller
                      .asteca.documentoFiscal!.idFilialSaida
                      .toString(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Filial venda',
                  initialValue: _controller
                      .asteca.documentoFiscal!.idFilialVenda
                      .toString(),
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
                  initialValue: DateFormat('yyyy/MM/dd')
                      .format(_controller.asteca.dataEmissao!),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Data de compra',
                  initialValue: DateFormat('yyyy/MM/dd')
                      .format(_controller.asteca.documentoFiscal!.dataEmissao!),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Filial Asteca',
                  initialValue: _controller.asteca.idFilialRegistro.toString(),
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
                  initialValue:
                      _controller.asteca.funcionario!.idFuncionario.toString(),
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
                  initialValue: _controller.asteca.funcionario!.nome,
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
                  initialValue: _controller.asteca.defeitoEstadoProd!,
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
                  initialValue: _controller.asteca.observacao,
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
                      style: TextStyle(
                          letterSpacing: 0.15,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'Logradouro',
                  initialValue:
                      'Avenida Perimental Norte NR 1 AP 1903  Torre Itaparica',
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
                      style: TextStyle(
                          letterSpacing: 0.15,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
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
                style: TextStyle(
                    letterSpacing: 0.15,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
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
                  initialValue: _controller.asteca.astecaEndCliente?.logradouro
                      .toString(),
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
                  initialValue: _controller.asteca.astecaEndCliente?.complemento
                      .toString(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Número',
                  initialValue:
                      _controller.asteca.astecaEndCliente?.numero.toString(),
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
                  initialValue:
                      _controller.asteca.astecaEndCliente?.bairro.toString(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Cidade',
                  initialValue: maskFormatter
                      .cep(_controller.asteca.astecaEndCliente?.cep.toString())
                      .getMaskedText(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Cidade',
                  initialValue: _controller.asteca.astecaEndCliente?.localidade
                      .toString(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'Estado',
                  initialValue:
                      _controller.asteca.astecaEndCliente?.uf.toString(),
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
                  initialValue: _controller
                      .asteca.astecaEndCliente?.pontoReferencia1
                      .toString(),
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
                style: TextStyle(
                    letterSpacing: 0.15,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
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
                  initialValue: maskFormatter
                      .telefone(
                          '${_controller.asteca.astecaEndCliente?.ddd.toString()} ${_controller.asteca.astecaEndCliente?.telefone.toString()}')
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
                      style: TextStyle(
                          letterSpacing: 0.15,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
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
                  style: TextStyle(
                      letterSpacing: 0.15,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
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
                  initialValue:
                      _controller.asteca.produto?[0].idProduto.toString(),
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
                  initialValue: _controller.asteca.produto?[0].resumida,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  key: UniqueKey(),
                  label: 'LD',
                  initialValue: _controller
                      .asteca.documentoFiscal?.itemDocFiscal?.idLd
                      .toString(),
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
                  initialValue: _controller
                      .asteca.produto?[0].fornecedor?.idFornecedor
                      .toString(),
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
                      _controller.asteca.produto?[0].fornecedor?.cliente?.nome,
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
          padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                    _buildDialogParts(context);
                  },
                  text: 'Adicionar')
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Expanded(
                child: InputComponent(
                  prefixIcon: Icon(
                    Icons.search,
                  ),
                  hintText: 'Buscar',
                ),
              ),
            ],
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Row(
            children: [
              Expanded(
                child: const TextComponent('ID'),
              ),
              Expanded(
                child: const TextComponent('Nome'),
              ),
              Expanded(
                flex: 3,
                child: const TextComponent('Motivo'),
              ),
              Expanded(
                child: const TextComponent('Quantidade'),
              ),
              Expanded(
                child: const TextComponent('Ações'),
              ),
            ],
          ),
        ),
        Divider(),
        Container(
          height: media.size.height * 0.60,
          child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                return Container(
                  color: (index % 2) == 0 ? Colors.white : Colors.grey.shade50,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextComponent('0001'),
                      ),
                      Expanded(
                        child: TextComponent('Porta Esquerda'),
                      ),
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropDownComponent(
                                onChanged: (value) {
                                  print(value);
                                },
                                items: motivoTrocaPecaController
                                    .motivoTrocaPecas
                                    .map((value) {
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
                        child: TextComponent('47'),
                      ),
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
                                  // handleDelete(context, departament[index])
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Total: 7 peças selecionadas',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              )
            ],
          ),
        )
      ],
    );
  }

  _buildDialogParts(context) {
    MediaQueryData media = MediaQuery.of(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Row(
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
              content: Container(
                width: media.size.width * 0.80,
                height: media.size.height * 0.80,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Text(
                            'Selecione uma ou mais peças para realizar a manutenção',
                            style: TextStyle(
                              letterSpacing: 0.15,
                              fontSize: 16,
                            ),
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
                              prefixIcon: Icon(
                                Icons.search,
                              ),
                              hintText:
                                  'Digite o número de identificação da peça ou o nome',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        children: [
                          Container(
                            width: 220,
                            child: DropDownComponent(
                              icon: Icon(
                                Icons.swap_vert,
                              ),
                              items: <String>[
                                'Ordem crescente',
                                'Ordem decrescente'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              hintText: 'Nome',
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: 220,
                            child: DropDownComponent(
                              icon: Icon(
                                Icons.swap_vert,
                              ),
                              items: <String>[
                                'Ordem crescente',
                                'Ordem decrescente'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              hintText: 'Estoque disponível',
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: 220,
                            child: DropDownComponent(
                              icon: Icon(
                                Icons.swap_vert,
                              ),
                              items: <String>[
                                'Último dia',
                                'Último 15 dias',
                                'Último 30 dias',
                                'Último semestre',
                                'Último ano'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              hintText: 'Período',
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
                                  _controller.isOpenFilter =
                                      !(_controller.isOpenFilter);
                                });
                              },
                              text: 'Adicionar filtro')
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade50,
                      height: _controller.isOpenFilter ? null : 0,
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
                            SizedBox(width: 10),
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
                    Divider(),
                    Row(
                      children: [
                        CheckboxComponent(),
                        Expanded(
                          child: TextComponent('ID'),
                        ),
                        Expanded(
                          child: TextComponent('Nome'),
                        ),
                        Expanded(
                          child: Text(
                            'Endereço do estoque',
                            style: TextStyle(
                                letterSpacing: 0.15,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Estoque disponivel',
                            style: TextStyle(
                                letterSpacing: 0.15,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Data de criação',
                            style: TextStyle(
                                letterSpacing: 0.15,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Data de alteração',
                            style: TextStyle(
                                letterSpacing: 0.15,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Divider(),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              color: (index % 2) == 0
                                  ? Colors.white
                                  : Colors.grey.shade50,
                              child: Row(
                                children: [
                                  CheckboxComponent(),
                                  Expanded(
                                    child: TextComponent('0001'),
                                  ),
                                  Expanded(
                                    child: TextComponent('Porta esquerda'),
                                  ),
                                  Expanded(
                                    child: TextComponent('A-1-B-1'),
                                  ),
                                  Expanded(
                                    child: TextComponent('10'),
                                  ),
                                  Expanded(
                                    child: TextComponent('01/01/2022'),
                                  ),
                                  Expanded(
                                    child: TextComponent('01/01/2022'),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextComponent('Total de 7 peças selecionadas'),
                          Row(
                            children: [
                              ButtonComponent(
                                  color: Colors.red,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  text: 'Cancelar'),
                              SizedBox(
                                width: 12,
                              ),
                              ButtonComponent(
                                  color: secundaryColor,
                                  onPressed: () {
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

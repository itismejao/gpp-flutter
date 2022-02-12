import 'package:flutter/material.dart';

import 'package:gpp/src/controllers/asteca_controller.dart';

import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/models/asteca_model.dart';
import 'package:gpp/src/shared/components/button_component.dart';

import 'package:gpp/src/shared/components/input_component.dart';

import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/components/text_component.dart';
import 'package:gpp/src/shared/components/title_component.dart';

import 'package:gpp/src/shared/repositories/styles.dart';

import 'package:intl/intl.dart';

class AstecaListView extends StatefulWidget {
  const AstecaListView({Key? key}) : super(key: key);

  @override
  _AstecaListViewState createState() => _AstecaListViewState();
}

class _AstecaListViewState extends State<AstecaListView> {
  final ResponsiveController _responsive = ResponsiveController();
  ScrollController scrollController = ScrollController();

  late final AstecaController controller;

  buscar() async {
    NotifyController notify = NotifyController(context: context);
    try {
      controller.astecas = await controller.repository.buscarTodas(
          controller.pagina,
          filtroAsteca: controller.filtroAsteca);

      controller.filtroAsteca.idAsteca = '';
      controller.filtroAsteca.documentoFiscal!.cpfCnpj = '';
      controller.filtroAsteca.documentoFiscal!.numDocFiscal = null;
      //Atualiza o status para carregado
      setState(() {
        controller.carregado = true;
      });
    } catch (e) {
      notify.error(e.toString());
    }
  }

  proximaPagina() async {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        //proxima página
        controller.pagina++;
        await buscar();
      }
    });
  }

  @override
  initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    //Iniciliza o controlador de asteca
    controller = AstecaController();
    buscar();

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
    if (diasEmAtraso > 30) {
      return Colors.red;
    }
  }

  Widget _buildList() {
    Widget widget = LayoutBuilder(
      builder: (context, constraints) {
        if (_responsive.isMobile(constraints.maxWidth)) {
          return ListView.builder(
              itemCount: controller.astecas.length,
              itemBuilder: (context, index) {
                return _buildListItem(controller.astecas, index, context);
              });
        }

        return ListView.builder(
            controller: scrollController,
            itemCount: controller.astecas.length,
            itemBuilder: (context, index) {
              return _buildListItem(controller.astecas, index, context);
            });
      },
    );

    return Container(color: Colors.white, child: widget);
  }

  Widget _buildListItem(
      List<AstecaModel> asteca, int index, BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (_responsive.isMobile(constraints.maxWidth)) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                  context, '/asteca/' + asteca[index].idAsteca.toString());
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
                          style: textStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 18.0),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'ID: ' + asteca[index].idAsteca.toString(),
                          style: textStyle(
                              color: Colors.black, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextComponent('Nota Fiscal: ' +
                            controller
                                .astecas[index].documentoFiscal!.numDocFiscal
                                .toString()),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextComponent('Serie: ' +
                            controller.astecas[index].documentoFiscal!
                                .serieDocFiscal!),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextComponent(
                          'Filial de Venda: ' +
                              controller
                                  .astecas[index].documentoFiscal!.idFilialVenda
                                  .toString(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextComponent(
                          'Data de Abertura: ' +
                              DateFormat('yyyy-MM-dd').format(
                                  controller.astecas[index].dataEmissao!),
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
                          'Defeito: ' +
                              asteca[index].defeitoEstadoProd.toString(),
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
            Navigator.pushNamed(
                context, '/asteca/' + asteca[index].idAsteca.toString());
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
                    color: situacao(controller.astecas[index].dataEmissao!),
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
                          flex: 2,
                          child: Row(
                            children: [
                              Icon(Icons.description),
                              SizedBox(
                                width: 12,
                              ),
                              TextComponent(
                                asteca[index].documentoFiscal!.nome!,
                                fontWeight: FontWeight.bold,
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextComponent(
                              'ID: ' + asteca[index].idAsteca.toString(),
                            ),
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
                            'Nota Fiscal: ' +
                                controller.astecas[index].documentoFiscal!
                                    .numDocFiscal
                                    .toString(),
                          ),
                        ),
                        Spacer(flex: 1),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextComponent('Serie: ' +
                                controller.astecas[index].documentoFiscal!
                                    .serieDocFiscal!),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextComponent(
                            'Filial de Venda: ' +
                                controller.astecas[index].documentoFiscal!
                                    .idFilialVenda
                                    .toString(),
                          ),
                        ),
                        Spacer(flex: 1),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextComponent(
                              'Data de Abertura: ' +
                                  DateFormat('dd-MM-yyyy').format(
                                      controller.astecas[index].dataEmissao!),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextComponent(
                              'Defeito: ' +
                                  controller.astecas[index].defeitoEstadoProd!,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
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
                    key: controller.filtroFormKey,
                    child: InputComponent(
                      maxLines: 1,
                      onFieldSubmitted: (value) {
                        controller.filtroAsteca.idAsteca = value;
                        //Limpa o formúlario
                        controller.filtroFormKey.currentState!.reset();
                        buscar();
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
                        controller.isOpenFilter = !(controller.isOpenFilter);
                      });
                    },
                    text: 'Adicionar filtro')
              ],
            ),
          ),
          Container(
            color: Colors.grey.shade50,
            height: controller.isOpenFilter ? null : 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InputComponent(
                          label: 'CPF ou CNPJ:',
                          maxLines: 1,
                          onChanged: (value) {
                            controller.filtroAsteca.documentoFiscal!.cpfCnpj =
                                value;
                            ;
                          },
                          hintText: 'Digite o CPF ou CNPJ',
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: InputComponent(
                          label: 'Número da nota fiscal:',
                          maxLines: 1,
                          onChanged: (value) {
                            controller.filtroAsteca.documentoFiscal!
                                .numDocFiscal = value;
                          },
                          hintText: 'Digite o número da nota fiscal',
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
                              buscar();
                            },
                            text: 'Pesquisar')
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(),
          Container(
            height: media.height * 0.8,
            child: controller.carregado ? _buildList() : LoadingComponent(),
          ),
        ],
      ),
    );
  }
}

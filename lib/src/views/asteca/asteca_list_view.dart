import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/asteca_controller.dart';

import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/models/asteca_model.dart';
import 'package:gpp/src/shared/components/button_component.dart';
import 'package:gpp/src/shared/components/drop_down_component.dart';
import 'package:gpp/src/shared/components/input_component.dart';

import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/components/text_component.dart';
import 'package:gpp/src/shared/components/title_component.dart';

import 'package:gpp/src/shared/enumeration/asteca_enum.dart';

import 'package:gpp/src/shared/repositories/styles.dart';

import 'asteca_form_view.dart';

class AstecaListView extends StatefulWidget {
  const AstecaListView({Key? key}) : super(key: key);

  @override
  _AstecaListViewState createState() => _AstecaListViewState();
}

class _AstecaListViewState extends State<AstecaListView> {
  final ResponsiveController _responsive = ResponsiveController();

  late final AstecaController _controller = AstecaController();

  changeAstecas() async {
    if (mounted) {
      setState(() {
        _controller.state = AstecaEnum.loading;
      });
    }
    await _controller.fetchAll();
    if (mounted) {
      setState(() {
        _controller.state = AstecaEnum.changeAsteca;
      });
    }
  }

  handleCreate(context) async {
    bool? isCreate = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(actions: <Widget>[AstecaFormView()]);
        });

    if (isCreate != null && isCreate) {
      changeAstecas();
    }
  }

  handleDelete(context, AstecaModel asteca) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await notify.alert("você deseja excluir essa funcionalidade?")) {
        if (await _controller.delete(asteca)) {
          notify.sucess("Funcionalidade excluída!");
          changeAstecas();
        }
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  @override
  initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    changeAstecas();
  }

  Widget _buildList(List<AstecaModel> astecas) {
    Widget widget = LayoutBuilder(
      builder: (context, constraints) {
        if (_responsive.isMobile(constraints.maxWidth)) {
          return ListView.builder(
              itemCount: astecas.length,
              itemBuilder: (context, index) {
                return _buildListItem(astecas, index, context);
              });
        }

        return ListView.builder(
            itemCount: astecas.length,
            itemBuilder: (context, index) {
              return _buildListItem(astecas, index, context);
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
                  context, '/asteca/' + asteca[index].id.toString());
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
                          asteca[index].name!,
                          style: textStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 18.0),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'ID: ' + asteca[index].id.toString(),
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
                        child: TextComponent(
                            'Nota Fiscal: ' + asteca[index].invoice.toString()),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextComponent(
                          'Serie: ' + asteca[index].series.toString(),
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
                              asteca[index].salebranch.toString(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextComponent(
                          'Data de Abertura: ' +
                              asteca[index].opendate.toString(),
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
                          'Defeito: ' + asteca[index].defect.toString(),
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
                context, '/asteca/' + asteca[index].id.toString());
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
                    color: asteca[index].signal == "red"
                        ? Colors.red
                        : asteca[index].signal == "yellow"
                            ? Colors.yellow
                            : Colors.green,
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
                              Icon(Icons.description),
                              SizedBox(
                                width: 12,
                              ),
                              TextComponent(
                                asteca[index].name!,
                                fontWeight: FontWeight.bold,
                              )
                            ],
                          ),
                        ),
                        Spacer(flex: 1),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextComponent(
                              'ID: ' + asteca[index].id.toString(),
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
                            'Nota Fiscal: ' + asteca[index].invoice.toString(),
                          ),
                        ),
                        Spacer(flex: 1),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextComponent(
                              'Serie: ' + asteca[index].series.toString(),
                            ),
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
                                asteca[index].salebranch.toString(),
                          ),
                        ),
                        Spacer(flex: 1),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextComponent(
                              'Data de Abertura: ' +
                                  asteca[index].opendate.toString(),
                            ),
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
                            'Defeito: ' + asteca[index].defect.toString(),
                            color: Colors.grey.shade700,
                          ),
                        ),
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

  Widget _buildAstecas() {
    switch (_controller.state) {
      case AstecaEnum.loading:
        return const LoadingComponent();
      case AstecaEnum.notAsteca:
        return Container();
      case AstecaEnum.changeAsteca:
        return _buildList(_controller.astecas);
    }
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
                TitleComponent('Astecas'),
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
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Container(
                  width: 220,
                  child: DropDownComponent(
                    icon: Icon(
                      Icons.swap_vert,
                    ),
                    items: <String>['Ordem crescente', 'Ordem decrescente']
                        .map((String value) {
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
                Container(
                  width: 220,
                  child: DropDownComponent(
                    icon: Icon(
                      Icons.swap_vert,
                    ),
                    items: <String>[
                      'Em aberto',
                      'Parado',
                      'Em andamento',
                      'Concluído'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hintText: 'Situação',
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
                        _controller.isOpenFilter = !(_controller.isOpenFilter);
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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Container(
                      width: 260,
                      child: DropDownComponent(
                        label: 'Filial de venda',
                        items: <String>['Filial 500', 'Filial 700']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        hintText: 'Selecione a filial de venda',
                      ),
                    ),
                  ),
                  Row(
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
                ],
              ),
            ),
          ),
          Divider(),
          Container(
            height: media.height * 0.8,
            child: _buildAstecas(),
          )
        ],
      ),
    );

    // // return Column(
    // //   children: [
    // //     Padding(
    // //       padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8.0),
    // //       child: Row(
    // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    // //         children: <Widget>[
    // //           Text(
    // //             'Astecas',
    // //             style: textStyle(
    // //                 fontSize: 18,
    // //                 color: Colors.black,
    // //                 fontWeight: FontWeight.w700),
    // //           ),
    // //         ],
    // //       ),
    // //     ),
    // //     Expanded(child: _buildAstecas())
    // //   ],
    // // );
  }
}

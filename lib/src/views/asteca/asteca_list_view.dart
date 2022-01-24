import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/asteca_controller.dart';

import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/models/asteca_model.dart';
import 'package:gpp/src/repositories/astecas_repository.dart';
import 'package:gpp/src/shared/components/loading_view.dart';

import 'package:gpp/src/shared/enumeration/asteca_enum.dart';

import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

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

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: astecas.length,
                  itemBuilder: (context, index) {
                    return _buildListItem(astecas, index, context);
                  }),
            )
          ],
        );
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
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
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
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Nota Fiscal: ' + asteca[index].invoice.toString(),
                            style: textStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Serie: ' + asteca[index].series.toString(),
                            style: textStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Filial de Venda: ' +
                                asteca[index].salebranch.toString(),
                            style: textStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Data de Abertura: ' +
                                asteca[index].opendate.toString(),
                            style: textStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: const EdgeInsets.all(8.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Defeito: ' + asteca[index].defect.toString(),
                            style: textStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: const EdgeInsets.all(4.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Observação: ' + asteca[index].note.toString(),
                            style: textStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
                context, '/asteca/' + asteca[index].id.toString());
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
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
                        child: Text(
                          asteca[index].name!,
                          style: textStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 18.0),
                        ),
                      ),
                      Spacer(flex: 1),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ID: ' + asteca[index].id.toString(),
                            style: textStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
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
                        child: Text(
                          'Nota Fiscal: ' + asteca[index].invoice.toString(),
                          style: textStyle(
                              color: Colors.black, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Spacer(flex: 1),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Serie: ' + asteca[index].series.toString(),
                            style: textStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Filial de Venda: ' +
                              asteca[index].salebranch.toString(),
                          style: textStyle(
                              color: Colors.black, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Spacer(flex: 1),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Data de Abertura: ' +
                                asteca[index].opendate.toString(),
                            style: textStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
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
                        child: Text(
                          'Defeito: ' + asteca[index].defect.toString(),
                          style: textStyle(
                              color: Colors.black, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: const EdgeInsets.all(4.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Observação: ' + asteca[index].note.toString(),
                          style: textStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ],
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            children: [
              Text(
                'Asteca',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.15),
              ),
            ],
          ),
        ),
        Container(
          height: media.height * 0.8,
          child: _buildAstecas(),
        )
      ],
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

import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/asteca_controller.dart';

import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/models/asteca_model.dart';
import 'package:gpp/src/repositories/astecas_repository.dart';

import 'package:gpp/src/shared/enumeration/asteca_enum.dart';

import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

import 'package:gpp/src/views/loading_view.dart';

import 'asteca_form_view.dart';

class AstecaListView extends StatefulWidget {
  const AstecaListView({Key? key}) : super(key: key);

  @override
  _AstecaListViewState createState() => _AstecaListViewState();
}

class _AstecaListViewState extends State<AstecaListView> {
  final ResponsiveController _responsive = ResponsiveController();

  late final AstecaController _controller =
      AstecaController(AstecaRepository(api: gppApi));

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

  handleEdit(context, AstecaModel Asteca) async {
    // bool? isEdit = await showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(actions: <Widget>[
    //         AstecaFormView(
    //           Asteca: asteca,
    //         )
    //       ]);
    //     });

    // if (isEdit != null && isEdit) {
    //   changeAstecas();
    // }
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

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text('astecao',
                            style: textStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w700))),
                    Expanded(
                      child: Center(
                          child: Text('Status',
                              style: textStyle(
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.w700))),
                    ),
                    Expanded(
                      child: Center(
                          child: Text('Ação',
                              style: textStyle(
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.w700))),
                    )
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: ListView.builder(
                    itemCount: astecas.length,
                    itemBuilder: (context, index) {
                      return _buildListItem(astecas, index, context);
                    }),
              )
            ],
          ),
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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          asteca[index].name ?? '',
                          style: textStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      //  _buildStatus(asteca[index].active!),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.grey.shade400,
                              ),
                              onPressed: () => {
                                Navigator.pushNamed(
                                    context,
                                    '/astecas/' +
                                        asteca[index].id.toString())

                                //  handleEdit(context, asteca[index]),
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.grey.shade400,
                              ),
                              onPressed: () =>
                                  handleDelete(context, asteca[index]),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider()
                  ],
                ),
              ),
            ),
          );
        }

        return Container(
          color: (index % 2) == 0 ? Colors.white : Colors.grey.shade50,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    asteca[index].name!,
                    style: textStyle(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //_buildStatus(asteca[index].active!),
                  ],
                )),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey.shade400,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context,
                                '/astecas/' +
                                    asteca[index].id.toString());
                          }
                          //handleEdit(context, asteca[index]),
                          ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.grey.shade400,
                        ),
                        onPressed: () =>
                            handleDelete(context, asteca[index]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Container _buildStatus(bool status) {
    print(status);
    if (status) {
      return Container(
        height: 20,
        width: 60,
        decoration: BoxDecoration(
          color: secundaryColor,
          borderRadius: BorderRadius.all(
              Radius.circular(10.0) //                 <--- border radius here
              ),
        ),
        child: Center(
          child: Text(
            "Ativo",
            style: textStyle(
                fontSize: 12, color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
      );
    } else {
      return Container(
        height: 20,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(
              Radius.circular(10.0) //                 <--- border radius here
              ),
        ),
        child: Center(
          child: Text(
            "Inativo",
            style: textStyle(
                fontSize: 12, color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
      );
    }
  }

  Widget _buildAstecas() {
    switch (_controller.state) {
      case AstecaEnum.loading:
        return const LoadingView();
      case AstecaEnum.notAsteca:
        return Container();
      case AstecaEnum.changeAsteca:
        return _buildList(_controller.astecas);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Astecas',
                    style: textStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700)),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/asteca/register');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: secundaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, left: 25, bottom: 15, right: 25),
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),

                // ButtonPrimaryComponent(
                //     onPressed: () => handleCreate(context), text: "Cadastrar")
              ],
            ),
          ),
          Expanded(child: _buildAstecas())

          // _buildFilterUsers(),
          // Expanded(
          //   child: stateManager(),
          // )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/departament_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/models/departament_model.dart';
import 'package:gpp/src/repositories/DepartamentoRepository.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/status_component.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/shared/enumeration/departament_enum.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/views/departamentos/departament_form_view.dart';

class DepartamentoListView extends StatefulWidget {
  const DepartamentoListView({Key? key}) : super(key: key);

  @override
  _DepartamentoListViewState createState() => _DepartamentoListViewState();
}

class _DepartamentoListViewState extends State<DepartamentoListView> {
  final ResponsiveController _responsive = ResponsiveController();

  late final DepartamentController _controller =
      DepartamentController(DepartamentoRepository());

  changeDepartaments() async {
    try {
      setState(() {
        _controller.state = DepartamentEnum.loading;
      });

      await _controller.fetchAll();

      setState(() {
        _controller.state = DepartamentEnum.changeDepartament;
      });
    } catch (e) {
      setState(() {
        _controller.state = DepartamentEnum.changeDepartament;
      });
    }
  }

  handleCreate(context) async {
    bool? isCreate = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(actions: <Widget>[DepartamentFormView()]);
        });

    if (isCreate != null && isCreate) {
      changeDepartaments();
    }
  }

  handleEdit(context, DepartamentoModel departament) async {
    // bool? isEdit = await showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(actions: <Widget>[
    //         DepartamentFormView(
    //           departament: departament,
    //         )
    //       ]);
    //     });

    // if (isEdit != null && isEdit) {
    //   changeDepartaments();
    // }
  }

  handleDelete(context, DepartamentoModel departament) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await notify
          .confirmacao("você deseja excluir essa funcionalidade?")) {
        if (await _controller.delete(departament)) {
          notify.sucess("Funcionalidade excluída!");
          changeDepartaments();
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

    changeDepartaments();
  }

  Widget _buildList() {
    Widget widget = LayoutBuilder(
      builder: (context, constraints) {
        if (_responsive.isMobile(constraints.maxWidth)) {
          return ListView.builder(
              itemCount: _controller.departaments.length,
              itemBuilder: (context, index) {
                return _buildListItem(index, context);
              });
        }

        return Column(
          children: [
            Divider(),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: TextComponent('Nome')),
                  Expanded(child: TextComponent('Status')),
                  Expanded(child: TextComponent('Opções')),
                ],
              ),
            ),
            Divider(),
            Container(
              height: 400,
              child: ListView.builder(
                  itemCount: _controller.departaments.length,
                  itemBuilder: (context, index) {
                    return _buildListItem(index, context);
                  }),
            )
          ],
        );
      },
    );

    return Container(color: Colors.white, child: widget);
  }

  Widget _buildListItem(int index, BuildContext context) {
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
                          _controller.departaments[index].nome ?? '',
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
                        _buildStatus(_controller.departaments[index].situacao!),
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
                                    '/departaments/' +
                                        _controller
                                            .departaments[index].idDepartamento
                                            .toString())

                                //  handleEdit(context, departament[index]),
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.grey.shade400,
                              ),
                              onPressed: () => handleDelete(
                                  context, _controller.departaments[index]),
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
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: TextComponent(
                  _controller.departaments[index].nome!,
                )),
                Expanded(
                    child: Row(
                  children: [
                    StatusComponent(
                        status: _controller.departaments[index].situacao!)
                  ],
                )),
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey.shade400,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context,
                                '/departaments/' +
                                    _controller
                                        .departaments[index].idDepartamento
                                        .toString());
                          }
                          //handleEdit(context, departament[index]),
                          ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.grey.shade400,
                        ),
                        onPressed: () => handleDelete(
                            context, _controller.departaments[index]),
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

  // Widget _buildDepartaments() {
  //   switch (_controller.state) {
  //     case DepartamentEnum.loading:
  //       return const LoadingComponent();
  //     case DepartamentEnum.notDepartament:
  //       return Container();
  //     case DepartamentEnum.changeDepartament:
  //       return _buildList(_controller.departaments);
  //   }
  // }

  exibirFormDepartamento() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(title: DepartamentFormView());
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TitleComponent('Departamentos'),
                    ButtonComponent(
                        onPressed: () {
                          exibirFormDepartamento();
                        },
                        text: 'Adicionar')
                  ],
                ),
              ),
              _controller.state == DepartamentEnum.changeDepartament
                  ? _buildList()
                  : LoadingComponent()
            ],
          ),
        ),
      ),
    );
  }
}

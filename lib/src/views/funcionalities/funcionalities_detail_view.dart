import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/funcionalities_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';

import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/controllers/subfuncionalities_controller.dart';
import 'package:gpp/src/models/subfuncionalities_model.dart';
import 'package:gpp/src/shared/components/button_component.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/components/status_component.dart';
import 'package:gpp/src/shared/components/text_component.dart';
import 'package:gpp/src/shared/components/title_component.dart';
import 'package:gpp/src/shared/enumeration/funcionalities_enum.dart';
import 'package:gpp/src/shared/enumeration/subfuncionalities_enum.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/components/loading_view.dart';

// ignore: must_be_immutable
class FuncionalitiesDetailView extends StatefulWidget {
  String id;
  FuncionalitiesDetailView({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _FuncionalitiesDetailViewState createState() =>
      _FuncionalitiesDetailViewState();
}

class _FuncionalitiesDetailViewState extends State<FuncionalitiesDetailView> {
  late FuncionalitiesController _controllerFuncionalities;

  late SubFuncionalitiesController _controller;
  final ResponsiveController _responsive = ResponsiveController();
  fetch() async {
    await _controller.fetch(widget.id);
    setState(() {
      _controller.state = SubFuncionalitiesEnum.change;
    });
  }

  handleDelete(SubFuncionalitiesModel subFuncionalities, context) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await notify.alert("você deseja excluir essa subfuncionalidade?")) {
        if (await _controller.delete(subFuncionalities)) {
          notify.sucess("SubFuncionalidade excluída!");
          Navigator.pushReplacementNamed(
              context, '/funcionalities/' + widget.id);
        }
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  fetchFuncionalities() async {
    await _controllerFuncionalities.fetch(widget.id);
    setState(() {
      _controllerFuncionalities.state = FuncionalitiesEnum.change;
    });
  }

  handleUpdate(context) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await _controllerFuncionalities.update()) {
        notify.sucess("SubFuncionalidade atualizada!");
        Navigator.pushReplacementNamed(context, '/funcionalities');
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    _controller = SubFuncionalitiesController();
    _controllerFuncionalities = FuncionalitiesController();

    fetch();
    fetchFuncionalities();
  }

  Widget build(BuildContext context) {
    if (_controller.state == SubFuncionalitiesEnum.change &&
        _controllerFuncionalities.state == FuncionalitiesEnum.change) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              child: TitleComponent('Funcionalidades'),
            ),
            Container(
              child: Form(
                  key: _controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputComponent(
                        initialValue:
                            _controllerFuncionalities.funcionalitie.name,
                        label: "Nome",
                        onChanged: (value) {
                          _controllerFuncionalities.funcionalitie.name = value;
                        },
                        validator: (value) {
                          _controller.validate(value);
                        },
                        hintText: "Digite o nome da funcionalidade",
                        prefixIcon: Icon(Icons.lock),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InputComponent(
                        initialValue:
                            _controllerFuncionalities.funcionalitie.icon,
                        label: "Icon",
                        onChanged: (value) {
                          _controllerFuncionalities.funcionalitie.icon = value;
                        },
                        validator: (value) {
                          _controllerFuncionalities.validate(value);
                        },
                        hintText: "Digite o código do icon",
                        prefixIcon: Icon(Icons.lock),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Radio(
                                activeColor: secundaryColor,
                                value: true,
                                groupValue: _controllerFuncionalities
                                    .funcionalitie.active,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _controllerFuncionalities
                                        .funcionalitie.active = value;
                                  });
                                }),
                            Text("Habilitado"),
                            Radio(
                                activeColor: secundaryColor,
                                value: false,
                                groupValue: _controllerFuncionalities
                                    .funcionalitie.active,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _controllerFuncionalities
                                        .funcionalitie.active = value;
                                  });
                                }),
                            Text("Desabilitado"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: Row(
                          children: [
                            ButtonComponent(
                                onPressed: () {
                                  handleUpdate(context);
                                },
                                text: 'Salvar')
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: TitleComponent('Subfuncionalidades'),
            ),
            _buildList(_controller.subFuncionalities),
          ],
        ),
      );
    } else {
      return LoadingComponent();
    }
  }

  Widget _buildList(List<SubFuncionalitiesModel> subFuncionalities) {
    Widget widget = LayoutBuilder(
      builder: (context, constraints) {
        if (_responsive.isMobile(constraints.maxWidth)) {
          return ListView.builder(
              itemCount: subFuncionalities.length,
              itemBuilder: (context, index) {
                return _buildListItem(subFuncionalities, index, context);
              });
        }

        return Column(
          children: [
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: TextComponent('Nome'),
                  ),
                  Expanded(
                    child: TextComponent('Status'),
                  ),
                  Expanded(
                    child: TextComponent('Opções'),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              height: 500,
              child: ListView.builder(
                  itemCount: subFuncionalities.length,
                  itemBuilder: (context, index) {
                    return _buildListItem(subFuncionalities, index, context);
                  }),
            )
          ],
        );
      },
    );

    return Container(color: Colors.white, child: widget);
  }

  Widget _buildListItem(List<SubFuncionalitiesModel> subFuncionalities,
      int index, BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (_responsive.isMobile(constraints.maxWidth)) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextComponent(subFuncionalities[index].name ?? ''),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    StatusComponent(status: subFuncionalities[index].active!),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.add,
                            color: Colors.grey.shade400,
                          ),
                          onPressed: () => {
                            //  handleEdit(context, subFuncionalities[index]),
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey.shade400,
                          ),
                          onPressed: () => {
                            print('tsss')

                            //  handleEdit(context, subFuncionalities[index]),
                          },
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.grey.shade400,
                            ),
                            onPressed: () {
                              handleDelete(subFuncionalities[index], context);
                            }),
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
          child: Row(
            children: [
              Expanded(
                child: TextComponent(subFuncionalities[index].name!),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 60,
                    child: StatusComponent(
                        status: subFuncionalities[index].active!),
                  ),
                ],
              )),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.grey.shade400,
                        ),
                        onPressed: () {
                          // Navigator.pushNamed(
                          //     context,
                          //     '/departaments/' +
                          //         departament[index].id.toString());
                        }
                        //handleEdit(context, departament[index]),
                        ),
                    IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.grey.shade400,
                        ),
                        onPressed: () {
                          handleDelete(subFuncionalities[index], context);
                        }),
                  ],
                ),
              ),
            ],
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
}

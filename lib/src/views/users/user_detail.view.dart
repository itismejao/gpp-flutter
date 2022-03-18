import 'package:flutter/material.dart';

import 'package:gpp/src/controllers/departament_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/UserController.dart';
import 'package:gpp/src/models/departament_model.dart';
import 'package:gpp/src/models/user_model.dart';
import 'package:gpp/src/repositories/DepartamentoRepository.dart';

import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/drop_down_component.dart';
import 'package:gpp/src/shared/components/InputComponent.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/shared/enumeration/departament_enum.dart';
import 'package:gpp/src/shared/enumeration/user_enum.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

import 'package:gpp/src/shared/components/loading_view.dart';

// ignore: must_be_immutable
class UserDetailView extends StatefulWidget {
  String id;

  UserDetailView({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _UserDetailViewState createState() => _UserDetailViewState();
}

class _UserDetailViewState extends State<UserDetailView> {
  late final UsuarioController _controller;

  late final DepartamentController _departamentController =
      DepartamentController(DepartamentoRepository());

  bool _selectedAll = false;

  changeUsersFuncionalities() async {
    setState(() {
      _controller.state = UserEnum.loading;
    });
    await _controller.changeUserFuncionalities(widget.id);
    setState(() {
      _controller.state = UserEnum.changeUser;
    });
  }

  handleCheckBox(bool? value, int index) {
    setState(() {
      if (value!) {
        _controller.subFuncionalities[index].situacao = true;
      } else {
        _controller.subFuncionalities[index].situacao = false;
      }
    });
  }

  handleSelectedAll(value) {
    setState(() {
      _selectedAll = value;

      for (var i = 0; i < _controller.subFuncionalities.length; i++) {
        _controller.subFuncionalities[i].situacao = value;
      }
    });
  }

  checkedSelectedAll() {
    setState(() {
      _selectedAll = true;
      for (var i = 0; i < _controller.subFuncionalities.length; i++) {
        if (!_controller.subFuncionalities[i].situacao!) {
          _selectedAll = false;
        }
      }
    });
  }

  void handleUpdate(UsuarioModel user) async {
    NotifyController nofity = NotifyController(context: context);

    try {
      if (await _controller.update(user) &&
          await _controller.updateUserSubFuncionalities(
              user, _controller.subFuncionalities)) {
        nofity.sucess("Usuário atualizado!");
        Navigator.pushReplacementNamed(context, '/users');
      }
    } catch (e) {
      nofity.error(e.toString());
    }
  }

  fetchDepartamentsSubfuncionalities(DepartamentoModel departament) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await notify.alert(
          "As funcionalidades serão alteradas, deseja concluir a operação?")) {
        await _departamentController
            .changeDepartamentSubFuncionalities(departament);
        setState(() {
          _controller.subFuncionalities =
              _departamentController.subFuncionalities;
        });
        checkedSelectedAll();
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  fetchDepartaments() async {
    await _departamentController.fetchAll();
    setState(() {
      _departamentController.state = DepartamentEnum.changeDepartament;
    });
  }

  fetchUser() async {
    await _controller.fetchUser(widget.id);
    setState(() {
      _controller.state = UserEnum.changeUser;
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    _controller = UsuarioController();

    //Carrega o usuário
    fetchUser();

    //Carrega as funcionalidades do usuário
    changeUsersFuncionalities();

    //   //Busca os departamentos
    fetchDepartaments();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    if (_controller.state == UserEnum.changeUser &&
        _departamentController.state == DepartamentEnum.changeDepartament) {
      return _buildForm(mediaQuery);
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingComponent(),
        ],
      );
    }
  }

  Padding _buildForm(MediaQueryData mediaQuery) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleComponent('Usuário'),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: InputComponent(
                  label: "RE",
                  initialValue: _controller.user.uid.toString(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: InputComponent(
                  label: "Nome",
                  initialValue: _controller.user.nome,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: InputComponent(
                  label: "E-mail",
                  initialValue: _controller.user.email,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Radio(
                        activeColor: secundaryColor,
                        value: true,
                        groupValue: _controller.user.active,
                        onChanged: (bool? value) {
                          setState(() {
                            _controller.user.active = value;
                          });
                        }),
                    Text("Habilitado"),
                    Radio(
                        activeColor: primaryColor,
                        value: false,
                        groupValue: _controller.user.active,
                        onChanged: (bool? value) {
                          setState(() {
                            _controller.user.active = value;
                          });
                        }),
                    Text("Desabilitado"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Departamento: ",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    DropDownComponent(
                        label: 'Departamento',
                        hintText: _controller.user.departament!.nome ??
                            'Escolha o departamento',
                        onChanged: (DepartamentoModel? value) {
                          _controller.user.departament = value;
                          fetchDepartamentsSubfuncionalities(value!);
                        },
                        items: _departamentController.departaments.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value.nome!),
                          );
                        }).toList()),
                  ],
                ),
              ),
              TitleComponent('Funcionalidades'),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  children: [
                    Checkbox(
                      activeColor: primaryColor,
                      checkColor: Colors.white,
                      value: _selectedAll,
                      onChanged: (bool? value) => handleSelectedAll(value),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextComponent('Nome'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _controller.subFuncionalities.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          child: Row(
                            children: [
                              Checkbox(
                                activeColor: primaryColor,
                                checkColor: Colors.white,
                                value: _controller
                                    .subFuncionalities[index].situacao,
                                onChanged: (bool? value) =>
                                    handleCheckBox(value, index),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _controller
                                          .subFuncionalities[index].nome!,
                                      style: textStyle(
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      })),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Row(
                  children: [
                    ButtonComponent(
                        onPressed: () => handleUpdate(_controller.user),
                        text: 'Salvar')
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

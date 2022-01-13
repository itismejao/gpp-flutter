import 'package:flutter/material.dart';

import 'package:gpp/src/controllers/departament_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/user_controller.dart';
import 'package:gpp/src/models/departament_model.dart';
import 'package:gpp/src/models/user_model.dart';
import 'package:gpp/src/repositories/departament_repository.dart';
import 'package:gpp/src/repositories/user_repository.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/enumeration/departament_enum.dart';
import 'package:gpp/src/shared/enumeration/user_enum.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:gpp/src/views/loading_view.dart';

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
  late final UserController _controller =
      UserController(repository: UserRepository(api: gppApi));

  late final DepartamentController _departamentController =
      DepartamentController(DepartamentRepository(api: gppApi));

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
        _controller.subFuncionalities[index].active = true;
      } else {
        _controller.subFuncionalities[index].active = false;
      }
    });
  }

  handleSelectedAll(value) {
    setState(() {
      _selectedAll = value;

      for (var i = 0; i < _controller.subFuncionalities.length; i++) {
        _controller.subFuncionalities[i].active = value;
      }
    });
  }

  checkedSelectedAll() {
    setState(() {
      _selectedAll = true;
      for (var i = 0; i < _controller.subFuncionalities.length; i++) {
        if (!_controller.subFuncionalities[i].active!) {
          _selectedAll = false;
        }
      }
    });
  }

  void handleUpdate(UserModel user) async {
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

  fetchDepartamentsSubfuncionalities(DepartamentModel departament) async {
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
          LoadingView(),
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
              Text(
                "Dados pessoais",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
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
                  initialValue: _controller.user.name,
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
                padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(5)),
                      child: DropdownButtonFormField(
                        items: _departamentController.departaments.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value.name!),
                          );
                        }).toList(),
                        // validator: (value) => validate(value),
                        onChanged: (DepartamentModel? value) {
                          _controller.user.departament = value;
                          fetchDepartamentsSubfuncionalities(value!);
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: 10, left: 20, bottom: 10, right: 20),
                            border: InputBorder.none,
                            hintText: _controller.user.departament!.id == null
                                ? 'Escolha o departamento'
                                : _controller.user.departament!.name),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Subfuncionalidades",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            activeColor: primaryColor,
                            checkColor: Colors.white,
                            value: _selectedAll,
                            onChanged: (bool? value) =>
                                handleSelectedAll(value),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nome',
                              style: textStyle(
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      activeColor: primaryColor,
                                      checkColor: Colors.white,
                                      value: _controller
                                          .subFuncionalities[index].active,
                                      onChanged: (bool? value) =>
                                          handleCheckBox(value, index),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _controller
                                          .subFuncionalities[index].name!,
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
                    GestureDetector(
                      onTap: () => handleUpdate(_controller.user),
                      child: Container(
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 25, bottom: 15, right: 25),
                          child: Text(
                            "Editar",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
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

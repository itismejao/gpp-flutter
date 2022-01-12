import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/departament_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/user_controller.dart';
import 'package:gpp/src/models/departament_model.dart';
import 'package:gpp/src/models/user_model.dart';
import 'package:gpp/src/repositories/departament_repository.dart';
import 'package:gpp/src/repositories/user_repository.dart';
import 'package:gpp/src/shared/enumeration/user_enum.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

// ignore: must_be_immutable
class UserDetailView extends StatefulWidget {
  UserModel user;

  UserDetailView({Key? key, required this.user}) : super(key: key);

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
    await _controller.changeUserFuncionalities(widget.user);
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

  void handleEdit(UserModel user) async {
    NotifyController nofity = NotifyController(context: context);

    try {
      if (await _controller.update(user) &&
          await _controller.updateUserSubFuncionalities(
              widget.user, _controller.subFuncionalities)) {
        nofity.sucess("Usuário atualizado!");
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

  void handleSalved(
    context,
  ) async {
    NotifyController nofity = NotifyController(context: context);
    if (await _controller.updateUserSubFuncionalities(
        widget.user, _controller.subFuncionalities)) {
      nofity.sucess("Usuário atualizado !");
    } else {
      nofity.error("Usuário não atualizado !");
    }
  }

  // void fetchUser() {
  //   widget.user = UserModel(
  //     id: 2,
  //     uid: 9010000409,
  //     name: "Fernando Henrique Ramos Mendes",
  //     email: "mendesfnando@gmail.com",
  //     active: false,
  //   );
  // }

  fetchDepartaments() async {
    await _departamentController.fetchAll();
  }

  @override
  initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    //carrega usúario

    //fetchUser();

    //Busca os departamentos
    fetchDepartaments();

    //Carrega as funcionalidades do usuário
    changeUsersFuncionalities();

    //Verificar funcionalidades marcadas
    checkedSelectedAll();
  }

  @override
  Widget build(BuildContext context) {
    return _buildForm();
  }

  Padding _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "RE: ",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(5)),
                        child: TextFormField(
                          enabled: false,
                          initialValue: widget.user.uid.toString(),
                          // validator: (value) => validate(value),
                          onChanged: (value) {
                            widget.user.uid = int.parse(value);
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: 10, left: 20, bottom: 10, right: 20),
                              border: InputBorder.none,
                              hintText: 'Digite o RE do usuário'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nome: ",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(5)),
                        child: TextFormField(
                          enabled: false,
                          initialValue: widget.user.name,
                          // validator: (value) => validate(value),
                          onChanged: (value) {
                            widget.user.name = value;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: 10, left: 20, bottom: 10, right: 20),
                              border: InputBorder.none,
                              hintText: 'Digite o nome do usuário'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "E-mail: ",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(5)),
                        child: TextFormField(
                          enabled: false,
                          initialValue: widget.user.email,
                          // validator: (value) => validate(value),
                          onChanged: (value) {
                            widget.user.email = value;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: 10, left: 20, bottom: 10, right: 20),
                              border: InputBorder.none,
                              hintText: 'Digite o e-mail'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Radio(
                              activeColor: secundaryColor,
                              value: true,
                              groupValue: widget.user.active,
                              onChanged: (bool? value) {
                                setState(() {
                                  widget.user.active = value;
                                });
                              }),
                          Text("Habilitado"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              activeColor: primaryColor,
                              value: false,
                              groupValue: widget.user.active,
                              onChanged: (bool? value) {
                                setState(() {
                                  widget.user.active = value;
                                });
                              }),
                          Text("Desabilitado"),
                        ],
                      )
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
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(5)),
                        child: DropdownButtonFormField(
                          items:
                              _departamentController.departaments.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value.name!),
                            );
                          }).toList(),
                          // validator: (value) => validate(value),
                          onChanged: (DepartamentModel? value) {
                            widget.user.departament = value;
                            fetchDepartamentsSubfuncionalities(value!);
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: 10, left: 20, bottom: 10, right: 20),
                              border: InputBorder.none,
                              hintText: widget.user.departament!.id == null
                                  ? 'Escolha o departamento'
                                  : widget.user.departament!.name),
                        ),
                      ),
                    ],
                  ),
                ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                        onTap: () => handleEdit(widget.user),
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/controllers/user_controller.dart';
import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/models/user_model.dart';
import 'package:gpp/src/repositories/user_repository.dart';
import 'package:gpp/src/shared/enumeration/user_enum.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:gpp/src/views/loading_view.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  Widget build(BuildContext context) {
    return const UserListView();
  }
}

class UserListView extends StatefulWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  late final UserController _controller =
      UserController(repository: UserRepository(api: gppApi));
  final ResponsiveController _responsive = ResponsiveController();
  void changeUsers() async {
    if (mounted) {
      setState(() {
        _controller.state = UserEnum.loading;
      });
    }
    await _controller.changeUser();
    if (mounted) {
      setState(() {
        _controller.state = UserEnum.changeUser;
      });
    }
  }

  @override
  initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    changeUsers();
  }

  DropdownButtonFormField<String> dropDownButton() {
    return DropdownButtonFormField<String>(
        decoration: inputDecoration(
          'Selecione o departamento',
          const Icon(
            Icons.format_list_bulleted,
          ),
        ),
        // value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        onChanged: (value) {
          if (mounted) {
            setState(() {
              _controller.state = UserEnum.loading;
            });
          }
          _controller.search(value!);
          if (mounted) {
            setState(() {
              _controller.state = UserEnum.changeUser;
            });
          }
        },
        items: <String>['One', 'Two', 'Free', 'Four']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        hint: const Text(
          "Selecione o departamento",
          style: TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
        ));
  }

  TextFormField inputSearch() {
    return TextFormField(
      onChanged: (value) {
        if (mounted) {
          setState(() {
            _controller.state = UserEnum.loading;
          });
        }
        _controller.search(value);
        if (mounted) {
          setState(() {
            _controller.state = UserEnum.changeUser;
          });
        }
      },
      style: textStyle(
          fontWeight: FontWeight.w700,
          color: Colors.black,
          fontSize: 14,
          height: 1.8),
      decoration: inputDecoration('Buscar', const Icon(Icons.search)),
    );
  }

  stateManager() {
    switch (_controller.state) {
      case UserEnum.loading:
        return const LoadingView();

      case UserEnum.changeUser:
        return _controller.usersSearch.isEmpty
            ? _buildUserList(_controller.users)
            : _buildUserList(_controller.usersSearch);
      case UserEnum.notUser:
        // ignore: todo
        // TODO: Handle this case.
        break;
    }
  }

  Widget _buildUserList(List<UserModel> users) {
    Widget widget = LayoutBuilder(
      builder: (context, constraints) {
        if (_responsive.isMobile(constraints.maxWidth)) {
          return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return _buildListItem(users, index, context);
              });
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Text('Nome',
                          style: textStyle(
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w700))),
                  Expanded(
                      child: Text('RE',
                          style: textStyle(
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w700))),
                  Expanded(
                      child: Text('Departamento',
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
            const Divider(),
            Expanded(
              child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return _buildListItem(users, index, context);
                  }),
            )
          ],
        );
      },
    );

    return widget;
  }

  Widget _buildListItem(
      List<UserModel> users, int index, BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (_responsive.isMobile(constraints.maxWidth)) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          color: users[index].active == "1"
                              ? secundaryColor
                              : Colors.grey.shade400,
                          width: 4))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: 50,
                            width: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                  'https://picsum.photos/250?image=9'),
                            )),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              users[index].name!,
                              style: textStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            users[index].departement != null
                                ? Text(
                                    users[index].departement!,
                                    style: textStyle(
                                        color: Colors.grey.shade400,
                                        fontWeight: FontWeight.w700),
                                  )
                                : Text('',
                                    style: textStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700))
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                            style: buttonStyle,
                            onPressed: () => {
                                  Navigator.pushNamed(context, '/user_detail',
                                      arguments: users[index])
                                },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('Editar',
                                  style: textStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      SizedBox(
                          height: 50,
                          width: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                                'https://picsum.photos/250?image=9'),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        users[index].name!,
                        style: textStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                    ],
                  )),
              Expanded(
                  child: Text(
                users[index].uid!,
                style:
                    textStyle(color: Colors.black, fontWeight: FontWeight.w700),
              )),
              Expanded(
                  child: users[index].departement != null
                      ? Text(
                          users[index].departement!,
                          style: textStyle(
                              color: Colors.black, fontWeight: FontWeight.w700),
                        )
                      : Text('',
                          style: textStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700))),
              Expanded(
                  child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    color: users[index].active == "1"
                        ? secundaryColor
                        : Colors.grey.shade400,
                    shape: BoxShape.circle),
              )),
              Expanded(
                child: ElevatedButton(
                    style: buttonStyle,
                    onPressed: () => {
                          Navigator.pushNamed(context, '/user_detail',
                              arguments: users[index])
                        },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('Editar',
                          style: textStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700)),
                    )),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              children: [
                Expanded(
                    child: Text('Usuários',
                        style: textStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w700))),
              ],
            ),
          ),
          _buildFilterUsers(),
          Expanded(
            child: stateManager(),
          )
        ],
      ),
    );
  }

  LayoutBuilder _buildFilterUsers() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 600) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: inputSearch(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: dropDownButton(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: dropDownButton(),
              )
            ],
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: inputSearch(),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: dropDownButton(),
                ),
                const SizedBox(
                  width: 12,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

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

  changeUsersFuncionalities() async {
    setState(() {
      _controller.state = UserEnum.loading;
    });
    await _controller.changeUserFuncionalities();
    setState(() {
      _controller.state = UserEnum.changeUser;
    });
  }

  handleCheckBox(bool? value, int index) {
    setState(() {
      if (value!) {
        _controller.subFuncionalities[index].active = 1;
      } else {
        _controller.subFuncionalities[index].active = 0;
      }
    });
  }

  void handleSalved(
    context,
  ) async {
    if (await _controller
        .updateUserSubFuncionalities(_controller.subFuncionalities)) {
      NotifyController nofity =
          NotifyController(context: context, message: 'Usuário atualizado !');

      nofity.sucess();
    } else {
      NotifyController nofity = NotifyController(
          context: context, message: 'Usuário não atualizado !');
      nofity.error();
    }
  }

  @override
  initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    changeUsersFuncionalities();
  }

  ListView _buildSubFuncionalitiesList(
      List<SubFuncionalities> subFuncionalities) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: subFuncionalities.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  subFuncionalities[index].name!,
                  style: textStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                )),
                Expanded(
                  child: Checkbox(
                    checkColor: Colors.white,
                    value: subFuncionalities[index].active == 1 ? true : false,
                    onChanged: (bool? value) => handleCheckBox(value, index),
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Text('Usuário',
                    style: textStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w700))
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network('https://picsum.photos/250?image=9'),
                ),
              ),
              const SizedBox(
                width: 32,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.user.name!),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(widget.user.email!)
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Row(
              children: [
                Text('Funcionalidades',
                    style: textStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w700))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Text('Nome',
                      style: textStyle(
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w700))),
              Expanded(
                  child: Center(
                child: Text('Status',
                    style: textStyle(
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w700)),
              )),
            ],
          ),
          const Divider(),
          Expanded(
              child: _controller.state == UserEnum.changeUser
                  ? _buildSubFuncionalitiesList(_controller.subFuncionalities)
                  : Container()),
          Row(
            children: [
              ElevatedButton(
                  style: buttonStyle,
                  onPressed: () => handleSalved(context),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('Salvar',
                        style: textStyle(
                            color: Colors.white, fontWeight: FontWeight.w700)),
                  )),
            ],
          )
        ],
      ),
    );
  }
}

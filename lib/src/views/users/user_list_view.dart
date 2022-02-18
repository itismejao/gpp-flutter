import 'package:flutter/material.dart';

import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/controllers/user_controller.dart';
import 'package:gpp/src/models/user_model.dart';

import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/components/status_component.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/shared/enumeration/user_enum.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

import 'package:gpp/src/shared/components/loading_view.dart';

class UserListView extends StatefulWidget {
  const UserListView({
    Key? key,
  }) : super(key: key);

  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  late final UsuarioController _controller;
  final ResponsiveController _responsive = ResponsiveController();
  void changeUsers() async {
    try {
      setState(() {
        _controller.state = UserEnum.loading;
      });

      await _controller.changeUser();

      setState(() {
        _controller.state = UserEnum.changeUser;
      });
    } catch (e) {
      print(e);
      // setState(() {
      //   _controller.state = UserEnum.changeUser;
      // });
    }
  }

  void handleSearch(value) {
    try {
      setState(() {
        _controller.state = UserEnum.loading;
      });

      _controller.search(value);

      setState(() {
        _controller.state = UserEnum.changeUser;
      });
    } catch (e) {
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

    //Cria instância do controller de usuários
    _controller = UsuarioController();

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
        return const LoadingComponent();

      case UserEnum.changeUser:
        return _controller.usersSearch.isEmpty
            ? _buildList(_controller.users)
            : _buildList(_controller.usersSearch);
      case UserEnum.notUser:
        // ignore: todo
        // TODO: Handle this case.
        break;
      case UserEnum.error:
        // ignore: todo
        // TODO: Handle this case.
        break;
    }
  }

  Widget _buildList(List<UsuarioModel> users) {
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
            Divider(),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: TextComponent('RE')),
                  Expanded(child: TextComponent('Nome')),
                  Expanded(child: TextComponent('Departamento')),
                  Expanded(child: TextComponent('Cargo')),
                  Expanded(child: TextComponent('Telefone')),
                  Expanded(child: TextComponent('E-mail')),
                  Expanded(child: TextComponent('Status')),
                  Expanded(child: TextComponent('Opções')),
                ],
              ),
            ),
            const Divider(),
            Container(
              height: 500,
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

    return Container(color: Colors.white, child: widget);
  }

  Widget _buildListItem(
      List<UsuarioModel> users, int index, BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (_responsive.isMobile(constraints.maxWidth)) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          users[index].name ?? '',
                          style: textStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          users[index].departament!.nome ?? '',
                          style: textStyle(color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        StatusComponent(status: users[index].active!),
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey.shade400,
                          ),
                          onPressed: () => {
                            Navigator.pushNamed(
                                context, '/users/' + users[index].id.toString())
                          },
                        ),
                      ],
                    ),
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
                    child: TextComponent(
                  users[index].uid.toString(),
                )),
                Expanded(
                    child: TextComponent(
                  users[index].name!,
                )),
                Expanded(
                    child: TextComponent(
                  users[index].departament!.nome ?? '',
                )),
                Expanded(
                    child: TextComponent(
                  "Auxiliar Administrativo",
                )),
                Expanded(
                    child: TextComponent(
                  "(62) 9999-9999",
                )),
                Expanded(
                    child: TextComponent(
                  users[index].email!,
                )),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: StatusComponent(status: users[index].active!),
                    )
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
                        onPressed: () => {
                          Navigator.pushNamed(
                              context, '/users/' + users[index].id.toString())
                        },
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TitleComponent('Usuários'),
                    ])),
            LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              if (_responsive.isMobile(constraints.maxWidth)) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 6,
                      ),
                      InputComponent(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Buscar',
                        onChanged: (value) => handleSearch(value),
                      ),
                    ],
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 6,
                    ),
                    InputComponent(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Digite o nome ou RE do usuário',
                      onChanged: (value) => handleSearch(value),
                    ),
                  ],
                ),
              );
            }),
            //  _buildFilterUsers(),
            stateManager()
          ],
        ),
      ),
    );
  }
}

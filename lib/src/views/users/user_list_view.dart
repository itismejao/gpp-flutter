import 'package:flutter/material.dart';

import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/controllers/user_controller.dart';
import 'package:gpp/src/models/user_model.dart';
import 'package:gpp/src/repositories/user_repository.dart';
import 'package:gpp/src/shared/enumeration/user_enum.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:gpp/src/views/loading_view.dart';

class UserListView extends StatefulWidget {
  const UserListView({
    Key? key,
  }) : super(key: key);

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

  void handleSearch(value) {
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

  Widget _buildList(List<UserModel> users) {
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
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text('RE',
                          style: textStyle(
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w700))),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Nome',
                            style: textStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Departamento',
                            style: textStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Cargo',
                            style: textStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Telefone',
                            style: textStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Text('E-mail',
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

    return Container(color: Colors.white, child: widget);
  }

  Widget _buildListItem(
      List<UserModel> users, int index, BuildContext context) {
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
                          users[index].departament!.name ?? '',
                          style: textStyle(color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatus(users[index].active!),
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
                    child: Text(
                  users[index].uid.toString(),
                  style: textStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                )),
                Expanded(
                  child: Text(
                    users[index].name!,
                    style: textStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                  child: Text(
                    users[index].departament!.name ?? '',
                    style: textStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Auxiliar Administrativo",
                    style: textStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                    child: Text(
                  "(62) 9999-9999",
                  style: textStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                )),
                Expanded(
                    child: Text(
                  users[index].email!,
                  style: textStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                )),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStatus(users[index].active!),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Usuários',
                          style: textStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.w700)),
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
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(5)),
                        child: TextFormField(
                          onChanged: (value) => handleSearch(value),
                          // validator: (value) => validate(value),
                          // onChanged: (value) {
                          //   widget.user!.uid = value;
                          // },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: 15, left: 20, bottom: 10, right: 20),
                              border: InputBorder.none,
                              hintText: 'Buscar',
                              prefixIcon: Icon(Icons.search)),
                        ),
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
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        onChanged: (value) => handleSearch(value),
                        // validator: (value) => validate(value),
                        // onChanged: (value) {
                        //   widget.user!.uid = value;
                        // },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: 15, left: 20, bottom: 10, right: 20),
                            border: InputBorder.none,
                            hintText: 'Buscar',
                            prefixIcon: Icon(Icons.search)),
                      ),
                    ),
                  ],
                ),
              );
            }),
            //  _buildFilterUsers(),
            Expanded(
              child: stateManager(),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/user_controller.dart';
import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/models/user_model.dart';
import 'package:gpp/src/repositories/user_repository.dart';
import 'package:gpp/src/shared/enumeration/user_enum.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  Widget build(BuildContext context) {
    return UserListView();
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

  changeUsers() async {
    setState(() {
      _controller.state = UserEnum.loading;
    });
    await _controller.changeUser();
    setState(() {
      _controller.state = UserEnum.changeUser;
    });

    print(_controller.users);
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();

    changeUsers();
  }

  _userList() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Row(
              children: [
                Expanded(
                    child: Text('Usuários',
                        style: textStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.w700))),
              ],
            ),
          ),
          LayoutBuilder(
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
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: dropDownButton(),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                            decoration: inputDecoration(
                              'Selecione o status',
                              Icon(
                                Icons.format_list_bulleted,
                              ),
                            ),
                            // value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            onChanged: (value) {
                              setState(() {
                                _controller.state = UserEnum.loading;
                              });
                              _controller.search(value!);
                              setState(() {
                                _controller.state = UserEnum.changeUser;
                              });
                            },
                            items: <String>['One', 'Two', 'Free', 'Four']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            hint: Text(
                              "Selecione o status",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            )),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
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
                )
              ],
            ),
          ),
          Divider(),
          Expanded(child: stateManager())
        ],
      ),
    );
  }

  DropdownButtonFormField<String> dropDownButton() {
    return DropdownButtonFormField<String>(
        decoration: inputDecoration(
          'Selecione o departamento',
          Icon(
            Icons.format_list_bulleted,
          ),
        ),
        // value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        onChanged: (value) {
          setState(() {
            _controller.state = UserEnum.loading;
          });
          _controller.search(value!);
          setState(() {
            _controller.state = UserEnum.changeUser;
          });
        },
        items: <String>['One', 'Two', 'Free', 'Four']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        hint: Text(
          "Selecione o departamento",
          style: TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
        ));
  }

  TextFormField inputSearch() {
    return TextFormField(
      onChanged: (value) {
        setState(() {
          _controller.state = UserEnum.loading;
        });
        _controller.search(value);
        setState(() {
          _controller.state = UserEnum.changeUser;
        });
      },
      style: textStyle(
          fontWeight: FontWeight.w700,
          color: Colors.black,
          fontSize: 14,
          height: 1.8),
      decoration: inputDecoration('Buscar', Icon(Icons.search)),
    );
  }

  stateManager() {
    switch (_controller.state) {
      case UserEnum.loading:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  color: secundaryColor,
                )),
          ],
        );

      case UserEnum.changeUser:
        return _controller.usersSearch.isEmpty
            ? _userList2(_controller.users)
            : _userList2(_controller.usersSearch);
    }
  }

  ListView _userList2(List<UserModel> users) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
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
                        SizedBox(
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
                  style: textStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                )),
                Expanded(
                    child: Text(
                  'Colocar departamento',
                  style: textStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                )),
                Expanded(
                    child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      color: users[index].active == "1"
                          ? secundaryColor
                          : Colors.grey.shade400,
                      shape: BoxShape.circle),
                ))
              ],
            ),
          );
        });
  }

  // stateManager() {
  //   switch (_controller.state) {
  //     case UserEnum.loading:
  //       return Text('Carregando');
  //     case UserEnum.changeUser:
  //       return _userList();
  //     default:
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _userList(),
    );
  }
}

class UserDetail extends StatefulWidget {
  UserModel user;

  UserDetail({Key? key, required this.user}) : super(key: key);

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
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

  @override
  initState() {
    // TODO: implement initState
    super.initState();

    changeUsersFuncionalities();
  }

  ListView _subFuncionalitiesList(List<SubFuncionalities> subFuncionalities) {
    return ListView.builder(
        itemCount: subFuncionalities.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  subFuncionalities[index].name,
                  style: textStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                )),
                Expanded(
                  child: Checkbox(
                    checkColor: Colors.white,
                    value: subFuncionalities[index].active == 1 ? true : false,
                    onChanged: (bool? value) {
                      setState(() {
                        subFuncionalities[index].active = 1;
                      });
                    },
                  ),
                )
                // Expanded(
                //     child: Container(
                //   height: 10,
                //   width: 10,
                //   decoration: BoxDecoration(
                //       color: subFuncionalities[index].active == "1"
                //           ? secundaryColor
                //           : Colors.grey.shade400,
                //       shape: BoxShape.circle),
                // ))
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
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
                SizedBox(
                  width: 32,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nome'),
                    SizedBox(
                      height: 12,
                    ),
                    Text('Tecnologia da Informação')
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
            Expanded(
                child: _controller.state == UserEnum.changeUser
                    ? _subFuncionalitiesList(_controller.subFuncionalities)
                    : Container()),
            Row(
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        primary: primaryColor),
                    onPressed: () async {
                      setState(() {
                        _controller.updateUserSubFuncionalities(
                            _controller.subFuncionalities);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('Salvar',
                          style: textStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700)),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}

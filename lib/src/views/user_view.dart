import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/user_controller.dart';
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
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text('Usuarios',
                      style: textStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w700))),
            ],
          ),
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: DropdownButton<String>(
                    // value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        //  dropdownValue = newValue!;
                      });
                    },
                    items: <String>['One', 'Two', 'Free', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: DropdownButton(
                      items: <String>['One', 'Two', 'Free', 'Four']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {}),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
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
          Expanded(
            child: ListView.builder(
                itemCount: _controller.users.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
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
                              _controller.users[index].name!,
                              style: textStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        )),
                        Expanded(
                            child: Text(
                          _controller.users[index].uid!,
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
                              color: _controller.users[index].active == "1"
                                  ? secundaryColor
                                  : Colors.grey.shade400,
                              shape: BoxShape.circle),
                        ))
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  stateManager() {
    switch (_controller.state) {
      case UserEnum.loading:
        return Text('Carregando');
      case UserEnum.changeUser:
        return _userList();
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: stateManager(),
    );
  }
}

class UserDetail extends StatefulWidget {
  const UserDetail({Key? key}) : super(key: key);

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

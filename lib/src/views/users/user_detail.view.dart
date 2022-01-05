import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/user_controller.dart';
import 'package:gpp/src/models/subfuncionalities_model.dart';
import 'package:gpp/src/models/user_model.dart';
import 'package:gpp/src/repositories/user_repository.dart';
import 'package:gpp/src/shared/enumeration/user_enum.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

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
        _controller.subFuncionalities[index].active = true;
      } else {
        _controller.subFuncionalities[index].active = false;
      }
    });
  }

  void handleSalved(
    context,
  ) async {
    NotifyController nofity = NotifyController(context: context);
    if (await _controller
        .updateUserSubFuncionalities(_controller.subFuncionalities)) {
      nofity.sucess("Usuário atualizado !");
    } else {
      nofity.error("Usuário não atualizado !");
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
      List<SubFuncionalitiesModel> subFuncionalities) {
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
                  child: Image.network(
                      'https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/female/68.png'),
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
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Nome',
                          style: textStyle(
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w700)),
                    ],
                  )),
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

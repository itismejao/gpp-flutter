import 'package:flutter/material.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(children: [
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Usuários',
                        style: textStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.w700)),
                  ])),

          // Expanded(child: UserListView()),

          //Expanded(child: DepartamentFormView()),
        ]));
  }
}

import 'package:flutter/material.dart';

import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/controllers/UserController.dart';
import 'package:gpp/src/models/user_model.dart';

import 'package:gpp/src/shared/components/InputComponent.dart';
import 'package:gpp/src/shared/components/status_component.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/shared/enumeration/user_enum.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/views/widgets/card_widget.dart';

class UsuarioListView extends StatefulWidget {
  const UsuarioListView({
    Key? key,
  }) : super(key: key);

  @override
  _UsuarioListViewState createState() => _UsuarioListViewState();
}

class _UsuarioListViewState extends State<UsuarioListView> {
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
        return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: CardWidget(
                    widget: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: TextComponent(
                          'Código do usuário',
                          fontWeight: FontWeight.bold,
                        )),
                        Expanded(
                            child: TextComponent('RE',
                                fontWeight: FontWeight.bold)),
                        Expanded(
                            child: TextComponent('Nome',
                                fontWeight: FontWeight.bold)),
                        Expanded(
                            flex: 2,
                            child: TextComponent('E-mail',
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: TextComponent(
                          '#${users[index].id.toString()}',
                        )),
                        Expanded(
                            child: TextComponent(
                          users[index].uid.toString(),
                        )),
                        Expanded(
                            child: TextComponent(
                          users[index].nome!,
                        )),
                        Expanded(
                            flex: 2,
                            child: TextComponent(
                              users[index].email!,
                            )),
                      ],
                    ),
                  ],
                )),
              );
            });
      },
    );

    return Container(color: Colors.white, child: widget);
  }

  // Widget _buildListItem(
  //     List<UsuarioModel> users, int index, BuildContext context) {
  //   return LayoutBuilder(
  //     builder: (context, constraints) {
  //       if (_responsive.isMobile(constraints.maxWidth)) {
  //         return Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Container(
  //             decoration: BoxDecoration(
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.grey.withOpacity(0.5),
  //                   spreadRadius: 5,
  //                   blurRadius: 7,
  //                   offset: Offset(0, 3), // changes position of shadow
  //                 ),
  //               ],
  //               color: Colors.white,
  //               borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(10),
  //                   topRight: Radius.circular(10),
  //                   bottomLeft: Radius.circular(10),
  //                   bottomRight: Radius.circular(10)),
  //             ),
  //             child: Padding(
  //               padding: const EdgeInsets.all(12.0),
  //               child: Column(
  //                 children: [
  //                   Row(
  //                     children: [
  //                       Text(
  //                         users[index].nome ?? '',
  //                         style: textStyle(fontWeight: FontWeight.bold),
  //                       ),
  //                     ],
  //                   ),
  //                   Row(
  //                     children: [
  //                       Text(
  //                         users[index].departament!.nome ?? '',
  //                         style: textStyle(color: Colors.grey.shade400),
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: 12,
  //                   ),
  //                   Row(
  //                     children: [
  //                       StatusComponent(status: users[index].active!),
  //                       IconButton(
  //                         icon: Icon(
  //                           Icons.edit,
  //                           color: Colors.grey.shade400,
  //                         ),
  //                         onPressed: () => {
  //                           Navigator.pushNamed(
  //                               context, '/users/' + users[index].id.toString())
  //                         },
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       }

  //       return Container(
  //         color: (index % 2) == 0 ? Colors.white : Colors.grey.shade50,
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
  //           child:
  //         ),
  //       );
  //     },
  //   );
  // }

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
                      Expanded(
                        flex: 2,
                        child: TitleComponent('Usuários'),
                      ),
                      Expanded(
                        child: InputComponent(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Digite o nome ou RE do usuário',
                          onChanged: (value) => handleSearch(value),
                        ),
                      )
                    ])),

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

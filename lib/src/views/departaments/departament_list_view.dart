import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/departament_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/models/departament_model.dart';
import 'package:gpp/src/repositories/departament_repository.dart';
import 'package:gpp/src/shared/enumeration/departament_enum.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:gpp/src/views/departaments/departament_form_view.dart';
import 'package:gpp/src/views/loading_view.dart';

class DepartamentListView extends StatefulWidget {
  const DepartamentListView({Key? key}) : super(key: key);

  @override
  _DepartamentListViewState createState() => _DepartamentListViewState();
}

class _DepartamentListViewState extends State<DepartamentListView> {
  final ResponsiveController _responsive = ResponsiveController();

  late final DepartamentController _controller =
      DepartamentController(DepartamentRepository(api: gppApi));

  changeDepartaments() async {
    if (mounted) {
      setState(() {
        _controller.state = DepartamentEnum.loading;
      });
    }
    await _controller.fetchAll();
    if (mounted) {
      setState(() {
        _controller.state = DepartamentEnum.changeDepartament;
      });
    }
  }

  handleCreate(context) async {
    bool? isCreate = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(actions: <Widget>[DepartamentFormView()]);
        });

    if (isCreate != null && isCreate) {
      changeDepartaments();
    }
  }

  handleEdit(context, DepartamentModel departament) async {
    // bool? isEdit = await showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(actions: <Widget>[
    //         DepartamentFormView(
    //           departament: departament,
    //         )
    //       ]);
    //     });

    // if (isEdit != null && isEdit) {
    //   changeDepartaments();
    // }
  }

  handleDelete(context, DepartamentModel departament) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await notify.alert("você deseja excluir essa funcionalidade?")) {
        if (await _controller.delete(departament)) {
          notify.sucess("Funcionalidade excluída!");
          changeDepartaments();
        }
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  @override
  initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    changeDepartaments();
  }

  Widget _buildList(List<DepartamentModel> departaments) {
    Widget widget = LayoutBuilder(
      builder: (context, constraints) {
        if (_responsive.isMobile(constraints.maxWidth)) {
          return ListView.builder(
              itemCount: departaments.length,
              itemBuilder: (context, index) {
                return _buildListItem(departaments, index, context);
              });
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
              Expanded(
                child: ListView.builder(
                    itemCount: departaments.length,
                    itemBuilder: (context, index) {
                      return _buildListItem(departaments, index, context);
                    }),
              )
            ],
          ),
        );
      },
    );

    return Container(color: Colors.white, child: widget);
  }

  Widget _buildListItem(
      List<DepartamentModel> departament, int index, BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (_responsive.isMobile(constraints.maxWidth)) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          departament[index].name ?? '',
                          style: textStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatus(departament[index].active!),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.grey.shade400,
                              ),
                              onPressed: () => {
                                Navigator.pushNamed(
                                    context,
                                    '/departaments/' +
                                        departament[index].id.toString())

                                //  handleEdit(context, departament[index]),
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.grey.shade400,
                              ),
                              onPressed: () =>
                                  handleDelete(context, departament[index]),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider()
                  ],
                ),
              ),
            ),
          );
        }
        // if (_responsive.isMobile(constraints.maxWidth)) {
        //   return Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 8.0),
        //     child: Container(
        //       decoration: BoxDecoration(
        //           border: Border(
        //               left: BorderSide(
        //                   color: departament[index].active == "1"
        //                       ? secundaryColor
        //                       : Colors.grey.shade400,
        //                   width: 4))),
        //       child: Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //         child: Column(
        //           children: [
        //             Row(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 SizedBox(
        //                     height: 50,
        //                     width: 50,
        //                     child: ClipRRect(
        //                       borderRadius: BorderRadius.circular(10),
        //                       child: Image.network(
        //                           'https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/female/68.png'),
        //                     )),
        //                 const SizedBox(
        //                   width: 12,
        //                 ),
        //                 Column(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Text(
        //                       departament[index].name!,
        //                       style: textStyle(
        //                           color: Colors.black,
        //                           fontWeight: FontWeight.w700),
        //                     ),
        //                     const SizedBox(
        //                       height: 6,
        //                     ),
        //                   ],
        //                 )
        //               ],
        //             ),
        //             const SizedBox(
        //               height: 12,
        //             ),
        //             Row(
        //               children: [
        //                 IconButton(
        //                   icon: Icon(
        //                     Icons.edit,
        //                     color: Colors.blue,
        //                   ),
        //                   onPressed: () =>
        //                       handleEdit(context, departament[index]),
        //                 ),
        //                 IconButton(
        //                   icon: Icon(
        //                     Icons.delete,
        //                     color: Colors.grey.shade400,
        //                   ),
        //                   onPressed: () =>
        //                       handleDelete(context, departament[index]),
        //                 ),
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   );
        // }

        return Container(
          color: (index % 2) == 0 ? Colors.white : Colors.grey.shade50,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    departament[index].name!,
                    style: textStyle(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStatus(departament[index].active!),
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
                          onPressed: () {
                            Navigator.pushNamed(
                                context,
                                '/departaments/' +
                                    departament[index].id.toString());
                          }
                          //handleEdit(context, departament[index]),
                          ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.grey.shade400,
                        ),
                        onPressed: () =>
                            handleDelete(context, departament[index]),
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

  Widget _buildDepartaments() {
    switch (_controller.state) {
      case DepartamentEnum.loading:
        return const LoadingView();
      case DepartamentEnum.notDepartament:
        return Container();
      case DepartamentEnum.changeDepartament:
        return _buildList(_controller.departaments);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Departamentos',
                    style: textStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700)),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/departamento/register');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: secundaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, left: 25, bottom: 15, right: 25),
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),

                // ButtonPrimaryComponent(
                //     onPressed: () => handleCreate(context), text: "Cadastrar")
              ],
            ),
          ),
          Expanded(child: _buildDepartaments())

          // _buildFilterUsers(),
          // Expanded(
          //   child: stateManager(),
          // )
        ],
      ),
    );
  }
}

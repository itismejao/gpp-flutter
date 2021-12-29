import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/departament_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/models/departament_model.dart';
import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/repositories/departament_repository.dart';
import 'package:gpp/src/shared/enumeration/departament_enum.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:gpp/src/views/loading_view.dart';

class DepartamentView extends StatefulWidget {
  const DepartamentView({Key? key}) : super(key: key);

  @override
  _DepartamentViewState createState() => _DepartamentViewState();
}

class _DepartamentViewState extends State<DepartamentView> {
  @override
  Widget build(BuildContext context) {
    return const DepartamentListView();
  }
}

class DepartamentListView extends StatefulWidget {
  const DepartamentListView({Key? key}) : super(key: key);

  @override
  _DepartamentListViewState createState() => _DepartamentListViewState();
}

class _DepartamentListViewState extends State<DepartamentListView> {
  final ResponsiveController _responsive = ResponsiveController();

  late final DepartamentController _controller =
      DepartamentController(repository: DepartamentRepository(api: gppApi));

  changeDepartaments() async {
    setState(() {
      _controller.state = DepartamentEnum.loading;
    });
    await _controller.changeDepartament();
    setState(() {
      _controller.state = DepartamentEnum.changeDepartament;
    });
  }

  @override
  initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    changeDepartaments();
  }

  Widget _buildDepartamentList(List<DepartamentModel> departaments) {
    Widget widget = LayoutBuilder(
      builder: (context, constraints) {
        if (_responsive.isMobile(constraints.maxWidth)) {
          return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const Text('test');
                //return _buildListItem(departament, index, context);
              });
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
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
                  itemCount: departaments.length,
                  itemBuilder: (context, index) {
                    return _buildListItem(departaments, index, context);
                  }),
            )
          ],
        );
      },
    );

    return widget;
  }

  Widget _buildListItem(
      List<DepartamentModel> departaments, int index, BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (_responsive.isMobile(constraints.maxWidth)) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          color: departaments[index].active == "1"
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
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //       departaments[index].description!,
                        //       style: textStyle(
                        //           color: Colors.black,
                        //           fontWeight: FontWeight.w700),
                        //     ),
                        //     const SizedBox(
                        //       height: 6,
                        //     ),
                        //     departaments[index].departement != null
                        //         ? Text(
                        //             departaments[index].departement!,
                        //             style: textStyle(
                        //                 color: Colors.grey.shade400,
                        //                 fontWeight: FontWeight.w700),
                        //           )
                        //         : Text('',
                        //             style: textStyle(
                        //                 color: Colors.black,
                        //                 fontWeight: FontWeight.w700))
                        //   ],
                        // )
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
                                  Navigator.pushNamed(
                                      context, '/departament_detail',
                                      arguments: departaments[index])
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
                        departaments[index].description,
                        style: textStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                    ],
                  )),
              Expanded(
                  child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    color: departaments[index].active == "1"
                        ? secundaryColor
                        : Colors.grey.shade400,
                    shape: BoxShape.circle),
              )),
              Expanded(
                child: ElevatedButton(
                    style: buttonStyle,
                    onPressed: () => {
                          Navigator.pushNamed(context, '/departament_detail',
                              arguments: departaments[index])
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

  Widget _buildDepartaments() {
    switch (_controller.state) {
      case DepartamentEnum.loading:
        return const LoadingView();
      case DepartamentEnum.notDepartament:
        return Container();
      case DepartamentEnum.changeDepartament:
        return _buildDepartamentList(_controller.departaments);
    }
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
                    child: Text('Departamentos',
                        style: textStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w700))),
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

class DepartamentDetailView extends StatefulWidget {
  //DepartamentModel departament;

  const DepartamentDetailView({Key? key}) : super(key: key);

  @override
  _DepartamentDetailViewState createState() => _DepartamentDetailViewState();
}

class _DepartamentDetailViewState extends State<DepartamentDetailView> {
  late final DepartamentController _controller =
      DepartamentController(repository: DepartamentRepository(api: gppApi));

  changeDepartamentFuncionalities() async {
    setState(() {
      _controller.state = DepartamentEnum.loading;
    });
    await _controller.changeDepartamentSubFuncionalities(DepartamentModel(
        id: "1",
        description: "",
        active: "",
        iduserresp: "",
        createdAt: "",
        updatedAt: ""));
    setState(() {
      _controller.state = DepartamentEnum.changeDepartament;
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
    if (await _controller.updateUserSubFuncionalities(
        DepartamentModel(
            id: "1",
            description: "",
            active: "",
            iduserresp: "",
            createdAt: "",
            updatedAt: ""),
        _controller.subFuncionalities)) {
      NotifyController nofity = NotifyController(
          context: context, message: 'Departamento atualizado !');

      nofity.sucess();
    } else {
      NotifyController nofity = NotifyController(
          context: context, message: 'Departamento não atualizado !');
      nofity.error();
    }
  }

  @override
  initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    changeDepartamentFuncionalities();
  }

  ListView _buildSubFuncionalitiesList(
      List<SubFuncionalities> subFuncionalities) {
    return ListView.builder(
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Text('Departamento',
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
                  children: const [
                    // Text(widget.user.name!),
                    // const SizedBox(
                    //   height: 12,
                    // ),
                    // Text(widget.user.email!)
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
                child: _controller.state == DepartamentEnum.changeDepartament
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

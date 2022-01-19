import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/funcionalities_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/shared/enumeration/funcionalities_enum.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/components/loading_view.dart';

class FuncionalitiesListView extends StatefulWidget {
  const FuncionalitiesListView({Key? key}) : super(key: key);

  @override
  _FuncionalitiesListViewState createState() => _FuncionalitiesListViewState();
}

class _FuncionalitiesListViewState extends State<FuncionalitiesListView> {
  FuncionalitiesController _controlller = FuncionalitiesController();
  final ResponsiveController _responsive = ResponsiveController();

  fetchFuncionalities() async {
    setState(() {
      _controlller.state = FuncionalitiesEnum.loading;
    });

    await _controlller.fetchAll();

    setState(() {
      _controlller.state = FuncionalitiesEnum.change;
    });
  }

  handleDelete(context, FuncionalitieModel funcionalitie) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await notify.alert("você deseja excluir essa funcionalidade?")) {
        if (await _controlller.delete(funcionalitie)) {
          notify.sucess("Funcionalidade excluída!");
          fetchFuncionalities();
        }
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    fetchFuncionalities();
  }

  Widget _buildList(List<FuncionalitieModel> funcionalities) {
    Widget widget = LayoutBuilder(
      builder: (context, constraints) {
        if (_responsive.isMobile(constraints.maxWidth)) {
          return ListView.builder(
              itemCount: funcionalities.length,
              itemBuilder: (context, index) {
                return _buildListItem(funcionalities, index, context);
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
                    flex: 2,
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
                  itemCount: funcionalities.length,
                  itemBuilder: (context, index) {
                    return _buildListItem(funcionalities, index, context);
                  }),
            )
          ],
        );
      },
    );

    return Container(color: Colors.white, child: widget);
  }

  Widget _buildListItem(List<FuncionalitieModel> funcionalities, int index,
      BuildContext context) {
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
                          funcionalities[index].name ?? '',
                          style: textStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          funcionalities[index].name ?? '',
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
                        _buildStatus(funcionalities[index].active!),
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey.shade400,
                          ),
                          onPressed: () => {print("teste")},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  funcionalities[index].name!,
                  style: textStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 60,
                    child: _buildStatus(funcionalities[index].active!),
                  ),
                ],
              )),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.grey.shade400,
                      ),
                      onPressed: () => {
                        Navigator.pushReplacementNamed(
                            context,
                            '/subfuncionalities/' +
                                funcionalities[index].id.toString())
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.grey.shade400,
                      ),
                      onPressed: () => {
                        Navigator.pushReplacementNamed(
                            context,
                            '/funcionalities/' +
                                funcionalities[index].id.toString())
                      },
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.grey.shade400,
                        ),
                        onPressed: () =>
                            handleDelete(context, funcionalities[index])),
                    IconButton(
                        icon: Icon(
                          Icons.list,
                          color: Colors.grey.shade400,
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context,
                              '/funcionalities/' +
                                  funcionalities[index].id.toString());
                        }),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _buildState() {
    switch (_controlller.state) {
      case FuncionalitiesEnum.loading:
        return const LoadingComponent();

      case FuncionalitiesEnum.change:
        return _buildList(_controlller.funcionalities);
      case FuncionalitiesEnum.notChange:
        return;
    }
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Funcionalidades',
                  style: textStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        primary: secundaryColor),
                    onPressed: () {
                      Navigator.pushNamed(context, '/funcionalities/register');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('Cadastrar',
                          style: textStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700)),
                    ))
              ],
            ),
          ),
          Expanded(
            child: _buildState(),
          )
        ],
      ),
    );
  }
}

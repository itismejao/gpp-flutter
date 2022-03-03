import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/AutenticacaoController.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';

import 'package:gpp/src/shared/services/auth.dart';
import 'package:gpp/src/shared/utils/Usuario.dart';
import 'package:shimmer/shimmer.dart';

import 'package:gpp/src/controllers/user_controller.dart';
import 'package:gpp/src/models/FuncionalidadeModel.dart';
import 'package:gpp/src/models/subfuncionalities_model.dart';

import 'package:gpp/src/shared/enumeration/user_enum.dart';

// ignore: must_be_immutable
class FuncionalitiesView extends StatefulWidget {
  const FuncionalitiesView({
    Key? key,
  }) : super(key: key);

  @override
  _FuncionalitiesViewState createState() => _FuncionalitiesViewState();
}

class _FuncionalitiesViewState extends State<FuncionalitiesView> {
  late final UsuarioController controller;
  late AutenticacaoController autenticacaoController;

  handleSearchFuncionalities(value) {
    setState(() {
      controller.state = UserEnum.loading;
    });

    controller.searchFuncionalities(value);

    setState(() {
      controller.state = UserEnum.changeUser;
    });
  }

  buscarFuncionalidades() async {
    NotifyController nofity = NotifyController(context: context);
    if (mounted) {
      setState(() {
        controller.state = UserEnum.loading;
      });
    }
    try {
      await controller.changeFuncionalities();
    } catch (e) {
      //nofity.error(e.toString());
      setState(() {
        controller.state = UserEnum.error;
      });
    }
    if (mounted) {
      setState(() {
        controller.state = UserEnum.changeUser;
      });
    }
  }

  buscaUsuarioAutenticado() async {
    try {
      setState(() {
        autenticacaoController.carregado = false;
      });
      await autenticacaoController.repository.buscar();
      setState(() {
        autenticacaoController.carregado = true;
      });
    } catch (e) {
      //print(e);
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    //Cria instância do controller de usuários
    controller = UsuarioController();

    buscarFuncionalidades();

    //Inicializa o controller
    autenticacaoController = AutenticacaoController();

    //buscar o usuário
    buscaUsuarioAutenticado();
  }

  funcionalities(MediaQueryData mediaQuery, context) {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        Expanded(
          child: controller.state == UserEnum.changeUser
              ? controller.funcionalitiesSearch.isEmpty
                  ? _buildListFuncionalities(
                      controller.funcionalities, mediaQuery, context)
                  : _buildListFuncionalities(
                      controller.funcionalitiesSearch, mediaQuery, context)
              : const ShimmerWidget(),
        ),
      ],
    );
  }

  _buildListFuncionalities(List<FuncionalidadeModel> funcionalities,
      MediaQueryData mediaQuery, context) {
    return ListView.builder(
      itemCount: funcionalities.length,
      itemBuilder: (context, index1) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            setState(() {
              funcionalities[index1].isExpanded =
                  !funcionalities[index1].isExpanded!;
            });
          },
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(IconData(
                              int.parse(funcionalities[index1].icone!),
                              fontFamily: 'MaterialIcons')),
                          SizedBox(
                            width: 6,
                          ),
                          TextComponent(
                            StringUtils.capitalize(
                                funcionalities[index1].nome!),
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      funcionalities[index1].isExpanded!
                          ? const Icon(Icons.expand_more)
                          : const Icon(Icons.expand_less)
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: AnimatedSize(
                        curve: Curves.fastOutSlowIn,
                        duration: const Duration(milliseconds: 500),
                        child: SizedBox(
                            height:
                                !funcionalities[index1].isExpanded! ? 0 : null,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: funcionalities[index1]
                                    .subFuncionalidades!
                                    .map((subFuncionalities) {
                                  return _buildListSubFuncionalities(
                                      subFuncionalities, mediaQuery, context);
                                }).toList())),
                      ),
                    ),
                  ],
                ),
              ]),
        );
      },
    );
  }

  Widget _buildListSubFuncionalities(SubFuncionalidadeModel subFuncionalities,
      MediaQueryData mediaQuery, context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, subFuncionalities.rota!);
                //Fecha Drawer
              },
              child: MouseRegion(
                onHover: (event) {
                  setState(() {
                    subFuncionalities.boxDecoration = BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey.shade50);
                  });
                },
                onExit: (event) {
                  setState(() {
                    subFuncionalities.boxDecoration = null;
                  });
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: subFuncionalities.boxDecoration,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 28),
                            child: TextComponent(
                                subFuncionalities.nome.toString()),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }

  stateManagement(MediaQueryData mediaQuery, context) {
    switch (controller.state) {
      case UserEnum.error:
        return Container(
          child: Text("Não foi encontrado funcionalidades"),
        );
      case UserEnum.loading:
        return const ShimmerWidget();

      case UserEnum.changeUser:
        return funcionalities(mediaQuery, context);
      default:
    }
  }

  handleLogout(context) {
    logout();
    Navigator.pushReplacementNamed(context, '/logout');
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(flex: 3, child: stateManagement(mediaQuery, context)),
          Container(
            color: Colors.grey.shade50,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: autenticacaoController.carregado
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextComponent(
                          'Olá, ' +
                              usuario.nome!.split(" ").first +
                              ' ' +
                              usuario.nome!.split(" ").last,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        GestureDetector(
                          onTap: () {
                            handleLogout(context);
                          },
                          child: const Icon(
                            Icons.logout,
                            //The color which you want set.
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ),
          )
        ],
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double containerWidth = mediaQuery.size.width * 0.12;
    double containerHeight = 10.0;
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      itemCount: 15,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: mediaQuery.size.height * 0.02,
                  width: mediaQuery.size.width * 0.03,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: containerHeight,
                      width: containerWidth,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

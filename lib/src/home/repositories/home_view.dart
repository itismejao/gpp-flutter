import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gpp/src/shared/components/components.dart';

import 'package:gpp/src/shared/controllers/funcionalities_controller.dart';
import 'package:gpp/src/shared/exceptions/funcionalities_exception.dart';
import 'package:gpp/src/shared/models/funcionalitie_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpp/src/shared/repositories/error.dart';
import 'package:gpp/src/shared/repositories/global.dart';
import 'package:gpp/src/shared/repositories/navigator_routes.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:collection/collection.dart';
import 'package:gpp/src/shared/services/auth.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // ignore: prefer_final_fields
  List<bool> _isOpen = [];
  late Future<List<FuncionalitieModel>> funcionalities;

  expansionCallback(i, isOpen) {
    // ignore: avoid_print
    print(i);
    setState(() {
      _isOpen[i] = !isOpen;
    });
  }

  Future<List<FuncionalitieModel>> getFunctionalities() async {
    // print(authenticate!.email);

    try {
      FuncionalitiesController funcionalitiesController =
          FuncionalitiesController();

      List<FuncionalitieModel> funcionalities = await funcionalitiesController
          .getFuncionalities(authenticateUser!.id);

      //gera lista
      _isOpen = List.filled(funcionalities.length, false);

      return funcionalities;
    } on FuncionalitiesException catch (funcionatiliesException) {
      showError(context, funcionatiliesException.message);
      rethrow;
    } on TimeoutException catch (timeOutException) {
      showError(context, timeOutException.message);
      rethrow;
    }
  }

  handleLogout() {
    //Limpa o token
    logout();

    NavigatorRoutes.pushNamed(context, '/login');
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    //Inicializa as funcionalidades
    funcionalities = getFunctionalities();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    Widget homePage;

    homePage = ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('GPP'),
              backgroundColor: primaryColor,
            ),
            drawer: Drawer(
              child: Container(
                  color: Colors.white,
                  height: mediaQuery.size.height,
                  child: menu(mediaQuery)),
            ),
            body: Material(
                child: Container(
                    color: backgroundColor,
                    child: Center(child: const Text('Página principal')))),
          );
        }

        return Scaffold(
          body: Material(
            child: Container(
                color: backgroundColor,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                            height: mediaQuery.size.height,
                            width: mediaQuery.size.width * 0.20,
                            color: Colors.white,
                            child: menu(mediaQuery)),
                      ],
                    ),
                  ],
                )),
          ),
        );
      },
    );

    return homePage;
  }

  Column menu(MediaQueryData mediaQuery) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                color: primaryColor,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        '../../../lib/src/shared/assets/logo.svg',
                        color: Colors.white,
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text('GPP',
                          style: textStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700)),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => handleLogout(),
                        child: SvgPicture.asset(
                          '../../../lib/src/shared/assets/logout.svg',
                          color: Colors.white,
                          width: 30,
                          height: 30,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: funcionalities,
                  builder: (context,
                      AsyncSnapshot<List<FuncionalitieModel>> snapshot) {
                    if (snapshot.hasError) {
                      // ignore: avoid_print
                      return Container();
                    }

                    if (snapshot.hasData) {
                      return ExpansionPanelList(
                          expandedHeaderPadding: const EdgeInsets.all(0),
                          elevation: 0,
                          expansionCallback: (index, isOpen) =>
                              expansionCallback(index, isOpen),
                          children: snapshot.data!
                              .mapIndexed((index, funcionalities) {
                            return ExpansionPanel(
                                canTapOnHeader: true,
                                headerBuilder:
                                    (BuildContext context, bool isExpanded) {
                                  return ListTile(
                                    title: Text(
                                      funcionalities.name,
                                      style: textStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12,
                                          height: 1.8),
                                    ),
                                  );
                                },
                                body: Container(
                                  color: backgroundColor,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: Column(
                                      children: funcionalities.subFuncionalities
                                          .map((subFuncionalities) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () =>
                                                NavigatorRoutes.pushNamed(
                                                    context,
                                                    subFuncionalities.route),
                                            child: Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      '../../../lib/src/shared/assets/user.svg',
                                                      color: Colors.black,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                Text(
                                                  subFuncionalities.name,
                                                  style: textStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 12,
                                                      height: 1.8),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                isExpanded: _isOpen[index]);
                          }).toList());
                    }

                    return loadingListLayout(7);
                  }),
            )
          ],
        ),
        const Spacer(),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [versionComponent()],
        )
      ],
    );
  }

  SizedBox loadingListLayout(count) {
    return SizedBox(
      child: Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.white,
          child: Column(
            children: [
              for (var i = 0; i < count; i++)
                Container(
                  margin: const EdgeInsets.all(8),
                  color: backgroundColor,
                  height: 50,
                ),
            ],
          )),
    );
  }
}

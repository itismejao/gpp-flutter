import 'package:flutter/material.dart';

import 'package:gpp/src/shared/controllers/funcionalities_controller.dart';
import 'package:gpp/src/shared/models/funcionalitie_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:collection/collection.dart';
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

    FuncionalitiesController funcionalitiesController =
        FuncionalitiesController();

    List<FuncionalitieModel> funcionalities =
        await funcionalitiesController.getFuncionalities(1);

    //gera lista
    _isOpen = List.filled(funcionalities.length, false);

    // ignore: avoid_print
    print(_isOpen);
    // ignore: avoid_print
    print(funcionalities[0].name);

    return funcionalities;
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

    return Container(
        color: backgroundColor,
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  height: mediaQuery.size.height,
                  width: mediaQuery.size.width * 0.20,
                  color: Colors.white,
                  child: Column(
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
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          '../../../lib/src/shared/assets/logo.svg',
                                          color: Colors.white,
                                          width: 30,
                                          height: 30,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('GPP',
                                            style: textStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700))
                                      ],
                                    ),
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
                                    AsyncSnapshot<List<FuncionalitieModel>>
                                        snapshot) {
                                  if (snapshot.hasData) {
                                    return ExpansionPanelList(
                                        elevation: 0,
                                        expansionCallback: (index, isOpen) =>
                                            expansionCallback(index, isOpen),
                                        children: snapshot.data!.mapIndexed(
                                            (index, funcionalities) {
                                          return ExpansionPanel(
                                              headerBuilder:
                                                  (BuildContext context,
                                                      bool isExpanded) {
                                                return ListTile(
                                                  title: Text(
                                                    funcionalities.name,
                                                    style: textStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                );
                                              },
                                              body: Container(
                                                color: backgroundColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 16.0),
                                                  child: Column(
                                                    children: funcionalities
                                                        .subFuncionalities
                                                        .map(
                                                            (subFuncionalities) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                  '../../../lib/src/shared/assets/user.svg',
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            Column(
                                                              children: [
                                                                Text(
                                                                  subFuncionalities
                                                                      .name,
                                                                  style: textStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                )
                                                              ],
                                                            )
                                                          ],
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
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Versão 1.0.0',
                              style: textStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
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

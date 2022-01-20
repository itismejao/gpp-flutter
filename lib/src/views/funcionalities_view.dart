import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:shimmer/shimmer.dart';

import 'package:gpp/src/controllers/user_controller.dart';
import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/models/subfuncionalities_model.dart';
import 'package:gpp/src/repositories/user_repository.dart';
import 'package:gpp/src/shared/enumeration/user_enum.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
// ignore: unused_import
import 'package:gpp/src/views/home_view.dart';

// ignore: must_be_immutable
class FuncionalitiesView extends StatefulWidget {
  FuncionalitiesView({
    Key? key,
  }) : super(key: key);

  @override
  _FuncionalitiesViewState createState() => _FuncionalitiesViewState();
}

class _FuncionalitiesViewState extends State<FuncionalitiesView> {
  late final UserController _controller =
      UserController(repository: UserRepository(api: gppApi));

  final ScrollController controller = ScrollController();

  handleSearchFuncionalities(value) {
    setState(() {
      _controller.state = UserEnum.loading;
    });

    _controller.searchFuncionalities(value);

    setState(() {
      _controller.state = UserEnum.changeUser;
    });
  }

  changeUserFuncionalities() async {
    NotifyController nofity = NotifyController(context: context);
    if (mounted) {
      setState(() {
        _controller.state = UserEnum.loading;
      });
    }
    try {
      await _controller.changeFuncionalities();
    } catch (e) {
      nofity.error(e.toString());
      setState(() {
        _controller.state = UserEnum.error;
      });
    }
    if (mounted) {
      setState(() {
        _controller.state = UserEnum.changeUser;
      });
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    changeUserFuncionalities();
  }

  SizedBox loadingLayout(count) {
    return SizedBox(
      child: Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.white,
          child: Column(
            children: [
              for (var i = 0; i < count; i++)
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      color: backgroundColor,
                      height: 50,
                    ),
                  ],
                ),
            ],
          )),
    );
  }

  funcionalities(MediaQueryData mediaQuery, context) {
    return Column(
      children: [
        // Row(
        //   children: [
        //     // Expanded(
        //     //   child: Padding(
        //     //     padding: const EdgeInsets.all(8.0),
        //     //     child: SizedBox(
        //     //       child: Form(
        //     //           child: TextFormField(
        //     //               onChanged: (value) =>
        //     //                   handleSearchFuncionalities(value),
        //     //               style: const TextStyle(
        //     //                   color: Colors.black,
        //     //                   fontStyle: FontStyle.normal,
        //     //                   fontWeight: FontWeight.w700,
        //     //                   height: 1.8,
        //     //                   fontSize: 14),
        //     //               decoration: inputDecoration(
        //     //                   'Buscar', const Icon(Icons.search)))),
        //     //     ),
        //     //   ),
        //     // ),
        //   ],
        // ),
        // const Padding(
        //   padding: EdgeInsets.all(8.0),
        //   child: Divider(),
        // ),
        const SizedBox(
          height: 12,
        ),
        Expanded(
          child: _controller.state == UserEnum.changeUser
              ? _controller.funcionalitiesSearch.isEmpty
                  ? _buildListFuncionalities(
                      _controller.funcionalities, mediaQuery, context)
                  : _buildListFuncionalities(
                      _controller.funcionalitiesSearch, mediaQuery, context)
              : const ShimmerWidget(),
        ),
      ],
    );
  }

  _buildListFuncionalities(List<FuncionalitieModel> funcionalities,
      MediaQueryData mediaQuery, context) {
    return ListView.builder(
      itemCount: funcionalities.length,
      itemBuilder: (context, index1) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            setState(() {
              funcionalities[index1].isExpanded =
                  !funcionalities[index1].isExpanded;
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
                          Icon(IconData(int.parse(funcionalities[index1].icon!),
                              fontFamily: 'MaterialIcons')),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            StringUtils.capitalize(
                                funcionalities[index1].name!),
                            style: textStyle(
                                fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      funcionalities[index1].isExpanded
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
                                !funcionalities[index1].isExpanded ? 0 : null,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: funcionalities[index1]
                                    .subFuncionalities!
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

        // return ExpansionTile(
        //     textColor: Colors.black,
        //     iconColor: Colors.black,
        //     title: Text(
        //       funcionalities[index1].name,
        //       style: textStyle(fontSize: 12, fontWeight: FontWeight.w700),
        //     ),
        //     children: funcionalities[index1]
        //         .subFuncionalities
        //         .map((subFuncionalities) {
        //       return _buildListSubFuncionalities(subFuncionalities);
        //     }).toList());
      },
    );
  }

  Widget _buildListSubFuncionalities(SubFuncionalitiesModel subFuncionalities,
      MediaQueryData mediaQuery, context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, subFuncionalities.route!);
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
                            child: Text(
                              subFuncionalities.name.toString(),
                              style: textStyle(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                            ),
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

  // ExpansionPanelList _buildListFuncionalities(
  //     List<FuncionalitieModel> funcionalities,
  //     MediaQueryData mediaQuery,
  //     context) {
  //   return ExpansionPanelList(
  //       elevation: 0,
  //       dividerColor: Colors.white,
  //       expansionCallback: (int index, bool isExpanded) {
  //         setState(() {
  //           funcionalities[index].isExpanded =
  //               !funcionalities[index].isExpanded;
  //         });
  //       },
  //       children:
  //           funcionalities.mapIndexed<ExpansionPanel>((index1, funcionalities) {
  //         return ExpansionPanel(
  //           backgroundColor: Colors.white,
  //           canTapOnHeader: true,
  //           headerBuilder: (BuildContext context, bool isExpanded) {
  //             return ListTile(
  //               title: Row(
  //                 children: [
  //                   Icon(
  //                     Icons.account_box,
  //                     color: Colors.grey.shade400,
  //                     size: 16,
  //                   ),
  //                   const SizedBox(
  //                     width: 6,
  //                   ),
  //                   Text(funcionalities.name,
  //                       textScaleFactor: mediaQuery.textScaleFactor,
  //                       style: textStyle(
  //                           fontSize: 12, fontWeight: FontWeight.w700)),
  //                 ],
  //               ),
  //             );
  //           },
  //           body: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: funcionalities.subFuncionalities
  //                 .mapIndexed((index2, subFuncionalities) {
  //               return GestureDetector(
  //                 onTap: () {
  //                   navigatorKey.currentState!.pushNamed(_controller
  //                       .funcionalities[index1].subFuncionalities[index2].route
  //                       .toString());
  //                 },
  //                 child: Padding(
  //                   padding: const EdgeInsets.only(left: 24),
  //                   child: MouseRegion(
  //                     onHover: (event) {
  //                       setState(() {
  //                         //set hover
  //                         _controller
  //                             .funcionalities[index1]
  //                             .subFuncionalities[index2]
  //                             .colorButton = Colors.grey.shade50;

  //                         // set border

  //                         _controller.funcionalities[index1]
  //                                 .subFuncionalities[index2].border =
  //                             Border(
  //                                 left: BorderSide(
  //                                     color: primaryColor, width: 4));
  //                       });
  //                     },
  //                     onExit: (event) {
  //                       setState(() {
  //                         //set hover
  //                         _controller
  //                             .funcionalities[index1]
  //                             .subFuncionalities[index2]
  //                             .colorButton = Colors.white;

  //                         //set border

  //                         _controller.funcionalities[index1]
  //                                 .subFuncionalities[index2].border =
  //                             Border(
  //                                 left: BorderSide(
  //                                     color: Colors.grey.shade200, width: 2));
  //                       });
  //                     },
  //                     child: Row(
  //                       children: [
  //                         Expanded(
  //                           child: Container(
  //                             decoration: BoxDecoration(
  //                                 color: subFuncionalities.colorButton,
  //                                 border: subFuncionalities.border),
  //                             child: Padding(
  //                               padding: const EdgeInsets.all(8.0),
  //                               child: Row(
  //                                 children: [
  //                                   Icon(
  //                                     Icons.favorite,
  //                                     color: secundaryColor,
  //                                     size: 24.0,
  //                                     semanticLabel:
  //                                         'Text to announce in accessibility modes',
  //                                   ),
  //                                   const SizedBox(
  //                                     width: 12,
  //                                   ),
  //                                   Text(subFuncionalities.name!,
  //                                       style: textStyle(
  //                                           fontWeight: FontWeight.w700)),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             }).toList(),
  //           ),
  //           isExpanded: _controller.funcionalities[index1].isExpanded,
  //         );
  //       }).toList());
  // }

  stateManagement(MediaQueryData mediaQuery, context) {
    switch (_controller.state) {
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

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      color: Colors.white,
      child: stateManagement(mediaQuery, context),
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
                    //SizedBox(height: 5.0),
                    // Container(
                    //   height: containerHeight,
                    //   width: containerWidth,
                    //   color: Colors.grey,
                    // ),
                    // SizedBox(height: 5.0),
                    // Container(
                    //   height: containerHeight,
                    //   width: containerWidth * 0.75,
                    //   color: Colors.grey,
                    // ),
                    // SizedBox(height: 5.0),
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

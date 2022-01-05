import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/departament_controller.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/models/departament_model.dart';
import 'package:gpp/src/repositories/departament_repository.dart';
import 'package:gpp/src/shared/enumeration/departament_enum.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:gpp/src/views/loading_view.dart';

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
    if (mounted) {
      setState(() {
        _controller.state = DepartamentEnum.loading;
      });
    }
    await _controller.changeDepartament();
    if (mounted) {
      setState(() {
        _controller.state = DepartamentEnum.changeDepartament;
      });
    }
  }

  @override
  initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    changeDepartaments();
  }

  // Widget _buildDepartamentList(List<DepartamentModel> departaments) {
  //   Widget widget = LayoutBuilder(
  //     builder: (context, constraints) {
  //       if (_responsive.isMobile(constraints.maxWidth)) {
  //         return ListView.builder(
  //             itemCount: 10,
  //             itemBuilder: (context, index) {
  //               return const Text('test');
  //               //return _buildListItem(departament, index, context);
  //             });
  //       }

  //       return Column(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.symmetric(vertical: 16.0),
  //             child: Row(
  //               children: [
  //                 Expanded(
  //                     child: Text('Nome',
  //                         style: textStyle(
  //                             color: Colors.grey.shade400,
  //                             fontWeight: FontWeight.w700))),
  //                 Expanded(
  //                   child: Center(
  //                       child: Text('Status',
  //                           style: textStyle(
  //                               color: Colors.grey.shade400,
  //                               fontWeight: FontWeight.w700))),
  //                 ),
  //                 Expanded(
  //                   child: Center(
  //                       child: Text('Ação',
  //                           style: textStyle(
  //                               color: Colors.grey.shade400,
  //                               fontWeight: FontWeight.w700))),
  //                 )
  //               ],
  //             ),
  //           ),
  //           const Divider(),
  //           Expanded(
  //             child: ListView.builder(
  //                 itemCount: departaments.length,
  //                 itemBuilder: (context, index) {
  //                   return _buildListItem(departaments, index, context);
  //                 }),
  //           )
  //         ],
  //       );
  //     },
  //   );

  //   return widget;
  // }

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

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text('Foto',
                          style: textStyle(
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w700))),
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

    return Container(color: Colors.white, child: widget);
  }

  // Widget _buildListItem(
  //     List<DepartamentModel> departaments, int index, BuildContext context) {
  //   return LayoutBuilder(
  //     builder: (context, constraints) {
  //       if (_responsive.isMobile(constraints.maxWidth)) {
  //         return Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 8.0),
  //           child: Container(
  //             decoration: BoxDecoration(
  //                 border: Border(
  //                     left: BorderSide(
  //                         color: departaments[index].active == "1"
  //                             ? secundaryColor
  //                             : Colors.grey.shade400,
  //                         width: 4))),
  //             child: Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //               child: Column(
  //                 children: [
  //                   Row(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       SizedBox(
  //                           height: 50,
  //                           width: 50,
  //                           child: ClipRRect(
  //                             borderRadius: BorderRadius.circular(10),
  //                             child: Image.network(
  //                                 'https://picsum.photos/250?image=9'),
  //                           )),
  //                       const SizedBox(
  //                         width: 12,
  //                       ),
  //                       // Column(
  //                       //   mainAxisAlignment: MainAxisAlignment.start,
  //                       //   crossAxisAlignment: CrossAxisAlignment.start,
  //                       //   children: [
  //                       //     Text(
  //                       //       departaments[index].description!,
  //                       //       style: textStyle(
  //                       //           color: Colors.black,
  //                       //           fontWeight: FontWeight.w700),
  //                       //     ),
  //                       //     const SizedBox(
  //                       //       height: 6,
  //                       //     ),
  //                       //     departaments[index].departement != null
  //                       //         ? Text(
  //                       //             departaments[index].departement!,
  //                       //             style: textStyle(
  //                       //                 color: Colors.grey.shade400,
  //                       //                 fontWeight: FontWeight.w700),
  //                       //           )
  //                       //         : Text('',
  //                       //             style: textStyle(
  //                       //                 color: Colors.black,
  //                       //                 fontWeight: FontWeight.w700))
  //                       //   ],
  //                       // )
  //                     ],
  //                   ),
  //                   const SizedBox(
  //                     height: 12,
  //                   ),
  //                   Row(
  //                     children: [
  //                       ElevatedButton(
  //                           style: buttonStyle,
  //                           onPressed: () => {
  //                                 Navigator.pushNamed(
  //                                     context, '/departament_detail',
  //                                     arguments: departaments[index])
  //                               },
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(12.0),
  //                             child: Text('Editar',
  //                                 style: textStyle(
  //                                     color: Colors.white,
  //                                     fontWeight: FontWeight.w700)),
  //                           )),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       }

  //       return Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 8.0),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Expanded(
  //                 flex: 2,
  //                 child: Row(
  //                   children: [
  //                     SizedBox(
  //                         height: 50,
  //                         width: 50,
  //                         child: ClipRRect(
  //                           borderRadius: BorderRadius.circular(10),
  //                           child: Image.network(
  //                               'https://picsum.photos/250?image=9'),
  //                         )),
  //                     const SizedBox(
  //                       width: 10,
  //                     ),
  //                     Text(
  //                       departaments[index].description,
  //                       style: textStyle(
  //                           color: Colors.black, fontWeight: FontWeight.w700),
  //                     ),
  //                   ],
  //                 )),
  //             Expanded(
  //                 child: Container(
  //               height: 10,
  //               width: 10,
  //               decoration: BoxDecoration(
  //                   color: departaments[index].active == "1"
  //                       ? secundaryColor
  //                       : Colors.grey.shade400,
  //                   shape: BoxShape.circle),
  //             )),
  //             Expanded(
  //               child: ElevatedButton(
  //                   style: buttonStyle,
  //                   onPressed: () => {
  //                         Navigator.pushNamed(context, '/departament_detail',
  //                             arguments: departaments[index])
  //                       },
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(12.0),
  //                     child: Text('Editar',
  //                         style: textStyle(
  //                             color: Colors.white,
  //                             fontWeight: FontWeight.w700)),
  //                   )),
  //             )
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
  Widget _buildListItem(
      List<DepartamentModel> departament, int index, BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (_responsive.isMobile(constraints.maxWidth)) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          color: departament[index].active == "1"
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
                                  'https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/female/68.png'),
                            )),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              departament[index].description,
                              style: textStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () => {
                            // Navigator.pushNamed(context, '/departaments_detail',
                            //     arguments: departament[index])
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.grey.shade400,
                          ),
                          onPressed: () => {
                            // Navigator.pushNamed(context, '/user_detail',
                            //     arguments: departament[index])
                          },
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 50,
                        width: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                              'https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/female/68.png'),
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  departament[index].description,
                  style: textStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
              ),
              Expanded(
                  child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    color: departament[index].active == "1"
                        ? secundaryColor
                        : Colors.grey.shade400,
                    shape: BoxShape.circle),
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
                      onPressed: () => {
                        Navigator.pushNamed(context, '/departaments_detail',
                            arguments: departament[index])
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.grey.shade400,
                      ),
                      onPressed: () => {
                        // Navigator.pushNamed(context, '/user_detail',
                        //     arguments: departament[index])
                      },
                    ),
                  ],
                ),
              ),
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
        return _buildList(_controller.departaments);
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

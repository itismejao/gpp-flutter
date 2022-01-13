// import 'package:flutter/material.dart';
// import 'package:gpp/src/controllers/departament_controller.dart';
// import 'package:gpp/src/controllers/notify_controller.dart';
// import 'package:gpp/src/models/departament_model.dart';
// import 'package:gpp/src/models/subfuncionalities_model.dart';
// import 'package:gpp/src/repositories/departament_repository.dart';
// import 'package:gpp/src/shared/components/button_primary_component.dart';
// import 'package:gpp/src/shared/enumeration/departament_enum.dart';
// import 'package:gpp/src/shared/repositories/styles.dart';
// import 'package:gpp/src/shared/services/gpp_api.dart';

// // ignore: must_be_immutable
// class DepartamentDetailView extends StatefulWidget {
//   DepartamentModel departament;

//   DepartamentDetailView({
//     Key? key,
//     required this.departament,
//   }) : super(key: key);

//   @override
//   _DepartamentDetailViewState createState() => _DepartamentDetailViewState();
// }

// class _DepartamentDetailViewState extends State<DepartamentDetailView> {
//   late final DepartamentController _controller =
//       DepartamentController(DepartamentRepository(api: gppApi));

//   changeDepartamentFuncionalities() async {
//     if (mounted) {
//       setState(() {
//         _controller.state = DepartamentEnum.loading;
//       });
//     }
//     await _controller.changeDepartamentSubFuncionalities(widget.departament);
//     if (mounted) {
//       setState(() {
//         _controller.state = DepartamentEnum.changeDepartament;
//       });
//     }
//   }

//   handleCheckBox(bool? value, int index) {
//     if (mounted) {
//       setState(() {
//         if (value!) {
//           _controller.subFuncionalities[index].active = true;
//         } else {
//           _controller.subFuncionalities[index].active = false;
//         }
//       });
//     }
//   }

//   void handleSalved(
//     context,
//   ) async {
//     NotifyController nofity = NotifyController(context: context);
//     if (await _controller.updateUserSubFuncionalities(
//         widget.departament, _controller.subFuncionalities)) {
//       nofity.sucess("Funcionalidade cadastrada!");
//     } else {
//       nofity.error("Departamento não atualizado !");
//     }
//   }

//   @override
//   initState() {
//     // ignore: todo
// ignore: todo
//     // TODO: implement initState
//     super.initState();

//     changeDepartamentFuncionalities();
//   }

//   ListView _buildSubFuncionalitiesList(
//       List<SubFuncionalitiesModel> subFuncionalities) {
//     return ListView.builder(
//         itemCount: subFuncionalities.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                     child: Text(
//                   subFuncionalities[index].name!,
//                   style: textStyle(
//                       color: Colors.black, fontWeight: FontWeight.w700),
//                 )),
//                 Expanded(
//                   child: Checkbox(
//                     checkColor: Colors.white,
//                     value: subFuncionalities[index].active,
//                     onChanged: (bool? value) => handleCheckBox(value, index),
//                   ),
//                 )
//               ],
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(48.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: Row(
//                 children: [
//                   Text('Departamento',
//                       style: textStyle(
//                           fontSize: 24,
//                           color: Colors.black,
//                           fontWeight: FontWeight.w700))
//                 ],
//               ),
//             ),
//             Row(
//               children: [
//                 SizedBox(
//                   height: 120,
//                   width: 120,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(5),
//                     child: Image.network('https://picsum.photos/250?image=9'),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 32,
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(widget.departament.name!),
//                     // const SizedBox(
//                     //   height: 12,
//                     // ),
//                     // Text(widget.user.email!)
//                   ],
//                 )
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 24.0),
//               child: Row(
//                 children: [
//                   Text('Funcionalidades',
//                       style: textStyle(
//                           fontSize: 24,
//                           color: Colors.black,
//                           fontWeight: FontWeight.w700))
//                 ],
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Expanded(
//                     child: Text('Nome',
//                         style: textStyle(
//                             color: Colors.grey.shade400,
//                             fontWeight: FontWeight.w700))),
//                 Expanded(
//                     child: Center(
//                   child: Text('Status',
//                       style: textStyle(
//                           color: Colors.grey.shade400,
//                           fontWeight: FontWeight.w700)),
//                 )),
//               ],
//             ),
//             const Divider(),
//             Expanded(
//                 child: _controller.state == DepartamentEnum.changeDepartament
//                     ? _buildSubFuncionalitiesList(_controller.subFuncionalities)
//                     : Container()),
//             Row(
//               children: [
//                 ButtonPrimaryComponent(
//                     onPressed: () => handleSalved(context), text: "Salvar")
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/departament_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/models/departament_model.dart';
import 'package:gpp/src/repositories/departament_repository.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/enumeration/departament_enum.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:gpp/src/views/loading_view.dart';

// ignore: must_be_immutable
class DepartamentDetailView extends StatefulWidget {
  String id;
  DepartamentDetailView({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _DepartamentDetailViewState createState() => _DepartamentDetailViewState();
}

class _DepartamentDetailViewState extends State<DepartamentDetailView> {
  late DepartamentController _controller;
  bool _selectedAll = false;

  fetchDepartament() async {
    await _controller.fetch(widget.id);
    setState(() {
      _controller.state = DepartamentEnum.changeDepartament;
    });
  }

  fetchSubFuncionalities() async {
    DepartamentModel departament = DepartamentModel(id: int.parse(widget.id));
    await _controller.changeDepartamentSubFuncionalities(departament);
    setState(() {
      _controller.state = DepartamentEnum.changeDepartament;
    });
  }

  handleCheckBox(bool? value, int index) {
    setState(() {
      if (value!) {
        _controller.subFuncionalities[index].active = true;
      } else {
        _controller.subFuncionalities[index].active = false;
      }
    });
  }

  handleSelectedAll(value) {
    setState(() {
      _selectedAll = value;

      for (var i = 0; i < _controller.subFuncionalities.length; i++) {
        _controller.subFuncionalities[i].active = value;
      }
    });
  }

  handleUpdate(context) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await _controller.update() &&
          await _controller.updateDepartamentSubFuncionalities()) {
        notify.sucess("Departamento atualizado!");
        Navigator.pushReplacementNamed(context, '/departaments');
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  // checkedSelectedAll() {
  //   _selectedAll = true;
  //   var contador = 0;
  //   for (var i = 0; i < _controller.subFuncionalities.length; i++) {
  //     if (_controller.subFuncionalities[i].active!) {
  //       contador++;
  //     }
  //   }

  //   if (contador != _controller.subFuncionalities.length) {
  //     _selectedAll = false;
  //   }
  //   setState(() {});
  // }

  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _controller = DepartamentController(DepartamentRepository(api: gppApi));

    fetchDepartament();

    //Busca subfuncionalidades
    fetchSubFuncionalities();

    // checkedSelectedAll();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.state == DepartamentEnum.changeDepartament) {
      return Container(
        child: Form(
            key: _controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text("Editar Departamento",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                InputComponent(
                  initialValue: _controller.departament.name,
                  label: "Nome",
                  maxLength: 50,
                  onChanged: (value) {
                    print("te");
                    _controller.departament.name = value;
                  },
                  validator: (value) {
                    _controller.validate(value);
                  },
                  hintText: "Digite o nome do departamento",
                  prefixIcon: Icon(Icons.lock),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Radio(
                          activeColor: secundaryColor,
                          value: true,
                          groupValue: _controller.departament.active,
                          onChanged: (bool? value) {
                            setState(() {
                              _controller.departament.active = value;
                            });
                          }),
                      Text("Habilitado"),
                      Radio(
                          activeColor: secundaryColor,
                          value: false,
                          groupValue: _controller.departament.active,
                          onChanged: (bool? value) {
                            setState(() {
                              _controller.departament.active = value;
                            });
                          }),
                      Text("Desabilitado"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              activeColor: primaryColor,
                              checkColor: Colors.white,
                              value: _selectedAll,
                              onChanged: (bool? value) =>
                                  handleSelectedAll(value),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nome',
                                style: textStyle(
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _controller.subFuncionalities.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      activeColor: primaryColor,
                                      checkColor: Colors.white,
                                      value: _controller
                                          .subFuncionalities[index].active,
                                      onChanged: (bool? value) =>
                                          handleCheckBox(value, index),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _controller
                                          .subFuncionalities[index].name!,
                                      style: textStyle(
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          handleUpdate(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: secundaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15, left: 25, bottom: 15, right: 25),
                            child: Text(
                              "Editar",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      );
    } else {
      return LoadingView();
    }
  }
}

// import 'package:flutter/material.dart';

// import 'package:gpp/src/controllers/departament_controller.dart';
// import 'package:gpp/src/controllers/notify_controller.dart';
// import 'package:gpp/src/models/departament_model.dart';
// import 'package:gpp/src/repositories/departament_repository.dart';
// import 'package:gpp/src/shared/repositories/styles.dart';
// import 'package:gpp/src/shared/services/gpp_api.dart';

// // ignore: must_be_immutable
// class DepartamentFormView extends StatefulWidget {
//   DepartamentModel? departament;
//   DepartamentFormView({
//     Key? key,
//     this.departament,
//   }) : super(key: key);

//   @override
//   State<DepartamentFormView> createState() => _DepartamentFormViewState();
// }

// class _DepartamentFormViewState extends State<DepartamentFormView> {
//   int _currentForm = 0;

//   late DepartamentController _controller;

//   handleCreate(DepartamentModel departament, context) async {
//     NotifyController notify = NotifyController(context: context);
//     try {
//       if (await _controller.create(departament)) {
//         Navigator.of(context, rootNavigator: true).pop(true);
//         notify.sucess("Departamento cadastrado!");
//       }
//     } catch (e) {
//       notify.error(e.toString());
//     }
//   }

//   handleUpdate(DepartamentModel departament, context) async {
//     NotifyController notify = NotifyController(context: context);
//     try {
//       if (await _controller.update(departament)) {
//         Navigator.of(context, rootNavigator: true).pop(true);
//         notify.sucess("Departamento atualizado!");
//       }
//     } catch (e) {
//       notify.error(e.toString());
//     }
//   }

//   fetchFuncionalities() async {
//     await _controller.changeDepartamentSubFuncionalities(widget.departament!);
//   }

//   //Validações
//   validate(value) {
//     if (value.isEmpty) {
//       return 'Campo obrigatório';
//     }
//     return null;
//   }

//   @override
//   void initState() {
//     // ignore: todo
// ignore: todo
//     // TODO: implement initState
//     super.initState();
//     _controller = DepartamentController(DepartamentRepository(api: gppApi));

//     if (widget.departament!.id == null) {
//       widget.departament = DepartamentModel();
//       //Buscar as funcionalidades

//     } else {
//       fetchFuncionalities();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);

//     Widget page = Container();
//     switch (_currentForm) {
//       case 0:
//         page = _buildFormDepartament(mediaQuery);
//         break;
//       case 1:
//         page = _buildFormFuncionalities(mediaQuery);
//         break;
//     }
//     return page;

//     // return Form(
//     //   key: _controller.formKey,
//     //   child: Column(
//     //     mainAxisAlignment: MainAxisAlignment.start,
//     //     crossAxisAlignment: CrossAxisAlignment.start,
//     //     children: [
//     //       Text(
//     //         "Cadastrar Departamento",
//     //         style: textStyle(fontSize: 24, fontWeight: FontWeight.w700),
//     //       ),
//     //       SizedBox(
//     //         height: 24,
//     //       ),
//     //       InputComponent(
//     //         label: "Nome",
//     //         prefixIcon: Icon(Icons.work),
//     //         hintText: "Digite o nome do departamento",
//     //         onChanged: (value) {
//     //           _departament.name = value;
//     //         },
//     //         validator: (value) => _controller.validate(value),
//     //       ),
//     //       SizedBox(
//     //         height: 14,
//     //       ),
//     //       ButtonPrimaryComponent(
//     //           onPressed: () => {handleCreate(_departament, context)},
//     //           text: "Adicionar")
//     //     ],
//     //   ),
//     // );
//   }

//   Container _buildFormFuncionalities(MediaQueryData mediaQuery) {
//     return Container(
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
//             child: Row(
//               children: [
//                 Flexible(
//                   child: Text("Funcionalidades vinculadas ao departamento",
//                       style: TextStyle(
//                           fontSize: 24 * mediaQuery.textScaleFactor,
//                           fontWeight: FontWeight.bold)),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//             child: Row(
//               children: [
//                 Text("Escolha as funcionalidades vinculadas ao departamento",
//                     style: TextStyle(
//                       color: Colors.grey.shade400,
//                       fontSize: 10 * mediaQuery.textScaleFactor,
//                     )),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Selecionar todos",
//                     style: TextStyle(
//                       color: Colors.grey.shade400,
//                       fontSize: 10 * mediaQuery.textScaleFactor,
//                     )),
//                 Checkbox(value: true, onChanged: (value) {})
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//             child: Container(
//               height: mediaQuery.size.height * 0.5,
//               child: ListView.builder(
//                   itemCount: _controller.subFuncionalities.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(_controller.subFuncionalities[index].name!,
//                                   style: TextStyle(
//                                     color: Colors.grey.shade400,
//                                     fontSize: 10 * mediaQuery.textScaleFactor,
//                                   )),
//                               Checkbox(
//                                   value: _controller
//                                       .subFuncionalities[index].active,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _controller.subFuncionalities[index]
//                                           .active = value;
//                                     });
//                                   })
//                             ],
//                           ),
//                         ],
//                       ),
//                     );
//                   }),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       print("object");
//                       _currentForm--;
//                     });
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade500,
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(5),
//                           topRight: Radius.circular(5),
//                           bottomLeft: Radius.circular(5),
//                           bottomRight: Radius.circular(5)),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 1,
//                           blurRadius: 7,
//                           offset: Offset(0, 1), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 10, horizontal: 40),
//                       child: Text(
//                         "Voltar",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 12 * mediaQuery.textScaleFactor,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       print("object");
//                       _currentForm++;
//                     });
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: primaryColor,
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(5),
//                           topRight: Radius.circular(5),
//                           bottomLeft: Radius.circular(5),
//                           bottomRight: Radius.circular(5)),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 1,
//                           blurRadius: 7,
//                           offset: Offset(0, 1), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 10, horizontal: 40),
//                       child: Text(
//                         "Cadastrar",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 12 * mediaQuery.textScaleFactor,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Container _buildFormDepartament(MediaQueryData mediaQuery) {
//     return Container(
//       child: Form(
//         key: _controller.formKey,
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
//               child: Row(
//                 children: [
//                   Text(
//                       widget.departament!.id == null
//                           ? "Cadastrar departamento"
//                           : "Editar departamento",
//                       style: TextStyle(
//                           fontSize: 24 * mediaQuery.textScaleFactor,
//                           fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//               child: Row(
//                 children: [
//                   Text("Digite as informações do departamento",
//                       style: TextStyle(
//                         color: Colors.grey.shade400,
//                         fontSize: 10 * mediaQuery.textScaleFactor,
//                       )),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(5)),
//                 child: TextFormField(
//                   initialValue: widget.departament!.name,
//                   validator: (value) => validate(value),
//                   onChanged: (value) {
//                     widget.departament!.name = value;
//                   },
//                   decoration: InputDecoration(
//                       contentPadding: EdgeInsets.only(
//                           top: 20, left: 20, bottom: 20, right: 20),
//                       border: InputBorder.none,
//                       hintText: 'Digite o nome do departamento'),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(5)),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                       contentPadding: EdgeInsets.only(
//                           top: 20, left: 20, bottom: 20, right: 20),
//                       border: InputBorder.none,
//                       hintText: 'Digite o nome do responsável'),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(5)),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                       contentPadding: EdgeInsets.only(
//                           top: 20, left: 20, bottom: 20, right: 20),
//                       border: InputBorder.none,
//                       hintText: 'Digite o endereço'),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//               child: Row(
//                 children: [
//                   Radio(
//                       activeColor: secundaryColor,
//                       value: true,
//                       groupValue: widget.departament!.active,
//                       onChanged: (bool? value) {
//                         setState(() {
//                           widget.departament!.active = value;
//                         });
//                       }),
//                   Text("Habilitado"),
//                   Radio(
//                       activeColor: secundaryColor,
//                       value: false,
//                       groupValue: widget.departament!.active,
//                       onChanged: (bool? value) {
//                         setState(() {
//                           widget.departament!.active = value;
//                         });
//                       }),
//                   Text("Desabilitado"),
//                 ],
//               ),
//             ),
//             GestureDetector(
//               onTap: () => widget.departament!.id == null
//                   ? handleCreate(widget.departament!, context)
//                   : handleUpdate(widget.departament!, context),
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         color: primaryColor,
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(5),
//                             topRight: Radius.circular(5),
//                             bottomLeft: Radius.circular(5),
//                             bottomRight: Radius.circular(5)),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             spreadRadius: 1,
//                             blurRadius: 7,
//                             offset: Offset(0, 1), // changes position of shadow
//                           ),
//                         ],
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 10, horizontal: 40),
//                         child: Text(
//                           widget.departament!.id == null
//                               ? "Cadastrar"
//                               : "Editar",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 12 * mediaQuery.textScaleFactor,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
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
import 'package:gpp/src/repositories/departament_repository.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class DepartamentFormView extends StatefulWidget {
  const DepartamentFormView({Key? key}) : super(key: key);

  @override
  State<DepartamentFormView> createState() => _DepartamentFormViewState();
}

class _DepartamentFormViewState extends State<DepartamentFormView> {
  late DepartamentController _controller;

  handleCreate() async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await _controller.create()) {
        notify.sucess("Departamento cadastrado!");
        Navigator.pushReplacementNamed(context, '/departamentos');
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
    _controller = DepartamentController(DepartamentRepository(api: gppApi));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          key: _controller.formKey,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text("Cadastrar Departamento",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                InputComponent(
                  label: "Nome",
                  onChanged: (value) {
                    print("te");
                    _controller.departament.nome = value;
                  },
                  validator: (value) {
                    _controller.validate(value);
                  },
                  hintText: "Digite o nome do departamento",
                  prefixIcon: Icon(Icons.lock),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    children: [
                      Radio(
                          activeColor: secundaryColor,
                          value: true,
                          groupValue: _controller.departament.situacao,
                          onChanged: (bool? value) {
                            setState(() {
                              _controller.departament.situacao = value;
                            });
                          }),
                      Text("Habilitado"),
                      Radio(
                          activeColor: secundaryColor,
                          value: false,
                          groupValue: _controller.departament.situacao,
                          onChanged: (bool? value) {
                            setState(() {
                              _controller.departament.situacao = value;
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
                      GestureDetector(
                        onTap: () {
                          handleCreate();
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
            ),
          )),
    );
  }
}

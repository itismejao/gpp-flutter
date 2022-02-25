import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/addressing_floor_controller.dart';
import 'package:gpp/src/controllers/enderecamento_box_controller.dart';
import 'package:gpp/src/controllers/enderecamento_controller.dart';
import 'package:gpp/src/controllers/enderecamento_corredor_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/models/box_enderecamento_model.dart';
import 'package:gpp/src/models/corredor_enderecamento_model.dart';
import 'package:gpp/src/models/piso_enderecamento_model.dart';
import 'package:gpp/src/shared/components/button_component.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/components/status_component.dart';
import 'package:gpp/src/shared/components/text_component.dart';
import 'package:gpp/src/shared/components/title_component.dart';
import 'package:gpp/src/repositories/piso_enderecamento_repository.dart';
import 'package:gpp/src/repositories/corredor_enderecamento_repository.dart';

import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/views/addressing/cadastro_corredor_view.dart';
import 'package:gpp/src/views/funcionalities_view.dart';
import 'package:gpp/src/views/home/home_view.dart';

class CadastroBoxView extends StatefulWidget {
  String? idPrateleira;
  CadastroBoxView({this.idPrateleira});

  // int id;

  //CadastroCorredorView({ Key? key, required this.id } ) : super(key: key);

  //const CadastroBoxView({Key? key}) : super(key: key);

  @override
  _CadastroBoxViewState createState() => _CadastroBoxViewState();
}

class _CadastroBoxViewState extends State<CadastroBoxView> {
  //late EnderecamentoPrateleiraController controller;
  String? idEstante;

  late EnderecamentoController enderecamentoController;

  fetchAll(String idPrateleira) async {
    //Carrega lista de motivos de defeito de peças
    enderecamentoController.listaBox = await enderecamentoController.buscarBox(idPrateleira);

    enderecamentoController.isLoaded = true;

    //Notifica a tela para atualizar os dados
    setState(() {
      enderecamentoController.isLoaded = true;
    });
  }

  handleCreate(context, BoxEnderecamentoModel boxEnderecamentoModel, String idPrateleira) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await enderecamentoController.criarBox(boxEnderecamentoModel, idPrateleira)) {
        Navigator.pop(context);
        fetchAll(widget.idPrateleira.toString());
        notify.sucess('Box adicionado com sucesso!');
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  handleDelete(context, BoxEnderecamentoModel boxEnderecamentoModel) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await notify.alert("você deseja excluir o Box?")) {
        if (await enderecamentoController.excluirBox(boxEnderecamentoModel)) {
          // Navigator.pop(context); //volta para tela anterior

          fetchAll(widget.idPrateleira.toString());
          notify.sucess("Box excluído!");
          //Atualiza a lista de motivos
        }
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  openForm(context, BoxEnderecamentoModel boxEnderecamentoModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Cadastro de Box"),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      InputComponent(
                        label: 'Box',
                        initialValue: boxEnderecamentoModel.desc_box,
                        hintText: 'Digite o nome do Box',
                        onChanged: (value) {
                          setState(() {
                            boxEnderecamentoModel.desc_box = value;
                          });
                        },
                      ),
                      InputComponent(
                        label: 'Prateleira',
                        initialValue: boxEnderecamentoModel.id_prateleira.toString(),
                        hintText: 'Digite a Prateleira',
                        onChanged: (value) {
                          setState(() {
                            boxEnderecamentoModel.id_prateleira.toString();
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: Row(
                          children: [
                            ButtonComponent(
                                onPressed: () {
                                  handleCreate(context, enderecamentoController.boxModel, widget.idPrateleira.toString());
                                },
                                text: 'Adicionar')
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    //Iniciliza controlador
    // controller = EnderecamentoPrateleiraController();
    enderecamentoController = EnderecamentoController();
    //Quando o widget for inserido na árvore chama o fetchAll
    fetchAll(widget.idPrateleira.toString());
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: TitleComponent('Box')),
                  ButtonComponent(
                      onPressed: () {
                        enderecamentoController.boxModel.id_prateleira = int.parse(widget.idPrateleira.toString());
                        openForm(context, enderecamentoController.boxModel);
                      },
                      text: 'Adicionar')
                ],
              ),
            ),
            Divider(),
            Row(
              children: [
                Expanded(child: TextComponent('Nome')),
                Expanded(child: TextComponent('Opções')),
              ],
            ),
            Divider(),
            enderecamentoController.isLoaded
                ? Container(
                    height: media.size.height * 0.5,
                    child: ListView.builder(
                      itemCount: enderecamentoController.listaBox.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            color: (index % 2) == 0 ? Colors.white : Colors.grey.shade50,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextComponent(enderecamentoController.listaBox[index].desc_box.toString()),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.grey.shade400,
                                          ),
                                          onPressed: () {
                                            handleDelete(context, enderecamentoController.listaBox[index]);
                                          }),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : LoadingComponent()
          ],
        ),
      ),
    );
  }
}

//   //late EnderecamentoBoxController controller;
//   String? idPrateleira;

//   late EnderecamentoController enderecamentoController;

//   fetchAll(String idPrateleira) async {
//     //Carrega lista de motivos de defeito de peças
//     enderecamentoController.listaBox = await enderecamentoController.repository.buscarBox(idPrateleira);

//     enderecamentoController.isLoaded = true;

//     //Notifica a tela para atualizar os dados
//     setState(() {
//       enderecamentoController.isLoaded = true;
//     });
//   }

//   handleCreate(context, BoxEnderecamentoModel boxEnderecamentoModel, String idPrateleira) async {
//     NotifyController notify = NotifyController(context: context);
//     try {
//       if (await enderecamentoController.criarBox(boxEnderecamentoModel, idPrateleira)) {
//         Navigator.pop(context);
//         fetchAll(widget.idPrateleira.toString());
//         notify.sucess('Box adicionado com sucesso!');
//       }
//     } catch (e) {
//       notify.error(e.toString());
//     }
//   }

//   handleDelete(context, BoxEnderecamentoModel boxEnderecamentoModel) async {
//     NotifyController notify = NotifyController(context: context);
//     try {
//       if (await notify.alert("você deseja excluir o box?")) {
//         if (await enderecamentoController.excluirBox(boxEnderecamentoModel)) {
//           // Navigator.pop(context); //volta para tela anterior

//           fetchAll(widget.idPrateleira.toString());
//           notify.sucess("Box excluído!");
//           //Atualiza a lista de motivos
//         }
//       }
//     } catch (e) {
//       notify.error(e.toString());
//     }
//   }

//   openForm(context, BoxEnderecamentoModel boxEnderecamentoReplacement) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         // retorna um objeto do tipo Dialog
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               title: Text("Cadastro do Box"),
//               // pisoEnderecamentoReplacement.id_piso == null

//               actions: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(24),
//                   child: Column(
//                     children: [
//                       InputComponent(
//                         label: 'Box',
//                         initialValue: boxEnderecamentoReplacement.desc_box,
//                         hintText: 'Digite o nome do Box',
//                         onChanged: (value) {
//                           setState(() {
//                             boxEnderecamentoReplacement.desc_box = value!;
//                           });
//                         },
//                       ),
//                       InputComponent(
//                         label: 'Prateleira',
//                         initialValue: boxEnderecamentoReplacement.id_prateleira.toString(),
//                         hintText: 'Digite a Prateleira',
//                         onChanged: (value) {
//                           setState(() {
//                             boxEnderecamentoReplacement.id_prateleira.toString();
//                           });
//                         },
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10),
//                         child: Row(),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 24.0),
//                         child: Row(
//                           children: [
//                             //  pisoEnderecamentoReplacement.id_piso == null
//                             ButtonComponent(
//                                 onPressed: () {
//                                   handleCreate(context, enderecamentoController.boxModel, widget.idPrateleira.toString());
//                                 },
//                                 text: 'Adicionar')
//                             // :ButtonComponent(
//                             //     color: Colors.red,
//                             //     onPressed: () {
//                             //       handleCreate(context, pisoEnderecamentoReplacement);
//                             //     },
//                             //     text: 'Cancelar')
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     //Iniciliza controlador
//     //controller = EnderecamentoBoxController();
//     enderecamentoController = EnderecamentoController();
//     //Quando o widget for inserido na árvore chama o fetchAll
//     fetchAll(widget.idPrateleira.toString());
//   }

//   @override
//   Widget build(BuildContext context) {
//     final media = MediaQuery.of(context);
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 24.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Flexible(child: TitleComponent('Box')),
//                   ButtonComponent(
//                       onPressed: () {
//                         enderecamentoController.boxModel.id_prateleira = int.parse(widget.idPrateleira.toString());
//                         openForm(context, enderecamentoController.boxModel);
//                       },
//                       text: 'Adicionar')
//                 ],
//               ),
//             ),
//             Divider(),
//             Row(
//               children: [
//                 Expanded(child: TextComponent('Nome')),
//                 Expanded(child: TextComponent('Medida')),
//                 Expanded(child: TextComponent('Emissão')),
//                 Expanded(child: TextComponent('Opções')),
//               ],
//             ),
//             Divider(),
//             enderecamentoController.isLoaded
//                 ? Container(
//                     height: media.size.height * 0.5,
//                     child: ListView.builder(
//                       itemCount: enderecamentoController.listaBox.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: Container(
//                             color: (index % 2) == 0 ? Colors.white : Colors.grey.shade50,
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: TextComponent(enderecamentoController.listaBox[index].desc_box.toString()),
//                                 ),
//                                 Expanded(
//                                   child: TextComponent(enderecamentoController.listaBox[index].medida.toString()),
//                                 ),
//                                 Expanded(
//                                   child: TextComponent(enderecamentoController.listaBox[index].created_at.toString()),
//                                 ),
//                                 Expanded(
//                                   child: Row(
//                                     children: [
//                                       IconButton(
//                                           icon: Icon(
//                                             Icons.delete,
//                                             color: Colors.grey.shade400,
//                                           ),
//                                           onPressed: () {
//                                             handleDelete(context, enderecamentoController.listaBox[index]);
//                                           }),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   )
//                 : LoadingComponent()
//           ],
//         ),
//       ),
//     );
//   }
// }

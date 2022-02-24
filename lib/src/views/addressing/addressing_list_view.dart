import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/addressing_floor_controller.dart';
import 'package:gpp/src/controllers/enderecamento_controller.dart';
import 'package:gpp/src/controllers/enderecamento_corredor_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
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
import 'package:gpp/src/views/home/home_view.dart';

import '../funcionalities_view.dart';

class AddressingListView extends StatefulWidget {
  const AddressingListView({Key? key}) : super(key: key);

  @override
  _AddressingListViewState createState() => _AddressingListViewState();
}

class _AddressingListViewState extends State<AddressingListView> {
//  late AddressingFloorController controller;
  late EnderecamentoController enderecamentoController;

  fetchAll() async {
    //Carrega lista de motivos de defeito de peças
    enderecamentoController.listaPiso = await enderecamentoController.buscarTodos();

    enderecamentoController.isLoaded = true;

    //Notifica a tela para atualizar os dados
    setState(() {
      enderecamentoController.isLoaded = true;
    });
  }

  // handleCreate(context, PisoEnderecamentoModel pisoEnderecamentoReplacement) async {
  //   NotifyController notify = NotifyController(context: context);
  //   try {
  //     if (await controller.repository.create(pisoEnderecamentoReplacement)) {
  //       Navigator.pop(context);
  //       fetchAll();
  //       notify.sucess('Motivo de peça adicionado com sucesso!');
  //     }
  //   } catch (e) {
  //     notify.error(e.toString());
  //   }
  // }

  // handleDelete(context, PisoEnderecamentoModel pisoEnderecamentoReplacement) async {
  //   NotifyController notify = NotifyController(context: context);
  //   try {
  //     if (await notify
  //         .alert("você deseja excluir o piso?")) {
  //       if (await controller.repository.excluir(pisoEnderecamentoReplacement)) {
  //         notify.sucess("Piso excluído!");
  //         //Atualiza a lista de motivos
  //         fetchAll();
  //       }
  //     }
  //   } catch (e) {
  //     notify.error(e.toString());
  //   }
  // }

  openForm(context, PisoEnderecamentoModel pisoEnderecamentoReplacement) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Cadastro do Piso"),
              // pisoEnderecamentoReplacement.id_piso == null

              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      InputComponent(
                        label: 'Piso',
                        initialValue: pisoEnderecamentoReplacement.desc_piso,
                        hintText: 'Digite o nome do Piso',
                        onChanged: (value) {
                          setState(() {
                            pisoEnderecamentoReplacement.desc_piso = value!;
                          });
                        },
                      ),
                      InputComponent(
                        label: 'Filial',
                        initialValue: pisoEnderecamentoReplacement.id_filial.toString(),
                        hintText: 'Digite a filial',
                        onChanged: (value) {
                          setState(() {
                            pisoEnderecamentoReplacement.id_filial = 500;
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
                            //  pisoEnderecamentoReplacement.id_piso == null
                            ButtonComponent(
                                onPressed: () {
                                  // handleCreate(
                                  //     context, pisoEnderecamentoReplacement);
                                },
                                text: 'Adicionar')
                            // :ButtonComponent(
                            //     color: Colors.red,
                            //     onPressed: () {
                            //       handleCreate(context, pisoEnderecamentoReplacement);
                            //     },
                            //     text: 'Cancelar')
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
    //controller = AddressingFloorController();
    enderecamentoController = EnderecamentoController();
    //Quando o widget for inserido na árvore chama o fetchAll
    fetchAll();
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
                  Flexible(child: TitleComponent('Pisos')),
                  ButtonComponent(
                      onPressed: () {
                        openForm(context, enderecamentoController.pisoModel);
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
                      itemCount: enderecamentoController.listaPiso.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            color: (index % 2) == 0 ? Colors.white : Colors.grey.shade50,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextComponent(enderecamentoController.listaPiso[index].desc_piso.toString()),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      ButtonComponent(
                                          onPressed: () {
                                            // Navigator.pushNamed(context, '/piso/${enderecamentoController.listaPiso[index].id_piso}/corredor'); // openForm(context, controller.pisoEnderecamentoReplacement);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => HomeView(
                                                    funcionalities: FuncionalitiesView(),
                                                    page: CadastroCorredorView(
                                                        idPiso: enderecamentoController.listaPiso[index].id_piso.toString()),
                                                  ),
                                                ));
                                          },
                                          text: 'Corredor'),
                                      IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.grey.shade400,
                                          ),
                                          onPressed: () => {
                                                // handleDelete(
                                                //     context,
                                                //     controller
                                                //             .pisoEnderecamentoReplacements[
                                                //         index]),
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

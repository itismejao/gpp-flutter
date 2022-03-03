import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/addressing_floor_controller.dart';
import 'package:gpp/src/controllers/enderecamento_controller.dart';
import 'package:gpp/src/controllers/enderecamento_corredor_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/models/corredor_enderecamento_model.dart';
import 'package:gpp/src/models/piso_enderecamento_model.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/InputComponent.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/components/status_component.dart';
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
    enderecamentoController.listaPiso = await enderecamentoController.buscarTodos();

    enderecamentoController.isLoaded = true;

    //Notifica a tela para atualizar os dados
    setState(() {
      enderecamentoController.isLoaded = true;
    });
  }

  handleCreate(context, PisoEnderecamentoModel piso) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await enderecamentoController.repository.criar(piso)) {
        Navigator.pop(context);
        fetchAll();
        notify.sucess('Piso adicionado com sucesso!');
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  handleDelete(context, PisoEnderecamentoModel excluiPiso) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await notify.alert("você deseja excluir o piso?")) {
        if (await enderecamentoController.repository.excluir(excluiPiso)) {
          notify.sucess("Piso excluído!");
          //Atualiza a lista de motivos
          fetchAll();
        }
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  //  handleEdit(context) async {
  //   NotifyController notify = NotifyController(context: context);
  //   try {
  //     if (await enderecamentoController.editar()) {
  //       notify.sucess("Piso editado com sucesso!");
  //     }
  //   } catch (e) {
  //     notify.error(e.toString());
  //   }
  // }

  handleEdit(context, PisoEnderecamentoModel editaPiso) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await enderecamentoController.editar()) {
        notify.sucess("Piso editado com sucesso!");
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

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
                        hintText: 'Digite a filial',
                        onChanged: (value) {
                          setState(() {
                            pisoEnderecamentoReplacement.id_filial = int.parse(value);
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
                                  handleCreate(context, pisoEnderecamentoReplacement);
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

  openFormEdit(context, PisoEnderecamentoModel pisoEnderecamentoReplacement) {
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
                            pisoEnderecamentoReplacement.desc_piso.toString();
                          });
                        },
                      ),
                      InputComponent(
                        label: 'Filial',
                        initialValue: pisoEnderecamentoReplacement.id_filial.toString(),
                        hintText: 'Digite a filial',
                        onChanged: (value) {
                          setState(() {
                            pisoEnderecamentoReplacement.id_filial.toString();
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
                                  handleEdit(context, pisoEnderecamentoReplacement);
                                  // handleEdit(context);
                                  // Navigator.pop(context);
                                  // context,
                                  //           enderecamentoController.listaPiso[index],
                                },
                                text: 'Alterar')
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
                Expanded(child: TextComponent('Id')),
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
                                  child: TextComponent(enderecamentoController.listaPiso[index].id_piso.toString()),
                                ),
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
                                          Icons.edit,
                                          color: Colors.grey.shade400,
                                        ),
                                        onPressed: () {
                                          openFormEdit(context, enderecamentoController.listaPiso[index]);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.grey.shade400,
                                        ),
                                        onPressed: () {
                                          handleDelete(
                                            context,
                                            enderecamentoController.listaPiso[index],
                                          );
                                        },
                                      )
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

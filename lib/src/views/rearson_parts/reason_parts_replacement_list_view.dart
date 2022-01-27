import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/reason_parts_replacement_controller.dart';
import 'package:gpp/src/models/reason_parts_replacement_model.dart';
import 'package:gpp/src/shared/components/button_component.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/components/status_component.dart';
import 'package:gpp/src/shared/components/text_component.dart';
import 'package:gpp/src/shared/components/title_component.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

class ReasonPartsReplacementListView extends StatefulWidget {
  const ReasonPartsReplacementListView({Key? key}) : super(key: key);

  @override
  _ReasonPartsReplacementListViewState createState() =>
      _ReasonPartsReplacementListViewState();
}

class _ReasonPartsReplacementListViewState
    extends State<ReasonPartsReplacementListView> {
  late ReasonPartsReplacementController controller;

  fetchAll() async {
    //Carrega lista de motivos de defeito de peças
    controller.reasonPartsReplacements = await controller.repository.fetchAll();

    //controller.isLoaded = true;

    //Notifica a tela para atualizar os dados
    setState(() {
      controller.isLoaded = true;
    });
  }

  handleDelete(
      context, ReasonPartsReplacementModel reasonPartsReplacement) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await notify
          .alert("você deseja excluir o motivo de troca de peça ?")) {
        if (await controller.repository.delete(reasonPartsReplacement)) {
          notify.sucess("Funcionalidade excluída!");
          //Atualiza a lista de motivos
          fetchAll();
        }
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  handleCreate(context) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await controller.repository
          .create(controller.reasonPartsReplacement)) {
        Navigator.pop(context);
        fetchAll();
        notify.sucess('Motivo de peça adicionado com sucesso!');
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  showDialogCreate(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: new Text("Adicionar motivo de troca de peça"),
              content: new Text("preencha as informações abaixo"),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      InputComponent(
                        label: 'Nome',
                        hintText: 'Digite o motivo da troca de peça',
                        onChanged: (value) {
                          setState(() {
                            controller.reasonPartsReplacement.name = value!;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Radio(
                                activeColor: secundaryColor,
                                value: true,
                                groupValue:
                                    controller.reasonPartsReplacement.status,
                                onChanged: (bool? value) {
                                  setState(() {
                                    controller.reasonPartsReplacement.status =
                                        value!;
                                  });
                                }),
                            Text("Habilitado"),
                            Radio(
                                activeColor: secundaryColor,
                                value: false,
                                groupValue:
                                    controller.reasonPartsReplacement.status,
                                onChanged: (bool? value) {
                                  setState(() {
                                    controller.reasonPartsReplacement.status =
                                        value!;
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
                            ButtonComponent(
                                onPressed: () {
                                  handleCreate(context);
                                },
                                text: 'Adicionar'),
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
    // TODO: implement initState
    super.initState();
    //Iniciliza controlador
    controller = ReasonPartsReplacementController();
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
                  TitleComponent('Motivos de troca de peças aaa'),
                  ButtonComponent(
                      onPressed: () {
                        showDialogCreate(context);
                      },
                      text: 'Adicionar')
                ],
              ),
            ),
            Divider(),
            Row(
              children: [
                Expanded(child: TextComponent('ID')),
                Expanded(child: TextComponent('Nome')),
                Expanded(child: TextComponent('Status')),
                Expanded(child: TextComponent('Opções')),
              ],
            ),
            Divider(),
            controller.isLoaded
                ? Container(
                    height: media.size.height * 0.8,
                    child: ListView.builder(
                      itemCount: controller.reasonPartsReplacements.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            color: (index % 2) == 0
                                ? Colors.white
                                : Colors.grey.shade50,
                            child: Row(
                              children: [
                                Expanded(
                                    child: TextComponent(controller
                                        .reasonPartsReplacements[index].id
                                        .toString())),
                                Expanded(
                                    child: TextComponent(controller
                                        .reasonPartsReplacements[index].name!)),
                                Expanded(
                                    child: Row(
                                  children: [
                                    StatusComponent(
                                        status: controller
                                            .reasonPartsReplacements[index]
                                            .status!),
                                  ],
                                )),
                                Expanded(
                                  child: Row(
                                    children: [
                                      IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.grey.shade400,
                                          ),
                                          onPressed: () => {
                                                handleDelete(
                                                    context,
                                                    controller
                                                            .reasonPartsReplacements[
                                                        index]),
                                              })
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

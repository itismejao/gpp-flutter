import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/MotivoTrocaPecaController.dart';
import 'package:gpp/src/models/reason_parts_replacement_model.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/InputComponent.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/components/status_component.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';

import 'package:gpp/src/shared/repositories/styles.dart';

class MotivosTrocaPecasListView extends StatefulWidget {
  const MotivosTrocaPecasListView({Key? key}) : super(key: key);

  @override
  _MotivosTrocaPecasListViewState createState() =>
      _MotivosTrocaPecasListViewState();
}

class _MotivosTrocaPecasListViewState extends State<MotivosTrocaPecasListView> {
  late MotivoTrocaPecaController controller;

  fetchAll() async {
    //Carrega lista de motivos de defeito de peças
    controller.motivoTrocaPecas = await controller.repository.buscarTodos();

    //controller.isLoaded = true;

    //Notifica a tela para atualizar os dados
    setState(() {
      controller.isLoaded = true;
    });
  }

  handleDelete(context, MotivoTrocaPecaModel reasonPartsReplacement) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await notify
          .confirmacao("você deseja excluir o motivo de troca de peça ?")) {
        if (await controller.repository.excluir(reasonPartsReplacement)) {
          notify.sucess("Funcionalidade excluída!");
          //Atualiza a lista de motivos
          fetchAll();
        }
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  handleCreate(context, MotivoTrocaPecaModel reasonPartsReplacement) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await controller.repository.create(reasonPartsReplacement)) {
        Navigator.pop(context);
        fetchAll();
        notify.sucess('Motivo de peça adicionado com sucesso!');
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  handleUpdate(context, MotivoTrocaPecaModel reasonPartsReplacement) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await controller.repository.update(reasonPartsReplacement)) {
        Navigator.pop(context);
        fetchAll();
        notify.sucess('Motivo de peça atualizado com sucesso!');
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  openForm(context, MotivoTrocaPecaModel reasonPartsReplacement) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: reasonPartsReplacement.idMotivoTrocaPeca == null
                  ? Text("Adicionar motivo de troca de peça")
                  : Text("Atualizar motivo de troca de peça"),
              content: new Text("preencha as informações abaixo"),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      InputComponent(
                        label: 'Nome',
                        initialValue: reasonPartsReplacement.nome,
                        hintText: 'Digite o motivo da troca de peça',
                        onChanged: (value) {
                          setState(() {
                            reasonPartsReplacement.nome = value!;
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
                                groupValue: reasonPartsReplacement.situacao,
                                onChanged: (bool? value) {
                                  setState(() {
                                    reasonPartsReplacement.situacao = value!;
                                  });
                                }),
                            Text("Habilitado"),
                            Radio(
                                activeColor: secundaryColor,
                                value: false,
                                groupValue: reasonPartsReplacement.situacao,
                                onChanged: (bool? value) {
                                  setState(() {
                                    reasonPartsReplacement.situacao = value!;
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
                            reasonPartsReplacement.idMotivoTrocaPeca == null
                                ? ButtonComponent(
                                    onPressed: () {
                                      handleCreate(
                                          context, reasonPartsReplacement);
                                    },
                                    text: 'Adicionar')
                                : ButtonComponent(
                                    onPressed: () {
                                      handleUpdate(
                                          context, reasonPartsReplacement);
                                    },
                                    text: 'Atualizar'),
                            SizedBox(
                              width: 8,
                            ),
                            ButtonComponent(
                                color: Colors.red,
                                onPressed: () {
                                  handleCreate(context, reasonPartsReplacement);
                                },
                                text: 'Cancelar')
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
    controller = MotivoTrocaPecaController();
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
                  Flexible(child: TitleComponent('Motivos de troca de peças')),
                  ButtonComponent(
                      onPressed: () {
                        openForm(context, controller.motivoTrocaPeca);
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
                    height: media.size.height * 0.5,
                    child: ListView.builder(
                      itemCount: controller.motivoTrocaPecas.length,
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
                                        .motivoTrocaPecas[index]
                                        .idMotivoTrocaPeca
                                        .toString())),
                                Expanded(
                                    child: TextComponent(controller
                                        .motivoTrocaPecas[index].nome!)),
                                Expanded(
                                    child: Row(
                                  children: [
                                    StatusComponent(
                                        status: controller
                                            .motivoTrocaPecas[index].situacao!),
                                  ],
                                )),
                                Expanded(
                                  child: Row(
                                    children: [
                                      IconButton(
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.grey.shade400,
                                          ),
                                          onPressed: () {
                                            openForm(
                                                context,
                                                controller
                                                    .motivoTrocaPecas[index]);
                                          }),
                                      IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.grey.shade400,
                                          ),
                                          onPressed: () => {
                                                handleDelete(
                                                    context,
                                                    controller.motivoTrocaPecas[
                                                        index]),
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

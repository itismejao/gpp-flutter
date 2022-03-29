import 'package:flutter/material.dart';

import 'package:gpp/src/controllers/MotivoTrocaPecaController.dart';
import 'package:gpp/src/models/reason_parts_replacement_model.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/InputComponent.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/components/status_component.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';

import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/utils/notificacao.dart';
import 'package:gpp/src/views/widgets/button_acao_widget.dart';
import 'package:gpp/src/views/widgets/card_widget.dart';

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

    //Notifica a tela para atualizar os dados
    setState(() {
      controller.isLoaded = true;
    });
  }

  handleDelete(context, MotivoTrocaPecaModel reasonPartsReplacement) async {
    try {
      if (await Notificacao.confirmacao(
          "você deseja excluir o motivo de troca de peça ?")) {
        if (await controller.repository.excluir(reasonPartsReplacement)) {
          Notificacao.snackBar(
              'Motivo de troca de peça excluido com sucesso !');
          //Atualiza a lista de motivos
          fetchAll();
        }
      }
    } catch (e) {
      Notificacao.snackBar(e.toString());
    }
  }

  handleCreate(context, MotivoTrocaPecaModel reasonPartsReplacement) async {
    try {
      if (await controller.repository.create(reasonPartsReplacement)) {
        Navigator.pop(context);
        fetchAll();
        Notificacao.snackBar('Motivo de peça adicionado com sucesso!');
      }
    } catch (e) {
      Notificacao.snackBar(e.toString());
    }
  }

  handleUpdate(context, MotivoTrocaPecaModel reasonPartsReplacement) async {
    try {
      if (await controller.repository.update(reasonPartsReplacement)) {
        Navigator.pop(context);
        fetchAll();
        Notificacao.snackBar('Motivo de peça atualizado com sucesso!');
      }
    } catch (e) {
      Notificacao.snackBar(e.toString());
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
    return Container(
      color: Colors.white,
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
            controller.isLoaded
                ? Expanded(
                    child: ListView.builder(
                        itemCount: controller.motivoTrocaPecas.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            child: CardWidget(
                              widget: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: TextComponent(
                                        'ID',
                                        fontWeight: FontWeight.bold,
                                      )),
                                      Expanded(
                                          child: TextComponent('Motivo',
                                              fontWeight: FontWeight.bold)),
                                      Expanded(
                                          child: TextComponent('Status',
                                              fontWeight: FontWeight.bold)),
                                      Expanded(
                                          child: TextComponent('Opções',
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: TextComponent(
                                              '#${controller.motivoTrocaPecas[index].idMotivoTrocaPeca.toString()}')),
                                      Expanded(
                                          child: TextComponent(controller
                                              .motivoTrocaPecas[index].nome!)),
                                      Expanded(
                                          child: Row(
                                        children: [
                                          StatusComponent(
                                              status: controller
                                                  .motivoTrocaPecas[index]
                                                  .situacao!),
                                        ],
                                      )),
                                      Expanded(
                                        child: ButtonAcaoWidget(
                                          editar: () {
                                            openForm(
                                                context,
                                                controller
                                                    .motivoTrocaPecas[index]);
                                          },
                                          deletar: () {
                                            handleDelete(
                                                context,
                                                controller
                                                    .motivoTrocaPecas[index]);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }))
                : Center(child: LoadingComponent())
          ],
        ),
      ),
    );
  }
}

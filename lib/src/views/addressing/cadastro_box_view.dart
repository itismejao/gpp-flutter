import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/enderecamento_box_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/models/box_enderecamento_model.dart';
import 'package:gpp/src/shared/components/button_component.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/components/text_component.dart';
import 'package:gpp/src/shared/components/title_component.dart';


class CadastroBoxView extends StatefulWidget {
  const CadastroBoxView({ Key? key }) : super(key: key);

  @override
  _CadastroBoxViewState createState() => _CadastroBoxViewState();
}

class _CadastroBoxViewState extends State<CadastroBoxView> {
  late EnderecamentoBoxController controller;


  fetchAll() async {
    //Carrega lista de motivos de defeito de peças
    controller.boxEnderecamentoReplacements =
        await controller.repository.buscarTodos();

    controller.isLoaded = true;

    //Notifica a tela para atualizar os dados
    setState(() {
      controller.isLoaded = true;
    });
  }

  handleCreate(context,BoxEnderecamentoModel boxEnderecamentoReplacement) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await controller.repository.create(boxEnderecamentoReplacement)) {
        Navigator.pop(context);
        fetchAll();
        notify.sucess('Box adicionada com sucesso!');
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  handleDelete(context, BoxEnderecamentoModel boxEnderecamentoReplacement) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await notify
          .alert("você deseja excluir o Box?")) {
        if (await controller.repository.excluir(boxEnderecamentoReplacement)) {
          notify.sucess("Box excluído!");
          //Atualiza a lista de motivos
          fetchAll();
        }
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }
openForm(context, BoxEnderecamentoModel boxEnderecamentoReplacement) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: boxEnderecamentoReplacement.id_box == null
                  ? Text("Cadastro do Box")
                  : Text("Atualizar motivo de troca de peça"),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      InputComponent(
                        label: 'Box',
                        initialValue: boxEnderecamentoReplacement.desc_box,
                        hintText: 'Digite o nome do Box',
                        onChanged: (value) {
                          setState(() {
                            boxEnderecamentoReplacement.desc_box = value!;
                          });
                        },
                      ),
                 
                       InputComponent(
                        label: 'Corredor',
                        initialValue: boxEnderecamentoReplacement.id_box.toString(),
                        hintText: 'Digite o corredor',
                        onChanged: (value) {
                          setState(() {
                            boxEnderecamentoReplacement.id_box = 500;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: Row(
                          children: [
                            boxEnderecamentoReplacement.id_box == null
                                ? ButtonComponent(
                                    onPressed: () {
                                      handleCreate(
                                          context, boxEnderecamentoReplacement);
                                    },
                                    text: 'Adicionar')
                                :ButtonComponent(
                                    color: Colors.red,
                                    onPressed: () {
                                      handleCreate(context, boxEnderecamentoReplacement);
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
    controller = EnderecamentoBoxController();
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
                  Flexible(child: TitleComponent('Prateleira')),
                  ButtonComponent(
                      onPressed: () {
                        openForm(context, controller.boxEnderecamentoReplacement);
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
            controller.isLoaded
                ? Container(
                    height: media.size.height * 0.5,
                    child: ListView.builder(
                      itemCount: controller.boxEnderecamentoReplacements.length,
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
                                        .boxEnderecamentoReplacements[index].desc_box!)),
                                Expanded(
                                    child: Row(
                                )),
                                Expanded(
                                  child: Row(
                                    children: [
                                        ButtonComponent(
                                          onPressed: () {
                                           // openForm(context, controller.corredorEnderecamentoReplacement);
                                          },
                                          text: 'Box'),
                                      IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.grey.shade400,
                                          ),
                                          onPressed: () => {
                                                handleDelete(
                                                    context,
                                                    controller
                                                            .boxEnderecamentoReplacements[
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

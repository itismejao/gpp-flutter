import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/enderecamento_estante_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/models/estante_enderecamento_model.dart';
import 'package:gpp/src/shared/components/button_component.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/components/text_component.dart';
import 'package:gpp/src/shared/components/title_component.dart';


class CadastroEstanteView extends StatefulWidget {
  const CadastroEstanteView({ Key? key }) : super(key: key);

  @override
  _CadastroEstanteViewState createState() => _CadastroEstanteViewState();
}

class _CadastroEstanteViewState extends State<CadastroEstanteView> {
  late EnderecamentoEstanteController controller;


  fetchAll() async {
    //Carrega lista de motivos de defeito de peças
    controller.estanteEnderecamentoReplacements =
        await controller.repository.buscarTodos();

    controller.isLoaded = true;

    //Notifica a tela para atualizar os dados
    setState(() {
      controller.isLoaded = true;
    });
  }

  handleCreate(context, EstanteEnderecamentoModel estanteEnderecamentoReplacement) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await controller.repository.create(estanteEnderecamentoReplacement)) {
        Navigator.pop(context);
        fetchAll();
        notify.sucess('Estante adicionada com sucesso!');
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  handleDelete(context, EstanteEnderecamentoModel estanteEnderecamentoReplacement) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await notify
          .alert("você deseja excluir a estante?")) {
        if (await controller.repository.excluir(estanteEnderecamentoReplacement)) {
          notify.sucess("Estante excluída!");
          //Atualiza a lista de motivos
          fetchAll();
        }
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }
openForm(context, EstanteEnderecamentoModel estanteEnderecamentoReplacement) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: estanteEnderecamentoReplacement.id_corredor == null
                  ? Text("Cadastro da Estante")
                  : Text("Atualizar motivo de troca de peça"),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      InputComponent(
                        label: 'Estante',
                        initialValue: estanteEnderecamentoReplacement.desc_estante,
                        hintText: 'Digite o nome da Estante',
                        onChanged: (value) {
                          setState(() {
                            estanteEnderecamentoReplacement.desc_estante = value!;
                          });
                        },
                      ),
                 
                       InputComponent(
                        label: 'Corredor',
                        initialValue: estanteEnderecamentoReplacement.id_estante.toString(),
                        hintText: 'Digite o corredor',
                        onChanged: (value) {
                          setState(() {
                            estanteEnderecamentoReplacement.id_estante = 500;
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
                            estanteEnderecamentoReplacement.id_estante == null
                                ? ButtonComponent(
                                    onPressed: () {
                                      handleCreate(
                                          context, estanteEnderecamentoReplacement);
                                    },
                                    text: 'Adicionar')
                                :ButtonComponent(
                                    color: Colors.red,
                                    onPressed: () {
                                      handleCreate(context, estanteEnderecamentoReplacement);
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
    controller = EnderecamentoEstanteController();
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
                  Flexible(child: TitleComponent('Estante')),
                  ButtonComponent(
                      onPressed: () {
                        openForm(context, controller.estanteEnderecamentoReplacement);
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
                      itemCount: controller.estanteEnderecamentoReplacements.length,
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
                                        .estanteEnderecamentoReplacements[index].desc_estante!)),
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
                                          text: 'Prateleira'),
                                      IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.grey.shade400,
                                          ),
                                          onPressed: () => {
                                                handleDelete(
                                                    context,
                                                    controller
                                                            .estanteEnderecamentoReplacements[
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

import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/enderecamento_corredor_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/models/corredor_enderecamento_model.dart';
import 'package:gpp/src/shared/components/button_component.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/components/text_component.dart';
import 'package:gpp/src/shared/components/title_component.dart';


class CadastroCorredorView extends StatefulWidget {
  const CadastroCorredorView({ Key? key }) : super(key: key);

  @override
  _CadastroCorredorViewState createState() => _CadastroCorredorViewState();
}

class _CadastroCorredorViewState extends State<CadastroCorredorView> {
  late EnderecamentoCorredorController controller;


  fetchAll() async {
    //Carrega lista de motivos de defeito de peças
    controller.corredorEnderecamentoReplacements =
        await controller.repository.buscarTodos();

    controller.isLoaded = true;

    //Notifica a tela para atualizar os dados
    setState(() {
      controller.isLoaded = true;
    });
  }

  handleCreate(context, CorredorEnderecamentoModel corredorEnderecamentoReplacement) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await controller.repository.create(corredorEnderecamentoReplacement)) {
        Navigator.pop(context);
        fetchAll();
        notify.sucess('Peça adicionado com sucesso!');
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  handleDelete(context, CorredorEnderecamentoModel corredorEnderecamentoReplacement) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await notify
          .alert("você deseja excluir o corredor?")) {
        if (await controller.repository.excluir(corredorEnderecamentoReplacement)) {
          notify.sucess("Corredor excluído!");
          //Atualiza a lista de motivos
          fetchAll();
        }
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }
openForm(context, CorredorEnderecamentoModel corredorEnderecamentoReplacement) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: corredorEnderecamentoReplacement.id_corredor == null
                  ? Text("Cadastro do Piso")
                  : Text("Atualizar motivo de troca de peça"),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      InputComponent(
                        label: 'Corredor',
                        initialValue: corredorEnderecamentoReplacement.desc_corredor,
                        hintText: 'Digite o nome do Corredor',
                        onChanged: (value) {
                          setState(() {
                            corredorEnderecamentoReplacement.desc_corredor = value!;
                          });
                        },
                      ),
                      InputComponent(
                        label: 'Filial',
                        initialValue: corredorEnderecamentoReplacement.id_filial.toString(),
                        hintText: 'Digite a filial',
                        onChanged: (value) {
                          setState(() {
                            corredorEnderecamentoReplacement.id_filial = 500;
                          });
                        },
                      ),
                       InputComponent(
                        label: 'Piso',
                        initialValue: corredorEnderecamentoReplacement.id_piso.toString(),
                        hintText: 'Digite o piso',
                        onChanged: (value) {
                          setState(() {
                            corredorEnderecamentoReplacement.id_piso = 500;
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
                            corredorEnderecamentoReplacement.id_corredor == null
                                ? ButtonComponent(
                                    onPressed: () {
                                      handleCreate(
                                          context, corredorEnderecamentoReplacement);
                                    },
                                    text: 'Adicionar')
                                :ButtonComponent(
                                    color: Colors.red,
                                    onPressed: () {
                                      handleCreate(context, corredorEnderecamentoReplacement);
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
    controller = EnderecamentoCorredorController();
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
                  Flexible(child: TitleComponent('Corredor')),
                  ButtonComponent(
                      onPressed: () {
                        openForm(context, controller.corredorEnderecamentoReplacement);
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
                      itemCount: controller.corredorEnderecamentoReplacements.length,
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
                                      child: 
                                      TextComponent(controller.
                                      corredorEnderecamentoReplacements[index].desc_corredor!)),
                                Expanded(
                                    child: Row(
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
                                                        .corredorEnderecamentoReplacements[
                                                    index]);
                                          }),
                                      IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.grey.shade400,
                                          ),
                                          onPressed: () => {
                                                handleDelete(
                                                    context,
                                                    controller
                                                            .corredorEnderecamentoReplacements[
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
//}
import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/enderecamento_controller.dart';
import 'package:gpp/src/controllers/enderecamento_prateleira_cotroller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/models/prateleira_enderecamento_model.dart';
import 'package:gpp/src/shared/components/button_component.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/components/text_component.dart';
import 'package:gpp/src/shared/components/title_component.dart';


class CadastroPrateleiraView extends StatefulWidget {

    //  String? idEstante;
  //  CadastroCorredorView({this.idEstante});
        
 // int id;

 //CadastroCorredorView({ Key? key, required this.id } ) : super(key: key);
  const CadastroPrateleiraView({ Key? key }) : super(key: key);

  @override
  _CadastroPrateleiraViewState createState() => _CadastroPrateleiraViewState();
}

class _CadastroPrateleiraViewState extends State<CadastroPrateleiraView> {
  //late EnderecamentoPrateleiraController controller;
  String? idEstante;
  
  late EnderecamentoController enderecamentoController;


  fetchAll(idEstante) async {
    //Carrega lista de motivos de defeito de peças
    enderecamentoController.listaPrateleira =
        await enderecamentoController.repository.buscarPrateleira(idEstante);

    enderecamentoController.isLoaded = true;

    //Notifica a tela para atualizar os dados
    setState(() {
      enderecamentoController.isLoaded = true;
    });
  }

  // handleCreate(context,PrateleiraEnderecamentoModel prateleiraEnderecamentoReplacement) async {
  //   NotifyController notify = NotifyController(context: context);
  //   try {
  //     if (await controller.repository.create(prateleiraEnderecamentoReplacement)) {
  //       Navigator.pop(context);
  //       fetchAll();
  //       notify.sucess('Prateleira adicionada com sucesso!');
  //     }
  //   } catch (e) {
  //     notify.error(e.toString());
  //   }
  // }

  // handleDelete(context, PrateleiraEnderecamentoModel prateleiraEnderecamentoReplacement) async {
  //   NotifyController notify = NotifyController(context: context);
  //   try {
  //     if (await notify
  //         .alert("você deseja excluir a prateleira?")) {
  //       if (await controller.repository.excluir(prateleiraEnderecamentoReplacement)) {
  //         notify.sucess("Prateleira excluída!");
  //         //Atualiza a lista de motivos
  //         fetchAll();
  //       }
  //     }
  //   } catch (e) {
  //     notify.error(e.toString());
  //   }
  // }
openForm(context, PrateleiraEnderecamentoModel prateleiraEnderecamentoReplacement) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: prateleiraEnderecamentoReplacement.id_prateleira == null
                  ? Text("Cadastro da Prateleira")
                  : Text("Atualizar motivo de troca de peça"),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      InputComponent(
                        label: 'Prateleira',
                        initialValue: prateleiraEnderecamentoReplacement.desc_prateleira,
                        hintText: 'Digite o nome da Prateleira',
                        onChanged: (value) {
                          setState(() {
                            prateleiraEnderecamentoReplacement.desc_prateleira = value!;
                          });
                        },
                      ),
                 
                       InputComponent(
                        label: 'Corredor',
                        initialValue: prateleiraEnderecamentoReplacement.id_prateleira.toString(),
                        hintText: 'Digite o corredor',
                        onChanged: (value) {
                          setState(() {
                            prateleiraEnderecamentoReplacement.id_prateleira = 500;
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
                            prateleiraEnderecamentoReplacement.id_prateleira == null
                                ? ButtonComponent(
                                    onPressed: () {
                                      // handleCreate(
                                      //     context, prateleiraEnderecamentoReplacement);
                                    },
                                    text: 'Adicionar')
                                :ButtonComponent(
                                    color: Colors.red,
                                    onPressed: () {
                                      // handleCreate(context, prateleiraEnderecamentoReplacement);
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
    // controller = EnderecamentoPrateleiraController();
    enderecamentoController = EnderecamentoController();
    //Quando o widget for inserido na árvore chama o fetchAll
    fetchAll('5');
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
                        openForm(context, enderecamentoController.prateleiraModel);
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
                      itemCount: enderecamentoController.listaPrateleira.length,
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
                                      child: TextComponent(enderecamentoController.listaPrateleira[index].desc_prateleira.toString()),),
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
                                                // handleDelete(
                                                //     context,
                                                //     controller
                                                //             .prateleiraEnderecamentoReplacements[
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

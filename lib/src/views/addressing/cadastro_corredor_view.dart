import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/enderecamento_controller.dart';
import 'package:gpp/src/controllers/enderecamento_corredor_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/models/corredor_enderecamento_model.dart';
import 'package:gpp/src/shared/components/button_component.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/components/text_component.dart';
import 'package:gpp/src/shared/components/title_component.dart';


class CadastroCorredorView extends StatefulWidget {
   
  //  String? idPiso;
  //  CadastroCorredorView({this.idPiso});
        
 // int id;

 //CadastroCorredorView({ Key? key, required this.id } ) : super(key: key);
 const CadastroCorredorView({ Key? key }) : super(key: key);

  @override
  _CadastroCorredorViewState createState() => _CadastroCorredorViewState();
}

class _CadastroCorredorViewState extends State<CadastroCorredorView> {
  //late EnderecamentoCorredorController controller;
  String? idPiso;
  
  late EnderecamentoController enderecamentoController;



  fetchAll(String idPiso) async {
    //Carrega lista de motivos de defeito de peças
    enderecamentoController.listaCorredor =
    await enderecamentoController.buscarCorredor(idPiso);


    enderecamentoController.isLoaded = true;

    //Notifica a tela para atualizar os dados
    setState(() {
      enderecamentoController.isLoaded = true;
    });
  }

  // handleCreate(context, CorredorEnderecamentoModel corredorEnderecamentoReplacement) async {
  //   NotifyController notify = NotifyController(context: context);
  //   try {
  //     if (await controller.repository.create(corredorEnderecamentoReplacement)) {
  //       Navigator.pop(context);
  //       fetchAll();
  //       notify.sucess('Motivo de peça adicionado com sucesso!');
  //     }
  //   } catch (e) {
  //     notify.error(e.toString());
  //   }
  // }

  // handleDelete(context, CorredorEnderecamentoModel corredorEnderecamentoReplacement) async {
  //   NotifyController notify = NotifyController(context: context);
  //   try {
  //     if (await notify
  //         .alert("você deseja excluir o corredor?")) {
  //       if (await controller.repository.excluir(corredorEnderecamentoReplacement)) {
  //         notify.sucess("Corredor excluído!");
  //         //Atualiza a lista de motivos
  //         fetchAll();
  //       }
  //     }
  //   } catch (e) {
  //     notify.error(e.toString());
  //   }
  // }
openForm(context, CorredorEnderecamentoModel corredorEnderecamentoReplacement) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Cadastro do Piso"),
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
                        label: 'Piso',
                        initialValue: corredorEnderecamentoReplacement.id_piso.toString(),
                        hintText: 'Digite o piso',
                        onChanged: (value) {
                          setState(() {
                          //  corredorEnderecamentoReplacement.id_piso = corredorEnderecamentoModel;
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
                                 ButtonComponent(
                                    onPressed: () {
                                      // handleCreate(
                                      //     context, corredorEnderecamentoReplacement);
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
    enderecamentoController = EnderecamentoController();
   // corredorEnderecamentoModel = widget.corredorEnderecamentoModel;
    //Quando o widget for inserido na árvore chama o fetchAll
    fetchAll('2');
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
                        openForm(context, enderecamentoController.corredorModel);
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
                    height: media.size.height * 0.3,
                    child: ListView.builder(
                      itemCount: enderecamentoController.listaCorredor.length,
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
                                      TextComponent(enderecamentoController.listaCorredor[index].desc_corredor.toString()),),
                                   
                                Expanded(
                                  child: Row(
                                  //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                        ButtonComponent(
                                          onPressed: () {
                                            
                                           // openForm(context, controller.corredorEnderecamentoReplacement);
                                          },
                                          text: 'Estante'),
                                      IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.grey.shade400,
                                          ),
                                          onPressed: () => {
                                                // handleDelete(
                                                //     context,
                                                //     controller
                                                //             .corredorEnderecamentoReplacements[
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

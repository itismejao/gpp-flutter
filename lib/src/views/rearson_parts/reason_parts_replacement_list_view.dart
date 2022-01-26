import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/reason_parts_replacement_controller.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/components/text_component.dart';
import 'package:gpp/src/shared/components/title_component.dart';

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
    print('valor da váriavel isLoeaded: ' + controller.isLoaded.toString());

    final media = MediaQuery.of(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Row(
                children: [TitleComponent('Motivos de troca de peças')],
              ),
            ),
            Divider(),
            Row(
              children: [
                Expanded(child: TextComponent('ID')),
                Expanded(child: TextComponent('Nome')),
                Expanded(child: TextComponent('Status')),
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
                                        .reasonPartsReplacements[index].name)),
                                Expanded(child: TextComponent('status')),
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

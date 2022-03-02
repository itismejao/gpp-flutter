import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_controller.dart';
import 'package:gpp/src/models/pecas_model/pecas_model.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/InputComponent.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/views/pecas/pecas_detail_view.dart';
import 'package:gpp/src/views/pecas/pecas_edit_view.dart';
import 'package:gpp/src/views/pecas/pop_up_editar.dart';

class PecasListView extends StatefulWidget {
  const PecasListView({Key? key}) : super(key: key);

  @override
  _PecasListViewState createState() => _PecasListViewState();
}

class _PecasListViewState extends State<PecasListView> {
  PecasController _pecasController = PecasController();

  excluir(PecasModel pecasModel) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await _pecasController.excluir(pecasModel)) {
        notify.sucess("Peça excluída com sucesso!");
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  editar() async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await true) {
        notify.sucess("Peça alterada com sucesso!");
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitleComponent(
                      'Peças',
                    ),
                  ],
                ),
              ),
              // _buildState()
            ],
          ),
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // CheckboxComponent(),
            Expanded(
              child: TextComponent(
                'ID',
              ),
            ),
            Expanded(
              child: TextComponent('Número'),
            ),
            Expanded(
              child: TextComponent('Cod. Fabrica'),
            ),
            Expanded(
              child: TextComponent('Descrição'),
            ),
            Expanded(
              child: Text(
                'Opções',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                // textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Divider(),
        FutureBuilder(
          future: _pecasController.buscarTodos(),
          builder: (context, AsyncSnapshot<List<PecasModel>> snapshot) {
            // List<PecasModel> _pecas = snapshot.data ?? [];

            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('none');
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                return Text('');
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  );
                } else {
                  return Container(
                    height: 500,
                    child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Padding(padding: EdgeInsets.only(left: 10)),
                              // CheckboxComponent(),
                              Expanded(
                                child: Text(
                                  snapshot.data![index].id_peca.toString(),
                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                  // textAlign: TextAlign.start,
                                ),
                              ),
                              Expanded(
                                child: Text(snapshot.data![index].numero.toString()),
                              ),
                              Expanded(
                                child: Text(snapshot.data![index].codigo_fabrica == null
                                    ? ''
                                    : snapshot.data![index].codigo_fabrica.toString()),
                              ),
                              Expanded(
                                child: Text(snapshot.data![index].descricao.toString()),
                              ),

                              Expanded(
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.visibility),
                                      color: Colors.grey.shade400,
                                      onPressed: () {
                                        PopUpEditar.popUpPeca(
                                                context, PecasEditAndView(pecasEditPopup: snapshot.data![index], enabled: false))
                                            .then((value) => setState(() {}));
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.grey.shade400,
                                      ),
                                      onPressed: () {
                                        PopUpEditar.popUpPeca(
                                                context, PecasEditAndView(pecasEditPopup: snapshot.data![index], enabled: true))
                                            .then((value) => setState(() {}));
                                      },
                                    ),
                                    IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.grey.shade400,
                                        ),
                                        onPressed: () {
                                          // _pecasController.excluir(snapshot.data![index]).then((value) => setState(() {}));
                                          setState(() {
                                            excluir(snapshot.data![index]);
                                          });
                                        }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
            }
          },
        ),
      ],
    );
  }
}

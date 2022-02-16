import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_linha_controller.dart';
import 'package:gpp/src/models/pecas_model/pecas_linha_model.dart';
import 'package:gpp/src/shared/components/button_component.dart';
import 'package:gpp/src/shared/components/checkbox_component.dart';
import 'package:gpp/src/shared/components/text_component.dart';
import 'package:gpp/src/shared/components/title_component.dart';

class LinhaListView extends StatefulWidget {
  const LinhaListView({Key? key}) : super(key: key);

  @override
  _LinhaListViewState createState() => _LinhaListViewState();
}

class _LinhaListViewState extends State<LinhaListView> {
  PecasLinhaController _pecasLinhaController = PecasLinhaController();

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
                      'Linha',
                    ),
                    ButtonComponent(
                        onPressed: () {
                          Navigator.pushNamed(context, '/rota');
                        },
                        icon: Icon(Icons.add, color: Colors.white),
                        text: 'Adicionar')
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
            CheckboxComponent(),
            Expanded(
              child: TextComponent(
                'ID',
              ),
            ),
            Expanded(
              child: TextComponent('Linha'),
            ),
            Expanded(
              child: TextComponent('Situação'),
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
          future: _pecasLinhaController.buscarTodos(),
          builder: (context, AsyncSnapshot snapshot) {
            List<PecasLinhaModel> _pecasLinha = snapshot.data ?? [];

            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              return Container(
                width: 1000,
                height: 500,
                child: ListView.builder(
                  itemCount: _pecasLinha.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Padding(padding: EdgeInsets.only(left: 10)),
                          CheckboxComponent(),
                          Expanded(
                            child: Text(
                              _pecasLinha[index].id_peca_linha.toString(),
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                              // textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: Text(_pecasLinha[index].linha.toString()),
                          ),
                          Expanded(
                            child: Text(_pecasLinha[index].situacao.toString()),
                          ),

                          Expanded(
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.grey.shade400,
                                  ),
                                  onPressed: () => {},
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.grey.shade400,
                                  ),
                                  onPressed: () => {},
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.grey.shade400,
                                    ),
                                    onPressed: () {}),
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
          },
        ),
      ],
    );
  }
}

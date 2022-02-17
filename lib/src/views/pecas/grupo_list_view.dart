import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_grupo_controller.dart';
import 'package:gpp/src/models/pecas_model/pecas_grupo_model.dart';
import 'package:gpp/src/models/pecas_model/pecas_linha_model.dart';
import 'package:gpp/src/shared/components/button_component.dart';
import 'package:gpp/src/shared/components/checkbox_component.dart';
import 'package:gpp/src/shared/components/text_component.dart';
import 'package:gpp/src/shared/components/title_component.dart';
import 'package:gpp/src/views/pecas/situacao.dart';

class GrupoListView extends StatefulWidget {
  const GrupoListView({Key? key}) : super(key: key);

  @override
  _GrupoListViewState createState() => _GrupoListViewState();
}

class _GrupoListViewState extends State<GrupoListView> {
  PecasGrupoController _pecasGrupoController = PecasGrupoController();

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
                      'Grupo de Fabricação',
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
              child: TextComponent('Grupo'),
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
          future: _pecasGrupoController.buscarTodos(),
          builder: (context, AsyncSnapshot snapshot) {
            List<PecasGrupoModel> _pecasGrupo = snapshot.data ?? [];

            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              return Container(
                height: 500,
                child: ListView.builder(
                  itemCount: _pecasGrupo.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Padding(padding: EdgeInsets.only(left: 10)),
                          CheckboxComponent(),
                          Expanded(
                            child: Text(
                              _pecasGrupo[index].id_peca_grupo_material.toString(),
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                              // textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: Text(_pecasGrupo[index].grupo.toString()),
                          ),
                          Expanded(
                            child: Text(Situacao.values[_pecasGrupo[index].situacao!].name),
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

import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_grupo_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_material_controller.dart';
import 'package:gpp/src/shared/components/button_component.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/components/text_component.dart';
import 'package:gpp/src/shared/components/title_component.dart';

class MaterialDetailView extends StatefulWidget {
  const MaterialDetailView({Key? key}) : super(key: key);

  @override
  _MaterialDetailViewState createState() => _MaterialDetailViewState();
}

class _MaterialDetailViewState extends State<MaterialDetailView> {
  PecasGrupoController _pecasGrupoController = PecasGrupoController();
  PecasMaterialController _pecasMaterialController = PecasMaterialController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 16, bottom: 16),
          child: Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 20)),
              Icon(Icons.add_box),
              Padding(padding: EdgeInsets.only(right: 12)),
              TitleComponent('Cadastrar Material de Fabricação'),
            ],
          ),
        ),
        Divider(),
        Column(
          children: [
            Padding(padding: EdgeInsets.only(bottom: 30)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(padding: EdgeInsets.only(bottom: 30)),
                Flexible(
                  child: InputComponent(
                    label: 'Grupo/Família',
                    onChanged: (value) {
                      _pecasGrupoController.pecasGrupoModel.grupo = value;
                      _pecasGrupoController.pecasGrupoModel.situacao = 1;
                    },
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 30)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonComponent(
                  onPressed: () {
                    _pecasGrupoController.create();
                  },
                  text: 'Salvar',
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 30)),
            Row(
              children: [
                Text(
                  'Cadastrar Material',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            Divider(),
            Padding(padding: EdgeInsets.only(bottom: 30)),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
                Padding(padding: EdgeInsets.only(right: 30)),
                Flexible(
                  child: InputComponent(
                    label: 'Nome do Material',
                    onChanged: (value) {
                      _pecasMaterialController.pecasMaterialModel.material = value;
                      _pecasMaterialController.pecasMaterialModel.sigla = value;
                      _pecasMaterialController.pecasMaterialModel.situacao = 1;
                      _pecasMaterialController.pecasMaterialModel.id_peca_grupo_material = 21;
                    },
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 30)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonComponent(
                  onPressed: () {
                    _pecasMaterialController.create();
                  },
                  text: 'Salvar',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

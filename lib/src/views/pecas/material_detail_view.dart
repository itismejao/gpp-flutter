import 'package:flutter/material.dart';
import 'package:gpp/src/shared/components/title_component.dart';

class MaterialDetailView extends StatefulWidget {
  const MaterialDetailView({Key? key}) : super(key: key);

  @override
  _MaterialDetailViewState createState() => _MaterialDetailViewState();
}

class _MaterialDetailViewState extends State<MaterialDetailView> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
    ]);
  }
}

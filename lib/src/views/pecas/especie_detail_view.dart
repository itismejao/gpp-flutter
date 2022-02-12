import 'package:flutter/material.dart';
import 'package:gpp/src/shared/components/title_component.dart';

class EspecieDetailView extends StatefulWidget {
  const EspecieDetailView({Key? key}) : super(key: key);

  @override
  _EspecieDetailViewState createState() => _EspecieDetailViewState();
}

class _EspecieDetailViewState extends State<EspecieDetailView> {
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
            TitleComponent('Cadastrar Espécie'),
          ],
        ),
      ),
      Divider(),
    ]);
  }
}

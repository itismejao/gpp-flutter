import 'package:flutter/material.dart';

class MaterialDetailView extends StatefulWidget {
  const MaterialDetailView({Key? key}) : super(key: key);

  @override
  _MaterialDetailViewState createState() => _MaterialDetailViewState();
}

class _MaterialDetailViewState extends State<MaterialDetailView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Material'),
      ],
    );
  }
}

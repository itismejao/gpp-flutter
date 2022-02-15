import 'package:flutter/material.dart';

class MaterialListView extends StatefulWidget {
  const MaterialListView({Key? key}) : super(key: key);

  @override
  _MaterialListViewState createState() => _MaterialListViewState();
}

class _MaterialListViewState extends State<MaterialListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Material'),
    );
  }
}

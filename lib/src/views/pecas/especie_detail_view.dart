import 'package:flutter/material.dart';

class EspecieDetailView extends StatefulWidget {
  const EspecieDetailView({Key? key}) : super(key: key);

  @override
  _EspecieDetailViewState createState() => _EspecieDetailViewState();
}

class _EspecieDetailViewState extends State<EspecieDetailView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Especie'),
      ],
    );
  }
}

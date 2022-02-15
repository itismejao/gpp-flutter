import 'package:flutter/material.dart';

class PecasListView extends StatefulWidget {
  const PecasListView({Key? key}) : super(key: key);

  @override
  _PecasListViewState createState() => _PecasListViewState();
}

class _PecasListViewState extends State<PecasListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Peças'),
    );
  }
}

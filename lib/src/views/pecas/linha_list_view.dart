import 'package:flutter/material.dart';

class LinhaListView extends StatefulWidget {
  const LinhaListView({Key? key}) : super(key: key);

  @override
  _LinhaListViewState createState() => _LinhaListViewState();
}

class _LinhaListViewState extends State<LinhaListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Linha'),
    );
  }
}

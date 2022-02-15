import 'package:flutter/material.dart';

class CoresListView extends StatefulWidget {
  const CoresListView({Key? key}) : super(key: key);

  @override
  _CoresListViewState createState() => _CoresListViewState();
}

class _CoresListViewState extends State<CoresListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Cores'),
    );
  }
}

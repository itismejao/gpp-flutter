import 'package:flutter/material.dart';

class CoresDetailView extends StatefulWidget {
  const CoresDetailView({Key? key}) : super(key: key);

  @override
  _CoresDetailViewState createState() => _CoresDetailViewState();
}

class _CoresDetailViewState extends State<CoresDetailView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Cores'),
      ],
    );
  }
}

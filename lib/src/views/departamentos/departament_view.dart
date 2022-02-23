import 'package:flutter/material.dart';
import 'package:gpp/src/views/departamentos/departament_list_view.dart';

class DepartamentView extends StatefulWidget {
  const DepartamentView({Key? key}) : super(key: key);

  @override
  _DepartamentViewState createState() => _DepartamentViewState();
}

class _DepartamentViewState extends State<DepartamentView> {
  @override
  void initState() {
    // ignore: todo
    // w
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DepartamentoListView(),
      //Expanded(child: DepartamentFormView()),
    );
  }
}

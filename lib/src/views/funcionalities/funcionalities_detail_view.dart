import 'package:flutter/material.dart';
import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/views/subfuncionalities/subfuncionalities_home_view.dart';

// ignore: must_be_immutable
class FuncionalitiesDetailView extends StatefulWidget {
  FuncionalitieModel funcionalitie;
  FuncionalitiesDetailView({Key? key, required this.funcionalitie})
      : super(key: key);

  @override
  State<FuncionalitiesDetailView> createState() =>
      _FuncionalitiesDetailViewState();
}

class _FuncionalitiesDetailViewState extends State<FuncionalitiesDetailView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SubFuncionalitiesHomeView(
        funcionalitie: widget.funcionalitie,
      ),
    );
  }
}

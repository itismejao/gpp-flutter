import 'package:flutter/material.dart';

import 'package:gpp/src/controllers/departament_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/models/departament_model.dart';
import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/models/subfuncionalities_model.dart';
import 'package:gpp/src/repositories/departament_repository.dart';
import 'package:gpp/src/shared/components/button_primary_component.dart';
import 'package:gpp/src/shared/enumeration/departament_enum.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:gpp/src/views/departaments/departament_form_view.dart';
import 'package:gpp/src/views/departaments/departament_list_view.dart';
import 'package:gpp/src/views/loading_view.dart';

class DepartamentView extends StatefulWidget {
  const DepartamentView({Key? key}) : super(key: key);

  @override
  _DepartamentViewState createState() => _DepartamentViewState();
}

class _DepartamentViewState extends State<DepartamentView> {
  late DepartamentController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        DepartamentController(repository: DepartamentRepository(api: gppApi));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Departamentos',
                    style: textStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700)),
                ButtonPrimaryComponent(
                    onPressed: () async {
                      bool confirm = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                actions: <Widget>[DepartamentFormView()]);
                          });

                      if (confirm) {
                        setState(() {
                          _controller.changeDepartament();
                        });
                      }
                    },
                    text: "Cadastrar")
              ],
            ),
          ),
          Expanded(child: DepartamentListView()),
          //Expanded(child: DepartamentFormView()),
        ],
      ),
    );
  }
}

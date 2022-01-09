import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/departament_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/models/departament_model.dart';
import 'package:gpp/src/repositories/departament_repository.dart';
import 'package:gpp/src/shared/components/button_primary_component.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class DepartamentFormView extends StatefulWidget {
  const DepartamentFormView({Key? key}) : super(key: key);

  @override
  State<DepartamentFormView> createState() => _DepartamentFormViewState();
}

class _DepartamentFormViewState extends State<DepartamentFormView> {
  late DepartamentController _controller;

  late DepartamentModel _departament;

  handleCreate(DepartamentModel departament, context) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await _controller.create(departament)) {
        Navigator.of(context, rootNavigator: true).pop(true);
        notify.sucess("Departamento cadastrado!");
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _departament = DepartamentModel();
    _controller =
        DepartamentController(repository: DepartamentRepository(api: gppApi));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Cadastrar Departamento",
            style: textStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 24,
          ),
          InputComponent(
            label: "Nome",
            prefixIcon: Icon(Icons.work),
            hintText: "Digite o nome do departamento",
            onChanged: (value) {
              _departament.name = value;
            },
            validator: (value) => _controller.validateInput(value),
          ),
          SizedBox(
            height: 14,
          ),
          ButtonPrimaryComponent(
              onPressed: () => {handleCreate(_departament, context)},
              text: "Adicionar")
        ],
      ),
    );
  }
}

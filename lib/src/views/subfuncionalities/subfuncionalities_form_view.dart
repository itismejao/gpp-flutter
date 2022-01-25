import 'package:flutter/material.dart';

import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/subfuncionalities_controller.dart';
import 'package:gpp/src/shared/components/button_component.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/components/title_component.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

// ignore: must_be_immutable
class SubFuncionalitiesFormView extends StatefulWidget {
  String id;
  SubFuncionalitiesFormView({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _SubFuncionalitiesFormViewState createState() =>
      _SubFuncionalitiesFormViewState();
}

class _SubFuncionalitiesFormViewState extends State<SubFuncionalitiesFormView> {
  SubFuncionalitiesController _controller = SubFuncionalitiesController();

  handleCreate() async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await _controller.create(widget.id)) {
        notify.sucess("Subfuncionalidade cadastrado!");
        Navigator.pushReplacementNamed(context, '/funcionalities');
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          key: _controller.formKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: TitleComponent('Cadastrar Subfuncionalidade'),
                ),
                InputComponent(
                  label: "Nome",
                  onChanged: (value) {
                    _controller.subFuncionalitie.name = value;
                  },
                  validator: (value) {
                    _controller.validate(value);
                  },
                  hintText: "Digite o nome da funcionalidade",
                  prefixIcon: Icon(Icons.lock),
                ),
                SizedBox(
                  height: 8,
                ),
                InputComponent(
                  label: "Rota",
                  onChanged: (value) {
                    _controller.subFuncionalitie.route = value;
                  },
                  validator: (value) {
                    _controller.validate(value);
                  },
                  hintText: "Digite a rota da subfuncionalidade",
                  prefixIcon: Icon(Icons.lock),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Radio(
                        activeColor: secundaryColor,
                        value: true,
                        groupValue: _controller.subFuncionalitie.active,
                        onChanged: (bool? value) {
                          setState(() {
                            _controller.subFuncionalitie.active = value;
                          });
                        }),
                    Text("Habilitado"),
                    Radio(
                        activeColor: secundaryColor,
                        value: false,
                        groupValue: _controller.subFuncionalitie.active,
                        onChanged: (bool? value) {
                          setState(() {
                            _controller.subFuncionalitie.active = value;
                          });
                        }),
                    Text("Desabilitado"),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Row(
                    children: [
                      ButtonComponent(
                        onPressed: () {
                          handleCreate();
                        },
                        text: 'Adicionar',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

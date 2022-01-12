import 'package:flutter/material.dart';

import 'package:gpp/src/controllers/funcionalities_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/repositories/funcionalities_repository.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

// ignore: must_be_immutable
class FuncionalitieFormUpdateView extends StatefulWidget {
  FuncionalitieModel funcionalitie;

  FuncionalitieFormUpdateView({
    Key? key,
    required this.funcionalitie,
  }) : super(key: key);

  @override
  _FuncionalitieFormUpdateViewState createState() =>
      _FuncionalitieFormUpdateViewState();
}

class _FuncionalitieFormUpdateViewState
    extends State<FuncionalitieFormUpdateView> {
  FuncionalitiesController _controlller =
      FuncionalitiesController(FuncionalitiesRepository(api: gppApi));

  handleUpdate(context, FuncionalitieModel funcionalitie) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await _controlller.update(funcionalitie)) {
        notify.sucess("Funcionalidade atualizada!");
        Navigator.pushReplacementNamed(context, 'funcionalitie_lists');
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _controlller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.funcionalitie.name,
                maxLength: 255,
                onChanged: (value) {
                  setState(() {
                    widget.funcionalitie.name = value;
                  });
                },
                validator: (value) => _controlller.validateInput(value),
                keyboardType: TextInputType.number,
                style: textStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 14,
                    height: 1.8),
                decoration: inputDecoration(
                    'Funcionalidade', const Icon(Icons.view_list)),
              ),
              TextFormField(
                initialValue: widget.funcionalitie.icon,
                maxLength: 255,
                onChanged: (value) {
                  setState(() {
                    widget.funcionalitie.icon = value;
                  });
                },
                validator: (value) => _controlller.validateInput(value),
                keyboardType: TextInputType.number,
                style: textStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 14,
                    height: 1.8),
                decoration:
                    inputDecoration('Icon', const Icon(Icons.account_box)),
              ),
              Row(
                children: [
                  Radio(
                      value: true,
                      groupValue: widget.funcionalitie.active,
                      onChanged: (bool? value) {
                        setState(() {
                          widget.funcionalitie.active = value;
                        });
                      }),
                  SizedBox(
                    width: 12,
                  ),
                  Text("Habilitado"),
                  Radio(
                      value: false,
                      groupValue: widget.funcionalitie.active,
                      onChanged: (bool? value) {
                        setState(() {
                          widget.funcionalitie.active = value;
                        });
                      }),
                  SizedBox(
                    width: 12,
                  ),
                  Text("Desabilitado"),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  ElevatedButton(
                      style: buttonStyle,
                      onPressed: () =>
                          handleUpdate(context, widget.funcionalitie),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text('Atualizar',
                            style: textStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                      )),
                ],
              )
            ],
          ),
        ));
  }
}

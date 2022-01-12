import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/funcionalities_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/repositories/funcionalities_repository.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class FuncionalitieFormCreateView extends StatefulWidget {
  const FuncionalitieFormCreateView({Key? key}) : super(key: key);

  @override
  _FuncionalitieFormCreateViewState createState() =>
      _FuncionalitieFormCreateViewState();
}

class _FuncionalitieFormCreateViewState
    extends State<FuncionalitieFormCreateView> {
  FuncionalitiesController _controlller =
      FuncionalitiesController(FuncionalitiesRepository(api: gppApi));

  handleCreate(context) async {
    NotifyController nofity = NotifyController(context: context);
    try {
      if (await _controlller.create()) {
        //Realiza notificação

        nofity.sucess("Funcionalidade cadastrada!");
        Navigator.pushReplacementNamed(context, '/funcionalities');
      }
    } catch (e) {
      nofity.error(e.toString());
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
                maxLength: 255,
                onSaved: (value) => _controlller.setFuncionalitieName(value),
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
                maxLength: 255,
                onSaved: (value) => _controlller.setFuncionalitieIcon(value),
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
                      groupValue: _controlller.funcionalitie.active,
                      onChanged: (value) {
                        setState(() {
                          _controlller.setFuncionalitieActive(value);
                        });
                      }),
                  SizedBox(
                    width: 12,
                  ),
                  Text("Habilitado"),
                  Radio(
                      value: false,
                      groupValue: _controlller.funcionalitie.active,
                      onChanged: (value) {
                        setState(() {
                          _controlller.setFuncionalitieActive(value);
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
                      onPressed: () => handleCreate(context),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text('Cadastrar',
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

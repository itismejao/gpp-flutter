import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/funcionalities_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

class FuncionalitiesFormView extends StatefulWidget {
  const FuncionalitiesFormView({Key? key}) : super(key: key);

  @override
  _FuncionalitiesFormViewState createState() => _FuncionalitiesFormViewState();
}

class _FuncionalitiesFormViewState extends State<FuncionalitiesFormView> {
  FuncionalitiesController _controller = FuncionalitiesController();

  handleCreate() async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await _controller.create()) {
        notify.sucess("Funcionalidade cadastrado!");
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 40),
                child: Text("Cadastrar funcionalidade",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              InputComponent(
                label: "Nome",
                maxLength: 50,
                onChanged: (value) {
                  _controller.funcionalitie.name = value;
                },
                validator: (value) {
                  _controller.validate(value);
                },
                hintText: "Digite o nome da funcionalidade",
                prefixIcon: Icon(Icons.lock),
              ),
              InputComponent(
                label: "Icon",
                maxLength: 50,
                onChanged: (value) {
                  _controller.funcionalitie.icon = value;
                },
                validator: (value) {
                  _controller.validate(value);
                },
                hintText: "Digite o código do icon",
                prefixIcon: Icon(Icons.lock),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Radio(
                        activeColor: secundaryColor,
                        value: true,
                        groupValue: _controller.funcionalitie.active,
                        onChanged: (bool? value) {
                          setState(() {
                            _controller.funcionalitie.active = value;
                          });
                        }),
                    Text("Habilitado"),
                    Radio(
                        activeColor: secundaryColor,
                        value: false,
                        groupValue: _controller.funcionalitie.active,
                        onChanged: (bool? value) {
                          setState(() {
                            _controller.funcionalitie.active = value;
                          });
                        }),
                    Text("Desabilitado"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        handleCreate();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: secundaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 25, bottom: 15, right: 25),
                          child: Text(
                            "Cadastrar",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

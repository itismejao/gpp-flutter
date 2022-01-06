import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/departament_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/models/departament_model.dart';
import 'package:gpp/src/models/subfuncionalities_model.dart';
import 'package:gpp/src/repositories/departament_repository.dart';
import 'package:gpp/src/shared/components/button_primary_component.dart';
import 'package:gpp/src/shared/enumeration/departament_enum.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class DepartamentDetailView extends StatefulWidget {
  DepartamentModel departament;

  DepartamentDetailView({
    Key? key,
    required this.departament,
  }) : super(key: key);

  @override
  _DepartamentDetailViewState createState() => _DepartamentDetailViewState();
}

class _DepartamentDetailViewState extends State<DepartamentDetailView> {
  late final DepartamentController _controller =
      DepartamentController(repository: DepartamentRepository(api: gppApi));

  changeDepartamentFuncionalities() async {
    if (mounted) {
      setState(() {
        _controller.state = DepartamentEnum.loading;
      });
    }
    await _controller.changeDepartamentSubFuncionalities(widget.departament);
    if (mounted) {
      setState(() {
        _controller.state = DepartamentEnum.changeDepartament;
      });
    }
  }

  handleCheckBox(bool? value, int index) {
    if (mounted) {
      setState(() {
        if (value!) {
          _controller.subFuncionalities[index].active = true;
        } else {
          _controller.subFuncionalities[index].active = false;
        }
      });
    }
  }

  void handleSalved(
    context,
  ) async {
    NotifyController nofity = NotifyController(context: context);
    if (await _controller.updateUserSubFuncionalities(
        widget.departament, _controller.subFuncionalities)) {
      nofity.sucess("Funcionalidade cadastrada!");
    } else {
      nofity.error("Departamento não atualizado !");
    }
  }

  @override
  initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    changeDepartamentFuncionalities();
  }

  ListView _buildSubFuncionalitiesList(
      List<SubFuncionalitiesModel> subFuncionalities) {
    return ListView.builder(
        itemCount: subFuncionalities.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  subFuncionalities[index].name!,
                  style: textStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                )),
                Expanded(
                  child: Checkbox(
                    checkColor: Colors.white,
                    value: subFuncionalities[index].active,
                    onChanged: (bool? value) => handleCheckBox(value, index),
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Text('Departamento',
                      style: textStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.w700))
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network('https://picsum.photos/250?image=9'),
                  ),
                ),
                const SizedBox(
                  width: 32,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.departament.description.toString()),
                    // const SizedBox(
                    //   height: 12,
                    // ),
                    // Text(widget.user.email!)
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Row(
                children: [
                  Text('Funcionalidades',
                      style: textStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.w700))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Text('Nome',
                        style: textStyle(
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w700))),
                Expanded(
                    child: Center(
                  child: Text('Status',
                      style: textStyle(
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w700)),
                )),
              ],
            ),
            const Divider(),
            Expanded(
                child: _controller.state == DepartamentEnum.changeDepartament
                    ? _buildSubFuncionalitiesList(_controller.subFuncionalities)
                    : Container()),
            Row(
              children: [
                ButtonPrimaryComponent(
                    onPressed: () => handleSalved(context), text: "Salvar")
              ],
            )
          ],
        ),
      ),
    );
  }
}

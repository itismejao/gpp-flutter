import 'package:flutter/material.dart';

import 'package:gpp/src/controllers/departament_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/models/departament_model.dart';
import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/models/subfuncionalities_model.dart';
import 'package:gpp/src/repositories/departament_repository.dart';
import 'package:gpp/src/shared/enumeration/departament_enum.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:gpp/src/views/departaments/departament_list_view.dart';
import 'package:gpp/src/views/loading_view.dart';

class DepartamentView extends StatefulWidget {
  const DepartamentView({Key? key}) : super(key: key);

  @override
  _DepartamentViewState createState() => _DepartamentViewState();
}

class _DepartamentViewState extends State<DepartamentView> {
  @override
  Widget build(BuildContext context) {
    return const DepartamentListView();
  }
}

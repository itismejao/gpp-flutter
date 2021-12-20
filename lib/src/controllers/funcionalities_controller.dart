import 'package:flutter/cupertino.dart';
import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/models/user_models.dart';
import 'package:gpp/src/repositories/funcionalities_repository.dart';
import 'package:gpp/src/shared/enumeration/funcionalities_enum.dart';
import 'package:gpp/src/shared/repositories/global.dart';

class FuncionalitiesController {
  final formKeySearch = GlobalKey<FormState>();

  late final FuncionalitiesRepository repository;
  //FuncionalitiesEnum status = FuncionalitiesEnum.loading;
  final state =
      ValueNotifier<FuncionalitiesEnum>(FuncionalitiesEnum.notFuncionalities);
  List<FuncionalitieModel> funcionalities = [];
  List<FuncionalitieModel> funcionalitiesAux = [];

  FuncionalitiesController(this.repository);

  UserModel user = UserModel();

  void search(String value) {
    state.value = FuncionalitiesEnum.loading;
    funcionalities = funcionalitiesAux
        .where((row) => (row.name.toLowerCase().contains(value.toLowerCase())))
        .toList();

    funcionalities.forEach((element) {
      element.isExpanded = true;
    });
    state.value = FuncionalitiesEnum.changeFuncionalities;

    print(value);
  }

  Future changeFuncionalities() async {
    user.uid = authenticateUser!.id.toString();
    state.value = FuncionalitiesEnum.loading;
    funcionalities = await repository.fetchFuncionalities(user);
    funcionalitiesAux = funcionalities;
    state.value = FuncionalitiesEnum.changeFuncionalities;
  }
}

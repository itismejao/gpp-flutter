import 'package:flutter/cupertino.dart';
import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/models/user_models.dart';
import 'package:gpp/src/repositories/funcionalities_repository.dart';
import 'package:gpp/src/shared/enumeration/funcionalities_enum.dart';
import 'package:gpp/src/shared/repositories/global.dart';

class FuncionalitiesController {
  late final FuncionalitiesRepository repository;
  //FuncionalitiesEnum status = FuncionalitiesEnum.loading;
  final state =
      ValueNotifier<FuncionalitiesEnum>(FuncionalitiesEnum.notFuncionalities);
  List<FuncionalitieModel> funcionalities = [];
  List<FuncionalitieModel> funcionalitiesSearch = [];

  FuncionalitiesController(this.repository);

  UserModel user = UserModel();

  void search(String value) {
    state.value = FuncionalitiesEnum.loading;
    if (value.isNotEmpty) {
      funcionalitiesSearch = funcionalities
          .where(
              (row) => (row.name.toLowerCase().contains(value.toLowerCase())))
          .toList();

      // funcionalitiesSearch.forEach((element) {
      //   element.isExpanded = true;
      // });
    } else {
      funcionalitiesSearch = [];
    }
    state.value = FuncionalitiesEnum.changeFuncionalities;
  }

  Future changeFuncionalities() async {
    user.uid = authenticateUser!.id.toString();
    state.value = FuncionalitiesEnum.loading;
    funcionalities = await repository.fetchFuncionalities(user);
    //funcionalitiesAux = funcionalities;
    state.value = FuncionalitiesEnum.changeFuncionalities;
  }
}

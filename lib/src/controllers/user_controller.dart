import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/models/subfuncionalities_model.dart';
import 'package:gpp/src/models/user_model.dart';
import 'package:gpp/src/repositories/user_repository.dart';
import 'package:gpp/src/shared/enumeration/user_enum.dart';
import 'package:gpp/src/shared/repositories/global.dart';

class UserController {
  UserRepository repository;
  List<UserModel> users = [];
  List<UserModel> usersSearch = [];
  List<SubFuncionalitiesModel> subFuncionalities = [];
  UserEnum state = UserEnum.notUser;
  List<FuncionalitieModel> funcionalities = [];
  List<FuncionalitieModel> funcionalitiesSearch = [];

  UserController({
    required this.repository,
  });

  Future<void> changeUser() async {
    users = await repository.fetchUser();
  }

  Future<void> changeUserFuncionalities() async {
    UserModel user = UserModel();
    user.uid = authenticateUser!.id.toString();
    subFuncionalities = await repository.fetchSubFuncionalities(user);
  }

  void search(String value) {
    usersSearch = users
        .where((user) =>
            (user.name!.toLowerCase().contains(value.toLowerCase()) ||
                user.uid!.toLowerCase().contains(value.toLowerCase())))
        .toList();
  }

  Future<bool> updateUserSubFuncionalities(
      List<SubFuncionalitiesModel> subFuncionalities) async {
    UserModel user = UserModel();
    user.uid = authenticateUser!.id.toString();

    return await repository.updateUserSubFuncionalities(
        user, subFuncionalities);
  }

  Future<void> changeFuncionalities() async {
    UserModel user = UserModel();
    user.uid = authenticateUser!.id.toString();

    funcionalities = await repository.fetchFuncionalities(user);
  }

  void searchFuncionalities(String value) {
    funcionalitiesSearch = [];

    if (value != "") {
      for (var funcionalitie in funcionalities) {
        for (var subFuncionalitie in funcionalitie.subFuncionalities!) {
          if (funcionalitie.name!.toLowerCase().contains(value.toLowerCase()) ||
              subFuncionalitie.name!
                  .toLowerCase()
                  .contains(value.toLowerCase())) {
            funcionalitie.isExpanded = true;
            funcionalitiesSearch.add(funcionalitie);
            break;
          }
        }
      }
    }
  }
}

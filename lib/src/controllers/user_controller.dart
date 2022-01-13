import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/models/subfuncionalities_model.dart';
import 'package:gpp/src/models/user_model.dart';
import 'package:gpp/src/repositories/user_repository.dart';
import 'package:gpp/src/shared/enumeration/user_enum.dart';
import 'package:gpp/src/shared/repositories/global.dart';

class UserController {
  UserRepository repository;
  UserModel user = UserModel();
  List<UserModel> users = [];
  List<UserModel> usersSearch = [];
  List<SubFuncionalitiesModel> subFuncionalities = [];
  UserEnum state = UserEnum.notUser;
  List<FuncionalitieModel> funcionalities = [];
  List<FuncionalitieModel> funcionalitiesSearch = [];

  UserController({
    required this.repository,
  });

  Future<void> fetchUser(String id) async {
    user = await repository.fetchUser(id);
  }

  Future<void> changeUser() async {
    users = await repository.fetchAll();
  }

  Future<void> changeUserFuncionalities(String id) async {
    subFuncionalities = await repository.fetchSubFuncionalities(id);
  }

  void search(String value) {
    print(value);
    usersSearch = users
        .where((user) =>
            (user.name!.toLowerCase().contains(value.toLowerCase()) ||
                user.uid!.toString().contains(value.toLowerCase())))
        .toList();
  }

  Future<bool> updateUserSubFuncionalities(
      UserModel user, List<SubFuncionalitiesModel> subFuncionalities) async {
    return await repository.updateUserSubFuncionalities(
        user, subFuncionalities);
  }

  Future<void> changeFuncionalities() async {
    UserModel user = UserModel();
    user.id = authenticateUser!.id;

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

  Future<bool> update(UserModel user) async {
    return await repository.update(user);
  }
}

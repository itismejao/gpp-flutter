class GppRoutePath {
  final bool unknown;
  final bool loggedIn;
  final bool departaments;
  final bool users;
  final int? id;

  GppRoutePath.login()
      : unknown = false,
        loggedIn = false,
        departaments = false,
        users = false,
        id = null;

  GppRoutePath.home()
      : unknown = false,
        loggedIn = true,
        departaments = false,
        users = false,
        id = null;

  GppRoutePath.departaments()
      : unknown = false,
        loggedIn = true,
        departaments = true,
        users = false,
        id = null;

  GppRoutePath.unknown()
      : unknown = true,
        departaments = false,
        users = false,
        loggedIn = false,
        id = null;

  GppRoutePath.users()
      : unknown = false,
        departaments = false,
        users = true,
        loggedIn = true,
        id = null;

  GppRoutePath.details(this.id)
      : unknown = false,
        departaments = false,
        users = true,
        loggedIn = true;

  bool get isUnknown =>
      unknown == true &&
      loggedIn == false &&
      departaments == false &&
      users == false &&
      id == null;

  bool get isHomePage =>
      unknown == false &&
      loggedIn == true &&
      departaments == false &&
      users == false &&
      id == null;
  bool get isLoginPage => unknown == false && loggedIn == false;

  bool get isDepartaments =>
      unknown == false && loggedIn == true && departaments == true;

  bool get isUsers =>
      unknown == false && loggedIn == true && users == true && id == null;

  bool get isUsersDetails => users == true && id != null;
}

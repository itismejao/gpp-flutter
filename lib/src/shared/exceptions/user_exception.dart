class AuthenticationException implements Exception {
  String message;

  AuthenticationException(this.message);

  @override
  String toString() {
    // TODO: implement toString
    return message;
  }
}

class UserNotFoundException extends AuthenticationException {
  UserNotFoundException(String error) : super(error);
}

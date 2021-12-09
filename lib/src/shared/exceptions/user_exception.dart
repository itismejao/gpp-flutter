class AuthenticationException implements Exception {
  String? message;

  AuthenticationException(this.message);

  String? getError() {
    return message;
  }
}

class UserNotFoundException extends AuthenticationException {
  UserNotFoundException() : super("message");
}

class AuthenticationException implements Exception {
  String? message;

  AuthenticationException(message) {
    this.message = message;
  }

  String? getError() {
    return message;
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}

class UserNotFoundException extends AuthenticationException {
  UserNotFoundException() : super("message");
}

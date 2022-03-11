import 'package:universal_html/html.dart';

final storage = window.localStorage;

void setToken(String token) {
  storage['token'] = token;
}

void logout() {
  storage.remove('token');
}

String? getToken() {
  return storage['token'];
}

bool isAuthenticated() {
  print(storage['token']);
  return storage['token'] != null;
}

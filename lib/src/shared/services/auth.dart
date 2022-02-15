import 'package:localstorage/localstorage.dart';

final storage = LocalStorage('auth');

void setToken(String token) {
  storage.setItem('token', token);
}

void logout() {
  storage.deleteItem('token');
}

String getToken() {
  return storage.getItem('token');
}

bool isAuthenticated() {
  return storage.getItem('token') != null;
}

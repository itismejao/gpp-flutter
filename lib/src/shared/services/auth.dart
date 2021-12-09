import 'package:localstorage/localstorage.dart';

final storage = new LocalStorage('auth');

void login(String token) {
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

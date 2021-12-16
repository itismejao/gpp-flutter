import 'package:flutter/material.dart';
import 'package:gpp/src/shared/repositories/routes.dart';
import 'package:gpp/src/shared/services/auth.dart';

class NavigatorRoutes {
  static pushNamed(context, route) {
    if (isAuthenticated()) {
      switch (route) {
        case Routes.HOME:
          Navigator.pushNamed(context, Routes.HOME);
          break;
        default:
          Navigator.pushNamed(context, Routes.NOT_FOUND);
          break;
      }
    } else {
      Navigator.pushNamed(context, Routes.LOGIN);
    }
  }
}

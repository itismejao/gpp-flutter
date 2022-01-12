import 'package:flutter/material.dart';
import 'package:gpp/src/routes/gpp_route_path.dart';

class GppRouteInformationParser extends RouteInformationParser<GppRoutePath> {
  @override
  Future<GppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);

    // Handle '/'
    if (uri.pathSegments.length == 0) {
      return GppRoutePath.home();
    } else if (uri.pathSegments.length == 1) {
      final first = uri.pathSegments[0].toLowerCase();
      if (first == 'home') {
        return GppRoutePath.home();
      } else if (first == 'login') {
        return GppRoutePath.login();
      }
      if (first == 'departaments') {
        return GppRoutePath.departaments();
      } else if (first == 'users') {
        return GppRoutePath.users();
      }
    } else if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] == 'users') {
        var remaining = uri.pathSegments[1];
        var id = int.tryParse(remaining);
        if (id == null) return GppRoutePath.unknown();

        return GppRoutePath.details(id);
      } else {
        return GppRoutePath.unknown();
      }
    }
    return GppRoutePath.unknown();

    // Handle unknown routes
  }

  @override
  RouteInformation? restoreRouteInformation(GppRoutePath path) {
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }
    if (path.isHomePage) {
      return RouteInformation(location: '/home');
    }
    if (path.isLoginPage) {
      return RouteInformation(location: '/login');
    }
    if (path.isDepartaments) {
      return RouteInformation(location: '/departaments');
    }
    if (path.isUsers) {
      return RouteInformation(location: '/users');
    }
    if (path.isUsersDetails) {
      return RouteInformation(location: '/users/${path.id}');
    }
    return null;
  }
}

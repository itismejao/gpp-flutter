import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:gpp/src/not_found/repositories/not_found.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/services/auth.dart';
import 'package:gpp/src/views/authenticate_view.dart';
import 'package:gpp/src/views/funcionalities_view.dart';
import 'package:gpp/src/views/home_view.dart';
import 'package:gpp/src/views/user_view.dart';

main() async {
  await dotenv.load(fileName: "env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget checkAuthenticate(Widget page) {
    if (isAuthenticated()) {
      return page;
    } else {
      return const AuthenticateView();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPP - Gerenciamento de Peças e Pedidos',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Mada',
          inputDecorationTheme: InputDecorationTheme(iconColor: Colors.grey)),
      // home: const AuthenticateView(),
      home: const UserView(),
      routes: {
        '/home': (context) => checkAuthenticate(const HomeView()),
        '/login': (context) => const AuthenticateView(),
        '/not_found': (context) => checkAuthenticate(const NotFoundView()),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

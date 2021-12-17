import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gpp/src/home/repositories/home_view.dart';
import 'package:gpp/src/login/repositories/login_view.dart';
import 'package:gpp/src/not_found/repositories/not_found.dart';
import 'package:gpp/src/shared/services/auth.dart';

main() async {
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget checkAuthenticate(Widget page) {
    if (isAuthenticated()) {
      return page;
    } else {
      return const LoginView();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        '/home': (context) => checkAuthenticate(const HomeView()),
        '/login': (context) => const LoginView(),
        '/not_found': (context) => checkAuthenticate(const NotFoundView()),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: LoginView());
  }
}

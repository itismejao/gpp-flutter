// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:gpp/src/models/user_model.dart';

// import 'package:gpp/src/views/not_found_view.dart';
// import 'package:gpp/src/shared/services/auth.dart';
// import 'package:gpp/src/views/authenticated/authenticate_view.dart';
// import 'package:gpp/src/views/departaments/departament_view.dart';
// import 'package:gpp/src/views/funcionalities/funcionalities_form_create_view.dart';
// import 'package:gpp/src/views/funcionalities/funcionalities_home_view.dart';
// import 'package:gpp/src/views/funcionalities/funcionalities_list_view.dart';
// import 'package:gpp/src/views/funcionalities_view.dart';
// import 'package:gpp/src/views/home_view.dart';
// import 'package:gpp/src/views/users/user_detail.view.dart';
// import 'package:gpp/src/views/users/user_view.dart';

// main() async {
//   await dotenv.load(fileName: "env");

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   Widget checkAuthenticate(Widget page) {
//     if (isAuthenticated()) {
//       return page;
//     } else {
//       return const AuthenticateView();
//     }
//   }

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'GPP - Gerenciamento de Peças e Pedidos',
//       theme: ThemeData(
//           primarySwatch: Colors.blue,
//           fontFamily: 'Mada',
//           inputDecorationTheme:
//               const InputDecorationTheme(iconColor: Colors.grey)),
//       // home: const AuthenticateView(),
//       home: Scaffold(body: HomeView()),
//       routes: {
//         '/home': (context) => checkAuthenticate(const HomeView()),
//         '/login': (context) => const AuthenticateView(),
//         '/users': (context) => const UserView(),
//         '/user_detail': (context) => UserDetailView(
//               user: UserModel(),
//             ),
//         '/not_found': (context) => checkAuthenticate(const NotFoundView()),
//       },
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gpp/src/views/appbar_view.dart';
import 'package:gpp/src/views/authenticated/authenticate_view.dart';
import 'package:gpp/src/views/departaments/departament_view.dart';
import 'package:gpp/src/views/funcionalities_view.dart';
import 'package:gpp/src/views/home/home_view.dart';

import 'package:gpp/src/views/users/user_view.dart';

void main() async {
  await dotenv.load(fileName: "env");
  runApp(GppApp());
}

class Book {
  final String title;
  final String author;

  Book(this.title, this.author);
}

class GppApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GppAppState();
}

class _GppAppState extends State<GppApp> {
  BookRouterDelegate _routerDelegate = BookRouterDelegate();
  BookRouteInformationParser _routeInformationParser =
      BookRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'GPP - Gerenciamento de Peças e Pedidos',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Mada',
          inputDecorationTheme:
              const InputDecorationTheme(iconColor: Colors.grey)),
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}

class BookRouteInformationParser extends RouteInformationParser<GppRoutePath> {
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
      } else {
        return GppRoutePath.unknown();
      }
    } else {
      return GppRoutePath.unknown();
    }

    // Handle '/login'
    // if (uri.pathSegments.length == 1) {
    //   print(uri.pathSegments);
    //   return BookRoutePath.home();
    // }

    // Handle '/book/:id'
    // if (uri.pathSegments.length == 2) {
    //   if (uri.pathSegments[0] != 'book') return BookRoutePath.unknown();
    //   var remaining = uri.pathSegments[1];
    //   var id = int.tryParse(remaining);
    //   if (id == null) return BookRoutePath.unknown();
    //   return BookRoutePath.details(id);
    // }

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
    return null;
  }
}

class BookRouterDelegate extends RouterDelegate<GppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<GppRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  String _currentPage = "/home";

  String get currentPage => _currentPage;

  set currentPage(value) {
    _currentPage = value;
    notifyListeners();
  }

  bool _authenticated = false;

  bool get authenticated => _authenticated;

  set authenticated(value) {
    _authenticated = value;
    notifyListeners();
  }

  Book? _selectedBook;
  bool show404 = false;

  List<Book> books = [
    Book('Left Hand of Darkness', 'Ursula K. Le Guin'),
    Book('Too Like the Lightning', 'Ada Palmer'),
    Book('Kindred', 'Octavia E. Butler'),
  ];

  BookRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  GppRoutePath get currentConfiguration {
    if (show404) {
      return GppRoutePath.unknown();
    }

    if (authenticated) {
      return GppRoutePath.login();
    } else if (currentPage == "/home") {
      return GppRoutePath.home();
    } else if (currentPage == "/departaments") {
      return GppRoutePath.departaments();
    } else if (currentPage == "/users") {
      return GppRoutePath.users();
    }

    return GppRoutePath.unknown();
  }

  void _handleBookTapped(Book book) {
    _selectedBook = book;
    notifyListeners();
  }

  void handleLogin() {
    authenticated = true;
    notifyListeners();
  }

  void handleLogout() {
    print('te');
    authenticated = false;
    notifyListeners();
  }

  void handleCurrentPage(value) {
    print(value);
    currentPage = value;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var stack;

    // ignore: unnecessary_null_comparison
    if (!authenticated) {
      stack = MaterialPage(
          child: AuthenticateView(
        login: () => handleLogin(),
      ));
    } else {
      var subStack;

      switch (currentPage) {
        case "/home":
          subStack = HomeView();
          break;
        case "/departaments":
          subStack = DepartamentView();
          break;
        case "/users":
          subStack = UserView();
          break;
      }

      stack = MaterialPage(
          child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(mediaQuery.size.height * 0.10),
          child: AppBarView(
            handleLogout: handleLogout,
          ),
        ),
        body: Row(
          children: [
            Expanded(
              child: FuncionalitiesView(
                handleCurrentPage: (value) => handleCurrentPage(value),
              ),
            ),
            Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: subStack,
                ))
          ],
        ),
      ));
    }

    return Navigator(
      key: navigatorKey,
      pages: [
        stack,
        //  MaterialPage(child: AuthenticateView()),
        // MaterialPage(
        //   key: ValueKey('BooksListPage'),
        //   child: BooksListScreen(
        //     books: books,
        //     onTapped: _handleBookTapped,
        //   ),
        // ),
        if (show404)
          MaterialPage(key: ValueKey('UnknownPage'), child: UnknownScreen())
        else if (_selectedBook != null)
          // BookDetailsPage(book: _selectedBook!)
          MaterialPage(child: UserView())
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        // Update the list of pages by setting _selectedBook to null

        _selectedBook = null;
        show404 = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(GppRoutePath path) async {
    if (path.isUnknown) {
      show404 = true;
    } else if (path.isLoginPage) {
      show404 = false;
      authenticated = false;
    } else if (path.isDepartaments) {
      show404 = false;

      currentPage = "/departaments";
    } else if (path.isUsers) {
      show404 = false;
      currentPage = "/users";
    }

    // // if (path.isDetailsPage) {
    // //   if (path.id! < 0 || path.id! > books.length - 1) {
    // //     show404 = true;
    // //     return;
    // //   }

    // //   _selectedBook = books[path.id!];
    // // } else {
    // //   _selectedBook = null;
    // // }

    // // show404 = false;
  }
}

class BookDetailsPage extends Page {
  final Book book;

  BookDetailsPage({
    required this.book,
  }) : super(key: ValueKey(book));

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return BookDetailsScreen(book: book);
      },
    );
  }
}

class GppRoutePath {
  final bool unknown;
  final bool loggedIn;
  final bool departaments;
  final bool users;

  GppRoutePath.login()
      : unknown = false,
        loggedIn = false,
        departaments = false,
        users = false;

  GppRoutePath.home()
      : unknown = false,
        loggedIn = true,
        departaments = false,
        users = false;

  GppRoutePath.departaments()
      : unknown = false,
        loggedIn = true,
        departaments = true,
        users = false;

  GppRoutePath.unknown()
      : unknown = true,
        departaments = false,
        users = false,
        loggedIn = false;

  GppRoutePath.users()
      : unknown = false,
        departaments = false,
        users = true,
        loggedIn = true;

  bool get isUnknown =>
      unknown == true &&
      loggedIn == false &&
      departaments == false &&
      users == false;

  bool get isHomePage =>
      unknown == false &&
      loggedIn == true &&
      departaments == false &&
      users == false;
  bool get isLoginPage => unknown == false && loggedIn == false;

  bool get isDepartaments =>
      unknown == false && loggedIn == true && departaments == true;

  bool get isUsers => unknown == false && loggedIn == true && users == true;

  // final int? id;
  // final bool isUnknown;

  // BookRoutePath.home()
  //     : id = null,
  //       isUnknown = false;

  // BookRoutePath.details(this.id) : isUnknown = false;

  // BookRoutePath.unknown()
  //     : id = null,
  //       isUnknown = true;

  // bool get isHomePage => id == null;

  // bool get isDetailsPage => id != null;
}

class BooksListScreen extends StatelessWidget {
  final List<Book> books;
  final ValueChanged<Book> onTapped;

  BooksListScreen({
    required this.books,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          for (var book in books)
            ListTile(
              title: Text(book.title),
              subtitle: Text(book.author),
              onTap: () => onTapped(book),
            )
        ],
      ),
    );
  }
}

class BookDetailsScreen extends StatelessWidget {
  final Book book;

  BookDetailsScreen({
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (book != null) ...[
              Text(book.title, style: Theme.of(context).textTheme.headline6),
              Text(book.author, style: Theme.of(context).textTheme.subtitle1),
            ],
          ],
        ),
      ),
    );
  }
}

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!'),
      ),
    );
  }
}

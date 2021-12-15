import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpp/src/home/repositories/home_view.dart';
import 'package:gpp/src/shared/controllers/authenticate_controller.dart';
import 'package:gpp/src/shared/exceptions/authenticate_exception.dart';
import 'package:gpp/src/shared/models/authenticate_model.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/services/auth.dart';

enum AuthenticateStatus { waiting, notAuthenticate, authenticateError }

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // AuthenticateStatus authenticateStatus = AuthenticateStatus.notAuthenticate;
  TextEditingController reController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isAuthenticated = false;

  bool visiblePassword = true;

  final formKeyAuthenticate = GlobalKey<FormState>();

  void setVisiblePassword() {
    setState(() {
      isAuthenticated = isAuthenticated;
      visiblePassword = !visiblePassword;
    });
  }

  Future authenticate() async {
    try {
      final authenticateController = AuthenticateController();
      AuthenticateModel authenticate = await authenticateController.login(
          reController.text, passwordController.text);

      // ignore: avoid_print
      print(authenticate.email);

      //seta token

      login(authenticate.accessToken);

      return authenticate;
    } on UserNotFoundException catch (userNotFoundException) {
      final snackBar = SnackBar(
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
          content: Text(userNotFoundException.toString()));

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void handleSignIn() {
    if (formKeyAuthenticate.currentState!.validate()) {
      setState(() {
        reController = reController;
        passwordController = passwordController;
        isAuthenticated = true;
        //authenticateStatus = AuthenticateStatus.waiting;
      });
    }
  }

  validateRegisterEmployee(registerEmployee) {
    if (registerEmployee == null || registerEmployee.isEmpty) {
      return 'Digite seu RE';
    }
    return null;
  }

  validatePassword(password) {
    if (password == null || password.isEmpty) {
      return 'Digite sua senha';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    if (isAuthenticated) {
      return FutureBuilder(
          future: authenticate(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return loginWidget(
                    authenticateStatus: AuthenticateStatus.waiting,
                    mediaQuery: mediaQuery);

              case ConnectionState.done:
                if (snapshot.hasError) {
                  return loginWidget(
                      authenticateStatus: AuthenticateStatus.notAuthenticate,
                      mediaQuery: mediaQuery);
                } else if (snapshot.hasData) {
                  return const HomeView();
                }
                break;
              case ConnectionState.none:
                // ignore: todo
                // TODO: Handle this case.
                break;
              case ConnectionState.active:
                // ignore: todo
                // TODO: Handle this case.
                break;
            }

            return loginWidget(
                authenticateStatus: AuthenticateStatus.notAuthenticate,
                mediaQuery: mediaQuery);
          });
    } else {
      return loginWidget(
          authenticateStatus: AuthenticateStatus.notAuthenticate,
          mediaQuery: mediaQuery);
    }
  }

  Container loginWidget(
      {required AuthenticateStatus authenticateStatus,
      required MediaQueryData mediaQuery,
      String? error}) {
    return Container(
      width: mediaQuery.size.width,
      height: mediaQuery.size.height,
      color: const Color.fromRGBO(195, 184, 184, 0.10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Header
                        Container(
                          height: 130.0,
                          width: 340,
                          decoration: BoxDecoration(
                            color: primaryColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      '../../../lib/src/shared/assets/logo.svg',
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      semanticsLabel:
                                          'Gerenciamento de peças e pedidos')
                                ],
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Gerenciamento de peças e pedidos',
                                      style: TextStyle(
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 1),
                                          fontSize:
                                              mediaQuery.textScaleFactor * 14.0,
                                          fontWeight: FontWeight.w700))
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 420,
                              width: 340.0,
                              color: Colors.white,
                              child: Builder(
                                builder: (BuildContext context) {
                                  switch (authenticateStatus) {
                                    case AuthenticateStatus.notAuthenticate:
                                      return Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Form(
                                          key: formKeyAuthenticate,
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 16.0),
                                                child: Row(
                                                  children: [
                                                    Text('Login',
                                                        style: textStyle(
                                                            color: Colors.black,
                                                            fontSize: mediaQuery
                                                                    .textScaleFactor *
                                                                14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700))
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text('RE',
                                                      style: textStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700))
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: SizedBox(
                                                      height: 70,
                                                      child: TextFormField(
                                                        style: textStyle(
                                                            color: const Color
                                                                    .fromRGBO(
                                                                191,
                                                                183,
                                                                183,
                                                                1),
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 12,
                                                            height: 1.8),
                                                        validator: (registerEmployee) =>
                                                            validateRegisterEmployee(
                                                                registerEmployee),
                                                        controller:
                                                            reController,
                                                        decoration:
                                                            InputDecoration(
                                                                contentPadding:
                                                                    const EdgeInsets.all(
                                                                        10.0),
                                                                prefixIcon:
                                                                    Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  child: SvgPicture.asset(
                                                                      '../../../lib/src/shared/assets/user.svg',
                                                                      color: const Color
                                                                              .fromRGBO(
                                                                          191,
                                                                          183,
                                                                          183,
                                                                          1),
                                                                      semanticsLabel:
                                                                          'Gerenciamento de peças e pedidos'),
                                                                ),
                                                                hintText:
                                                                    'Digite seu RE',
                                                                hintStyle: textStyle(
                                                                    color:
                                                                        const Color.fromRGBO(
                                                                            191,
                                                                            183,
                                                                            183,
                                                                            1),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        12,
                                                                    height:
                                                                        1.8),
                                                                filled: true,
                                                                fillColor:
                                                                    const Color
                                                                            .fromRGBO(
                                                                        195,
                                                                        184,
                                                                        184,
                                                                        0.26),
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none,
                                                                )),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text('Senha',
                                                      style: textStyle(
                                                          color: Colors.black,
                                                          fontSize: mediaQuery
                                                                  .textScaleFactor *
                                                              12,
                                                          fontWeight:
                                                              FontWeight.w700))
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: SizedBox(
                                                      height: 70,
                                                      child: TextFormField(
                                                        style: const TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    191,
                                                                    183,
                                                                    183,
                                                                    1),
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            height: 1.8,
                                                            fontSize: 12.0),
                                                        validator: (password) =>
                                                            validatePassword(
                                                                password),
                                                        controller:
                                                            passwordController,
                                                        obscureText:
                                                            visiblePassword,
                                                        decoration:
                                                            InputDecoration(
                                                                contentPadding:
                                                                    const EdgeInsets.all(
                                                                        10.0),
                                                                prefixIcon:
                                                                    Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  child: SvgPicture.asset(
                                                                      '../../../lib/src/shared/assets/password.svg',
                                                                      color: const Color
                                                                              .fromRGBO(
                                                                          191,
                                                                          183,
                                                                          183,
                                                                          1),
                                                                      semanticsLabel:
                                                                          'Gerenciamento de peças e pedidos'),
                                                                ),
                                                                suffixIcon:
                                                                    GestureDetector(
                                                                  onTap:
                                                                      setVisiblePassword,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                    child: SvgPicture.asset(
                                                                        '../../../lib/src/shared/assets/eye_password.svg',
                                                                        color: const Color.fromRGBO(
                                                                            191,
                                                                            183,
                                                                            183,
                                                                            1),
                                                                        semanticsLabel:
                                                                            'Gerenciamento de peças e pedidos'),
                                                                  ),
                                                                ),
                                                                hintText:
                                                                    'Digite sua senha',
                                                                hintStyle: textStyle(
                                                                    color:
                                                                        const Color.fromRGBO(
                                                                            191,
                                                                            183,
                                                                            183,
                                                                            1),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        12,
                                                                    height:
                                                                        1.8),
                                                                filled: true,
                                                                fillColor:
                                                                    const Color
                                                                            .fromRGBO(
                                                                        195,
                                                                        184,
                                                                        184,
                                                                        0.26),
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none,
                                                                )),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: ElevatedButton(
                                                        onPressed: () =>
                                                            handleSignIn(),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary:
                                                                    secundaryColor),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(12.0),
                                                          child: Text('Entrar',
                                                              style: textStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      mediaQuery
                                                                              .textScaleFactor *
                                                                          12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700)),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 24,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: RichText(
                                                      text: const TextSpan(
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                              text:
                                                                  'Em caso de dúvida, entre em contato com o suporte através do telefone ',
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          195,
                                                                          184,
                                                                          184,
                                                                          1),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
                                                          TextSpan(
                                                              text: '9999-9999',
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          207,
                                                                          128,
                                                                          0.8),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 24.0,
                                              ),
                                              Row(
                                                children: const [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(16.0),
                                                      child: Center(
                                                        child: Text(
                                                            'Versão 1.0.0',
                                                            style: TextStyle(
                                                                fontSize: 12.0,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        195,
                                                                        184,
                                                                        184,
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    case AuthenticateStatus.waiting:
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          CircularProgressIndicator()
                                        ],
                                      );

                                    case AuthenticateStatus.authenticateError:
                                      return Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Form(
                                          key: formKeyAuthenticate,
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 16.0),
                                                child: Row(
                                                  children: [
                                                    Text('Login',
                                                        style: textStyle(
                                                            color: Colors.black,
                                                            fontSize: mediaQuery
                                                                    .textScaleFactor *
                                                                14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700))
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text('RE',
                                                      style: textStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700))
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: SizedBox(
                                                      height: 70,
                                                      child: TextFormField(
                                                        style: textStyle(
                                                            color: const Color
                                                                    .fromRGBO(
                                                                191,
                                                                183,
                                                                183,
                                                                1),
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 12,
                                                            height: 1.8),
                                                        validator: (registerEmployee) =>
                                                            validateRegisterEmployee(
                                                                registerEmployee),
                                                        controller:
                                                            reController,
                                                        decoration:
                                                            InputDecoration(
                                                                contentPadding:
                                                                    const EdgeInsets.all(
                                                                        10.0),
                                                                prefixIcon:
                                                                    Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  child: SvgPicture.asset(
                                                                      '../../../lib/src/shared/assets/user.svg',
                                                                      color: const Color
                                                                              .fromRGBO(
                                                                          191,
                                                                          183,
                                                                          183,
                                                                          1),
                                                                      semanticsLabel:
                                                                          'Gerenciamento de peças e pedidos'),
                                                                ),
                                                                hintText:
                                                                    'Digite seu RE',
                                                                hintStyle: textStyle(
                                                                    color:
                                                                        const Color.fromRGBO(
                                                                            191,
                                                                            183,
                                                                            183,
                                                                            1),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        12,
                                                                    height:
                                                                        1.8),
                                                                filled: true,
                                                                fillColor:
                                                                    const Color
                                                                            .fromRGBO(
                                                                        195,
                                                                        184,
                                                                        184,
                                                                        0.26),
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none,
                                                                )),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text('Senha',
                                                      style: textStyle(
                                                          color: Colors.black,
                                                          fontSize: mediaQuery
                                                                  .textScaleFactor *
                                                              12,
                                                          fontWeight:
                                                              FontWeight.w700))
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: SizedBox(
                                                      height: 70,
                                                      child: TextFormField(
                                                        style: const TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    191,
                                                                    183,
                                                                    183,
                                                                    1),
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            height: 1.8,
                                                            fontSize: 12.0),
                                                        validator: (password) =>
                                                            validatePassword(
                                                                password),
                                                        controller:
                                                            passwordController,
                                                        obscureText:
                                                            visiblePassword,
                                                        decoration:
                                                            InputDecoration(
                                                                contentPadding:
                                                                    const EdgeInsets.all(
                                                                        10.0),
                                                                prefixIcon:
                                                                    Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  child: SvgPicture.asset(
                                                                      '../../../lib/src/shared/assets/password.svg',
                                                                      color: const Color
                                                                              .fromRGBO(
                                                                          191,
                                                                          183,
                                                                          183,
                                                                          1),
                                                                      semanticsLabel:
                                                                          'Gerenciamento de peças e pedidos'),
                                                                ),
                                                                suffixIcon:
                                                                    GestureDetector(
                                                                  onTap:
                                                                      setVisiblePassword,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                    child: SvgPicture.asset(
                                                                        '../../../lib/src/shared/assets/eye_password.svg',
                                                                        color: const Color.fromRGBO(
                                                                            191,
                                                                            183,
                                                                            183,
                                                                            1),
                                                                        semanticsLabel:
                                                                            'Gerenciamento de peças e pedidos'),
                                                                  ),
                                                                ),
                                                                hintText:
                                                                    'Digite sua senha',
                                                                hintStyle: textStyle(
                                                                    color:
                                                                        const Color.fromRGBO(
                                                                            191,
                                                                            183,
                                                                            183,
                                                                            1),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        12,
                                                                    height:
                                                                        1.8),
                                                                filled: true,
                                                                fillColor:
                                                                    const Color
                                                                            .fromRGBO(
                                                                        195,
                                                                        184,
                                                                        184,
                                                                        0.26),
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none,
                                                                )),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: ElevatedButton(
                                                        onPressed: () =>
                                                            handleSignIn(),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary:
                                                                    secundaryColor),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(12.0),
                                                          child: Text('Entrar',
                                                              style: textStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      mediaQuery
                                                                              .textScaleFactor *
                                                                          12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700)),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 24,
                                              ),
                                              Row(
                                                children: [
                                                  Text(error!,
                                                      style: textStyle(
                                                          color: Colors.red,
                                                          fontSize: 12))
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 24,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: RichText(
                                                      text: const TextSpan(
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                              text:
                                                                  'Em caso de dúvida, entre em contato com o suporte através do telefone ',
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          195,
                                                                          184,
                                                                          184,
                                                                          1),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
                                                          TextSpan(
                                                              text: '9999-9999',
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          207,
                                                                          128,
                                                                          0.8),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 24.0,
                                              ),
                                              Row(
                                                children: const [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(16.0),
                                                      child: Center(
                                                        child: Text(
                                                            'Versão 1.0.0',
                                                            style: TextStyle(
                                                                fontSize: 12.0,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        195,
                                                                        184,
                                                                        184,
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

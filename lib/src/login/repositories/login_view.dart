import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpp/src/shared/components/components.dart';
import 'package:gpp/src/shared/controllers/authenticate_controller.dart';
import 'package:gpp/src/shared/enumeration/authenticate_status_enum.dart';
import 'package:gpp/src/shared/exceptions/authenticate_exception.dart';
import 'package:gpp/src/shared/models/authenticate_model.dart';
import 'package:gpp/src/shared/repositories/error.dart';
import 'package:gpp/src/shared/repositories/global.dart';
import 'package:gpp/src/shared/repositories/navigator_routes.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/services/auth.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController reController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isAuthenticated = false;
  bool visiblePassword = false;

  final formKeyAuthenticate = GlobalKey<FormState>();

  void setVisiblePassword() {
    setState(() {
      visiblePassword = !visiblePassword;
    });
  }

  Future authenticate() async {
    try {
      String re = reController.text;
      String password = passwordController.text;

      final authenticateController = AuthenticateController();
      AuthenticateModel authenticate =
          await authenticateController.login(re, password);

      //Seta autenticação na varíavel global
      authenticateUser = authenticate;

      //Seta token de autenticação
      login(authenticate.accessToken);

      //Direciona para rota principal
      NavigatorRoutes.pushNamed(context, '/home');

      return authenticate;
    } on AuthenticationException catch (authenticationException) {
      cleanForm();
      showError(context, authenticationException.message);
    } on TimeoutException catch (timeOutException) {
      showError(context, timeOutException.message);
    }
  }

  cleanForm() {
    // formKeyAuthenticate.currentState!.reset();
    setState(() {
      reController.text = "";
      passwordController.text = "";
    });
  }

  void handleSignIn() {
    if (formKeyAuthenticate.currentState!.validate()) {
      setState(() {
        reController = reController;
        passwordController = passwordController;
        isAuthenticated = true;
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

    Widget loginPage;

    if (isAuthenticated) {
      loginPage = FutureBuilder(
          future: authenticate(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return loginWidget(
                  authenticateStatus: AuthenticateStatus.notAuthenticate,
                  mediaQuery: mediaQuery);
            }

            return loginWidget(
                authenticateStatus: AuthenticateStatus.waiting,
                mediaQuery: mediaQuery);
          });
    } else {
      loginPage = loginWidget(
          authenticateStatus: AuthenticateStatus.notAuthenticate,
          mediaQuery: mediaQuery);
    }

    return Scaffold(
      body: loginPage,
    );
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
          ResponsiveBuilder(builder: (context, sizingInformation) {
            if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
              return formLogin(mediaQuery, mediaQuery.size.height,
                  mediaQuery.size.width, authenticateStatus);
            }

            return formLogin(mediaQuery, 550, 340, authenticateStatus);
          })
        ],
      ),
    );
  }

  Container formLogin(mediaQuery, double height, double width,
      AuthenticateStatus authenticateStatus) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          //Header
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  '../../../lib/src/shared/assets/logo.svg',
                  color: const Color.fromRGBO(255, 255, 255, 1),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text('Gerenciamento de peças e pedidos',
                    style: TextStyle(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        fontSize: mediaQuery.textScaleFactor * 14.0,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
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
                                margin: const EdgeInsets.only(bottom: 16.0),
                                child: Row(
                                  children: [
                                    Text('Login',
                                        style: textStyle(
                                            color: Colors.black,
                                            fontSize:
                                                mediaQuery.textScaleFactor * 14,
                                            fontWeight: FontWeight.w700))
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text('RE',
                                      style: textStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700))
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      child: inputUser(),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Text('Senha',
                                      style: textStyle(
                                          color: Colors.black,
                                          fontSize:
                                              mediaQuery.textScaleFactor * 12,
                                          fontWeight: FontWeight.w700))
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      child: inputPassword(),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: buttonSignIn(mediaQuery),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Expanded(
                                child: RichText(
                                  text: const TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Em caso de dúvida, entre em contato com o suporte através do telefone ',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  195, 184, 184, 1),
                                              fontWeight: FontWeight.w400)),
                                      TextSpan(
                                          text: '9999-9999',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  0, 207, 128, 0.8),
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [versionComponent()],
                              )
                            ],
                          ),
                        ),
                      );
                    case AuthenticateStatus.waiting:
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [CircularProgressIndicator()],
                      );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton buttonSignIn(mediaQuery) {
    return ElevatedButton(
        onPressed: () => handleSignIn(),
        style: ElevatedButton.styleFrom(primary: secundaryColor),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text('Logar',
              style: textStyle(
                  color: Colors.white,
                  fontSize: mediaQuery.textScaleFactor * 12,
                  fontWeight: FontWeight.w700)),
        ));
  }

  TextFormField inputPassword() {
    return TextFormField(
      style: const TextStyle(
          color: Color.fromRGBO(191, 183, 183, 1),
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          height: 1.8,
          fontSize: 12.0),
      validator: (password) => validatePassword(password),
      controller: passwordController,
      obscureText: !visiblePassword,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(
              '../../../lib/src/shared/assets/password.svg',
              color: const Color.fromRGBO(191, 183, 183, 1),
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: setVisiblePassword,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                '../../../lib/src/shared/assets/eye_password.svg',
                color: const Color.fromRGBO(191, 183, 183, 1),
              ),
            ),
          ),
          hintText: 'Digite sua senha',
          hintStyle: textStyle(
              color: const Color.fromRGBO(191, 183, 183, 1),
              fontWeight: FontWeight.w700,
              fontSize: 12,
              height: 1.8),
          filled: true,
          fillColor: const Color.fromRGBO(195, 184, 184, 0.26),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          )),
    );
  }

  TextFormField inputUser() {
    return TextFormField(
      style: textStyle(
          color: const Color.fromRGBO(191, 183, 183, 1),
          fontWeight: FontWeight.w700,
          fontSize: 12,
          height: 1.8),
      validator: (registerEmployee) =>
          validateRegisterEmployee(registerEmployee),
      controller: reController,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset('../../../lib/src/shared/assets/user.svg',
                color: const Color.fromRGBO(191, 183, 183, 1),
                semanticsLabel: 'Gerenciamento de peças e pedidos'),
          ),
          hintText: 'Digite seu RE',
          hintStyle: textStyle(
              color: const Color.fromRGBO(191, 183, 183, 1),
              fontWeight: FontWeight.w700,
              fontSize: 12,
              height: 1.8),
          filled: true,
          fillColor: const Color.fromRGBO(195, 184, 184, 0.26),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          )),
    );
  }
}

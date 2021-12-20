import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/authenticate_controller.dart';
import 'package:gpp/src/repositories/authenticate_repository.dart';
import 'package:gpp/src/shared/enumeration/authenticate_enum.dart';
import 'package:gpp/src/shared/exceptions/authenticate_exception.dart';
import 'package:gpp/src/shared/repositories/error.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AuthenticateView extends StatefulWidget {
  const AuthenticateView({Key? key}) : super(key: key);

  @override
  _AuthenticateViewState createState() => _AuthenticateViewState();
}

class _AuthenticateViewState extends State<AuthenticateView> {
  late AuthenticateController authenticate;
  bool _visiblePassword = false;

  void visiblePassword() {
    setState(() {
      _visiblePassword = !_visiblePassword;
    });
  }

  validateInput(value) {
    if (value.isEmpty) {
      return 'Campo não pode ser vazio';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    authenticate = AuthenticateController(AuthenticateRepository());
  }

  Form _form() {
    return Form(
      key: authenticate.formKey,
      child: Expanded(
        flex: 4,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('RE',
                      style: textStyle(
                          color: Colors.black, fontWeight: FontWeight.w700)),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    onSaved: (uid) => authenticate.setUserUID(uid),
                    validator: (value) => validateInput(value),
                    keyboardType: TextInputType.number,
                    style: textStyle(
                        color: const Color.fromRGBO(191, 183, 183, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        height: 1.8),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.account_box_outlined,
                            color: Colors.grey,
                          ),
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
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text('Senha',
                      style: textStyle(
                          color: Colors.black, fontWeight: FontWeight.w700)),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    style: const TextStyle(
                        color: Color.fromRGBO(191, 183, 183, 1),
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        height: 1.8,
                        fontSize: 12.0),
                    validator: (password) => validateInput(password),
                    onSaved: (password) =>
                        authenticate.setUserPassword(password),
                    obscureText: !_visiblePassword,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.lock_outlined,
                            color: Colors.grey,
                          ),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () => visiblePassword(),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.visibility_outlined,
                              color: Colors.grey,
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
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: secundaryColor),
                            onPressed: () async {
                              try {
                                setState(() {
                                  authenticate.status =
                                      AuthenticateEnum.loading;
                                });

                                if (await authenticate.login()) {
                                  setState(() {
                                    authenticate.status =
                                        AuthenticateEnum.logged;
                                  });
                                } else {
                                  setState(() {
                                    authenticate.status =
                                        AuthenticateEnum.notLogged;
                                  });
                                }
                              } on AuthenticationException catch (e) {
                                WidgetsBinding.instance!
                                    .addPostFrameCallback((_) {
                                  showError(context, e.toString());
                                });
                                setState(() {
                                  authenticate.status = AuthenticateEnum.error;
                                });
                              } on TimeoutException catch (e) {
                                WidgetsBinding.instance!
                                    .addPostFrameCallback((_) {
                                  showError(context, e.toString());
                                });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('Logar',
                                  style: textStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
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
                                      color: Color.fromRGBO(195, 184, 184, 1),
                                      fontWeight: FontWeight.w400)),
                              TextSpan(
                                  text: '9999-9999',
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 207, 128, 0.8),
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded _loading() {
    return Expanded(
      flex: 4,
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [CircularProgressIndicator()],
              ),
            ),
          ),
        ],
      ),
    );
  }

  stateManagement(context) {
    switch (authenticate.status) {
      case AuthenticateEnum.notLogged:
        return _form();
      case AuthenticateEnum.loading:
        return _loading();
      case AuthenticateEnum.logged:
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(context, '/home');
        });

        return Container();

      case AuthenticateEnum.error:
        return _form();

      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  Container(
                    color: primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(48.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.center,
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                const Icon(
                                  Icons.inventory_2_outlined,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Gerenciamento de Peças e Pedidos',
                                  style: textStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  stateManagement(context),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          body: Center(
            child: SizedBox(
              height: 500,
              width: 360,
              child: Column(
                children: [
                  Container(
                    color: primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 48),
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 12,
                                runSpacing: 12,
                                children: [
                                  const Icon(Icons.inventory_2_outlined,
                                      size: 48, color: Colors.white),
                                  Text(
                                    'Gerenciamento de Peças e Pedidos',
                                    style: textStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  stateManagement(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

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
                          height: 140.0,
                          width: 340.0,
                          decoration: BoxDecoration(
                            color: primaryColor,

                            //borderRadius: new BorderRadius.only(
                            // topLeft: const Radius.circular(16.0),
                            //topRight: const Radius.circular(16.0),
                            //)
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
                              width: 340.0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 16.0),
                                      child: Row(
                                        children: [
                                          Text('Login',
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      0, 0, 0, 1),
                                                  fontSize: mediaQuery
                                                          .textScaleFactor *
                                                      14.0,
                                                  fontWeight: FontWeight.w700))
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text('RE',
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    0, 0, 0, 1),
                                                fontStyle: FontStyle.normal,
                                                fontSize:
                                                    mediaQuery.textScaleFactor *
                                                        12.0,
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
                                            height: 40,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(
                                                          10.0),
                                                  prefixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: SvgPicture.asset(
                                                        '../../../lib/src/shared/assets/user.svg',
                                                        color: const Color
                                                                .fromRGBO(
                                                            191, 183, 183, 1),
                                                        semanticsLabel:
                                                            'Gerenciamento de peças e pedidos'),
                                                  ),
                                                  hintText: 'Digite seu RE',
                                                  hintStyle: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          191, 183, 183, 1),
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 1.8,
                                                      fontSize: 12.0),
                                                  filled: true,
                                                  fillColor:
                                                      const Color.fromRGBO(
                                                          195, 184, 184, 0.26),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    borderSide: BorderSide.none,
                                                  )),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      children: [
                                        Text('Senha',
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    0, 0, 0, 1),
                                                fontSize:
                                                    mediaQuery.textScaleFactor *
                                                        12.0,
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
                                            height: 40,
                                            child: TextField(
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(
                                                          10.0),
                                                  prefixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: SvgPicture.asset(
                                                        '../../../lib/src/shared/assets/password.svg',
                                                        color: const Color
                                                                .fromRGBO(
                                                            191, 183, 183, 1),
                                                        semanticsLabel:
                                                            'Gerenciamento de peças e pedidos'),
                                                  ),
                                                  suffixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: SvgPicture.asset(
                                                        '../../../lib/src/shared/assets/eye_password.svg',
                                                        color: const Color
                                                                .fromRGBO(
                                                            191, 183, 183, 1),
                                                        semanticsLabel:
                                                            'Gerenciamento de peças e pedidos'),
                                                  ),
                                                  hintText: 'Digite sua senha',
                                                  hintStyle: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          191, 183, 183, 1),
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 1.8,
                                                      fontSize: 12.0),
                                                  filled: true,
                                                  fillColor:
                                                      const Color.fromRGBO(
                                                          195, 184, 184, 0.26),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    borderSide: BorderSide.none,
                                                  )),
                                            ),
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
                                          child: ElevatedButton(
                                              onPressed: () => {},
                                              style: ElevatedButton.styleFrom(
                                                  primary: secundaryColor),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text('Entrar',
                                                    style: TextStyle(
                                                        color: const Color
                                                                .fromRGBO(
                                                            255, 255, 255, 1),
                                                        fontSize: mediaQuery
                                                                .textScaleFactor *
                                                            12.0,
                                                        fontWeight:
                                                            FontWeight.w700)),
                                              )),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: RichText(
                                            text: const TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text:
                                                        'Em caso de dúvida entre em contato com o suporte através do telefone ',
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            195, 184, 184, 1),
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                TextSpan(
                                                    text: '9999-9999',
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 207, 128, 0.8),
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Row(
                                      children: const [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Center(
                                              child: Text('Versão 1.0.0',
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Color.fromRGBO(
                                                          195, 184, 184, 1),
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
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

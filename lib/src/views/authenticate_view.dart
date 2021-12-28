import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/authenticate_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/repositories/authenticate_repository.dart';
import 'package:gpp/src/shared/enumeration/authenticate_enum.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

class AuthenticateView extends StatefulWidget {
  const AuthenticateView({Key? key}) : super(key: key);

  @override
  _AuthenticateViewState createState() => _AuthenticateViewState();
}

class _AuthenticateViewState extends State<AuthenticateView> {
  late AuthenticateController _authenticate;
  final ResponsiveController _responsive = ResponsiveController();
  bool _visiblePassword = false;

  void visiblePassword() {
    setState(() {
      _visiblePassword = !_visiblePassword;
    });
  }

  validateInput(value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  handleAutheticated(context) async {
    try {
      setState(() {
        _authenticate.state = AuthenticateEnum.loading;
      });

      if (await _authenticate.login()) {
        setState(() {
          _authenticate.state = AuthenticateEnum.logged;
        });
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          _authenticate.state = AuthenticateEnum.notLogged;
        });
      }
    } catch (e) {
      NotifyController nofity =
          NotifyController(context: context, message: e.toString());
      nofity.error();
      setState(() {
        _authenticate.state = AuthenticateEnum.error;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _authenticate = AuthenticateController(AuthenticateRepository());
  }

  Form _buildFormAuthenticated(MediaQueryData mediaQuery) {
    return Form(
      key: _authenticate.formKey,
      child: Expanded(
        flex: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text('Login',
                      textScaleFactor: mediaQuery.textScaleFactor,
                      style: textStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.w700)),
                ),
                Text('RE',
                    style: textStyle(
                        color: Colors.black, fontWeight: FontWeight.w700)),
                TextFormField(
                  maxLength: 255,
                  onSaved: (uid) => _authenticate.setUserUID(uid),
                  validator: (value) => validateInput(value),
                  keyboardType: TextInputType.number,
                  style: textStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 14,
                      height: 1.8),
                  decoration: inputDecoration(
                      'Digite seu RE', const Icon(Icons.account_box)),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text('Senha',
                    style: textStyle(
                        color: Colors.black, fontWeight: FontWeight.w700)),
                TextFormField(
                  maxLength: 50,
                  validator: (password) => validateInput(password),
                  onSaved: (password) =>
                      _authenticate.setUserPassword(password),
                  obscureText: !_visiblePassword,
                  style: textStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 14,
                      height: 1.8),
                  decoration: inputDecoration(
                      'Digite sua senha', const Icon(Icons.lock),
                      suffixIcon: GestureDetector(
                        onTap: () => visiblePassword(),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.visibility,
                            color: Colors.grey,
                          ),
                        ),
                      )),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              elevation: 0,
                              primary: primaryColor),
                          onPressed: () => handleAutheticated(context),
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
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      'Em caso de dúvida, entre em contato com o suporte através do telefone ',
                                  style: textStyle(
                                      color: Colors.grey.shade400,
                                      fontWeight: FontWeight.w700)),
                              const TextSpan(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildLoading() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: secundaryColor,
          )
        ],
      ),
    );
  }

  _buildAuthenticated(context, MediaQueryData mediaQuery) {
    switch (_authenticate.state) {
      case AuthenticateEnum.notLogged:
        return _buildFormAuthenticated(mediaQuery);
      case AuthenticateEnum.loading:
        return _buildLoading();
      case AuthenticateEnum.logged:
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(context, '/home');
        });

        return Container();

      case AuthenticateEnum.error:
        return _buildFormAuthenticated(mediaQuery);

      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // return ResponsiveBuilder(
    //   builder: (context, sizingInformation) {
    //     if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
    //       return SafeArea(
    //         child: Scaffold(
    //             resizeToAvoidBottomInset: false,
    //             body: Stack(
    //               children: [
    //                 Column(
    //                   mainAxisAlignment: MainAxisAlignment.end,
    //                   children: [
    //                     Container(
    //                       height: 440,
    //                       color: Colors.white,
    //                       child: _buildAuthenticated(context),
    //                     ),
    //                     Container(
    //                       color: primaryColor,
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         children: [
    //                           SizedBox(
    //                             height: 40,
    //                             width: 160,
    //                             child: Image.asset(
    //                                 'lib/src/shared/assets/brand.png'),
    //                           )
    //                         ],
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //                 ClipPath(
    //                   clipper: CustomClipPath(),
    //                   child: Container(
    //                     height: 120,
    //                     color: secundaryColor,
    //                   ),
    //                 ),
    //                 ClipPath(
    //                   clipper: CustomClipPath(),
    //                   child: Expanded(
    //                     child: Container(
    //                       height: 115,
    //                       width: double.infinity,
    //                       color: primaryColor,
    //                       child: Column(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Padding(
    //                             padding: const EdgeInsets.only(left: 24),
    //                             child: Text('GPP',
    //                                 style: textStyle(
    //                                     fontSize: 32,
    //                                     color: Colors.white,
    //                                     fontWeight: FontWeight.w700)),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             )),
    //       );
    //     }

    //     return SafeArea(
    //       child: Scaffold(
    //         backgroundColor: primaryColor,
    //         body: Column(
    //           children: [
    //             Row(
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(
    //                       vertical: 20, horizontal: 140),
    //                   child: SizedBox(
    //                       width: 240,
    //                       child:
    //                           Image.asset('lib/src/shared/assets/brand.png')),
    //                 )
    //               ],
    //             ),
    //             Expanded(
    //               child: Row(
    //                 children: [
    //                   Expanded(
    //                     child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         Container(
    //                           width: 400,
    //                           height: 460,
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               Text(
    //                                 'Bem vindo ao',
    //                                 style: textStyle(
    //                                     fontSize: 48,
    //                                     color: Colors.white,
    //                                     fontWeight: FontWeight.w700),
    //                               ),
    //                               Padding(
    //                                 padding: const EdgeInsets.symmetric(
    //                                     vertical: 24),
    //                                 child: Text(
    //                                   'Gerenciamento de Peças e Pedidos',
    //                                   style: textStyle(
    //                                       fontSize: 48,
    //                                       color: Colors.white,
    //                                       fontWeight: FontWeight.w700),
    //                                 ),
    //                               ),
    //                               Spacer(),
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   Expanded(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         Container(
    //                           width: 400,
    //                           decoration: BoxDecoration(
    //                             borderRadius: BorderRadius.circular(10),
    //                             color: Colors.white,
    //                           ),
    //                           child: _buildAuthenticated(context),
    //                         ),
    //                       ],
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );

    Widget page = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (_responsive.isMobile(constraints.maxWidth)) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: mediaQuery.size.height,
                decoration: const BoxDecoration(
                  // borderRadius: BorderRadius.only(
                  //     topLeft: Radius.circular(24),
                  //     topRight: Radius.circular(24)),
                  color: Colors.white,
                ),
                child: _buildAuthenticated(context, mediaQuery),
              ),
            ],
          );
        }

        if (_responsive.isTable(constraints.maxWidth)) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildMessageWelcome(),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 400,
                    height: 460,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: _buildAuthenticated(context, mediaQuery),
                  ),
                ],
              )
            ],
          );
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [_buildMessageWelcome()],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 400,
                        height: 460,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: _buildAuthenticated(context, mediaQuery),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      },
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(mediaQuery.size.height * 0.20),
        child: _buildAppBar(mediaQuery),
      ),
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: page,
      ),
    );
  }

  LayoutBuilder _buildAppBar(MediaQueryData mediaQuery) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (_responsive.isMobile(constraints.maxWidth)) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBrand(mediaQuery),
                SizedBox(
                  height: 40,
                  width: 160,
                  child: Image.asset('lib/src/shared/assets/brand.png'),
                )
              ],
            ));
      } else {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBrand(mediaQuery),
                SizedBox(
                  height: 40,
                  width: 160,
                  child: Image.asset('lib/src/shared/assets/brand.png'),
                )
              ],
            ));
      }
    });
  }

  Text _buildBrand(MediaQueryData mediaQuery) {
    return Text(
      'GPP',
      textScaleFactor: mediaQuery.textScaleFactor,
      style: textStyle(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  SizedBox _buildMessageWelcome() {
    return SizedBox(
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bem vindo ao',
            style: textStyle(
                fontSize: 42, color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Text(
              'Gerenciamento de Peças e Pedidos',
              style: textStyle(
                  fontSize: 42,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/authenticate_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/repositories/authenticate_repository.dart';
import 'package:gpp/src/shared/components/button_primary_component.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/enumeration/authenticate_enum.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/views/loading_view.dart';

class AuthenticateView extends StatefulWidget {
  const AuthenticateView({Key? key}) : super(key: key);

  @override
  _AuthenticateViewState createState() => _AuthenticateViewState();
}

class _AuthenticateViewState extends State<AuthenticateView> {
  late AuthenticateController _controller =
      AuthenticateController(AuthenticateRepository());
  final ResponsiveController _responsive = ResponsiveController();

  void handleVisiblePassword() {
    setState(() {
      _controller.visiblePassword = !_controller.visiblePassword;
    });
  }

  void handleAutheticated(context) async {
    NotifyController nofity = NotifyController(context: context);
    try {
      setState(() {
        _controller.state = AuthenticateEnum.loading;
      });

      if (await _controller.login()) {
        setState(() {
          _controller.state = AuthenticateEnum.logged;
        });
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          _controller.state = AuthenticateEnum.notLogged;
        });
      }
    } catch (e) {
      nofity.error(e.toString());
      setState(() {
        _controller.state = AuthenticateEnum.error;
      });
    }
  }

  Form _buildFormAuthenticated(MediaQueryData mediaQuery) {
    return Form(
      key: _controller.formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text('Login',
                    textScaleFactor: mediaQuery.textScaleFactor,
                    style: textStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w700)),
              ),
              InputComponent(
                label: "RE",
                maxLength: 255,
                onSaved: _controller.setUserUID,
                validator: _controller.validateInput,
                hintText: "Digite seu RE",
                prefixIcon: Icon(Icons.account_box),
              ),
              const SizedBox(
                height: 12,
              ),
              InputComponent(
                label: "Senha",
                obscureText: !_controller.visiblePassword,
                maxLength: 50,
                onSaved: _controller.setUserPassword,
                validator: _controller.validateInput,
                hintText: "Digite sua senha",
                prefixIcon: Icon(Icons.lock),
                suffixIcon: GestureDetector(
                  onTap: () => handleVisiblePassword(),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ButtonPrimaryComponent(
                        onPressed: () => handleAutheticated(context),
                        text: "Logar"),
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
    );
  }

  _buildState(context, MediaQueryData mediaQuery) {
    switch (_controller.state) {
      case AuthenticateEnum.loading:
        return LoadingView();

      default:
        return _buildFormAuthenticated(mediaQuery);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    Widget page = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (_responsive.isMobile(constraints.maxWidth)) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: mediaQuery.size.height,
                color: Colors.white,
                child: _buildState(context, mediaQuery),
              ),
            ],
          );
        }

        if (_responsive.isTable(constraints.maxWidth)) {
          return Column(
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
                    child: _buildState(context, mediaQuery),
                  ),
                ],
              )
            ],
          );
        }

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 140),
              child: SizedBox(
                height: mediaQuery.size.height * 0.90,
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
                          width: 340,
                          height: 460,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: _buildState(context, mediaQuery),
                        ),
                      ],
                    )
                  ],
                ),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: page,
        ),
      ),
    );
  }

  LayoutBuilder _buildAppBar(MediaQueryData mediaQuery) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (_responsive.isMobile(constraints.maxWidth)) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildBrand(mediaQuery),
                SizedBox(
                  width: 160,
                  child: Image.asset('lib/src/shared/assets/brand.png'),
                )
              ],
            ));
      } else {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 140),
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
      'gpp',
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

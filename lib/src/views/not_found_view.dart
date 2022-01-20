import 'package:flutter/material.dart';

class NotFoundView extends StatelessWidget {
  const NotFoundView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
            "https://thumbs.dreamstime.com/b/ilustra%C3%A7%C3%A3o-de-vetor-colorida-erro-desconex%C3%A3o-da-internet-n%C3%A3o-dispon%C3%ADvel-pessoas-conectam-acesso-%C3%A0-ilustra-o-do-156664862.jpg"),
      ),
    );
  }
}

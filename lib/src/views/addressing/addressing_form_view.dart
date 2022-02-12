import 'package:flutter/material.dart';

class AddressingFormView extends StatefulWidget {
  const AddressingFormView({Key? key}) : super(key: key);

  @override
  _AddressingFormViewState createState() => _AddressingFormViewState();
}

class _AddressingFormViewState extends State<AddressingFormView> {
  var contador = 0;

  @override
  Widget build(BuildContext context) {
    print("teste ${contador++}");
    MediaQueryData media = MediaQuery.of(context);

    return Column(
      children: [
        Container(
          color: Colors.blue,
          height: media.size.height * 0.7,
        )
      ],
    );
  }
}
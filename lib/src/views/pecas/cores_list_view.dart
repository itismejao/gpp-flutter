import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_cor_controller.dart';
import 'package:gpp/src/models/pecas_model/pecas_cor_model.dart';

class CoresListView extends StatefulWidget {
  const CoresListView({Key? key}) : super(key: key);

  @override
  _CoresListViewState createState() => _CoresListViewState();
}

class _CoresListViewState extends State<CoresListView> {
  PecasCorController _pecasCorController = PecasCorController();

  @override
  initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    // _pecasCorController.buscarTodos();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _pecasCorController.buscarTodos2(),
      builder: (context, AsyncSnapshot snapshot) {
        print('Aqui 1');

        List<PecasCorModel> _pecaCorCor = snapshot.data;
        print('Aqui 2');
        return Container(
          width: 500,
          height: 500,
          child: ListView.builder(
            itemCount: _pecaCorCor.length,
            itemBuilder: (context, index) {
              return Text(_pecaCorCor[index].cor.toString());
            },
          ),
        );
      },
    );
  }
}

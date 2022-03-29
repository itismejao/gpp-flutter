// import 'package:flutter/material.dart';
// import 'package:gpp/src/shared/components/TextButtonComponent.dart';
// import 'package:gpp/src/shared/components/TextComponent.dart';

// class NotifyController {
//   BuildContext context;

//   NotifyController({
//     required this.context,
//   });

//   void error2(String message) {
//     final snackBar = SnackBar(
//         duration: const Duration(seconds: 5),
//         backgroundColor: Colors.red,
//         content: Text(message));
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   void error(String? message) {
//     // if (message != null) {
//     //   final snackBar = SnackBar(
//     //       duration: const Duration(seconds: 5),
//     //       backgroundColor: Colors.red,
//     //       content: Text(message));
//     //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     // }
//   }

//   void sucess(String message) {
//     final snackBar = SnackBar(
//         duration: const Duration(seconds: 5),
//         backgroundColor: Colors.green,
//         content: Text(message));
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   Future<bool> alerta(String message) async {
//     return await showDialog(
//       context: context,
//       builder: (context) {
//         final media = MediaQuery.of(context);

//         return AlertDialog(
//           title: TextComponent(
//             'Aviso',
//             fontWeight: FontWeight.bold,
//             fontSize: 22,
//           ),
//           content: TextComponent(
//             message,
//             color: Colors.grey.shade500,
//             fontWeight: FontWeight.normal,
//           ),
//           actions: <Widget>[
//             Container(
//               width: media.size.width * 0.40,
//               height: media.size.height * 0.05,
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButtonComponent(
//                           onPressed: () {
//                             Navigator.of(context, rootNavigator: true)
//                                 .pop(true);
//                           },
//                           text: 'Ok')
//                     ],
//                   )
//                 ],
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }

//   Future<bool> confirmacao(String message) async {
//     return await showDialog(
//       context: context,
//       builder: (context) {
//         final media = MediaQuery.of(context);

//         return AlertDialog(
//           title: TextComponent(
//             'Confirmação',
//             fontWeight: FontWeight.bold,
//             fontSize: 22,
//           ),
//           content: TextComponent(
//             message,
//             color: Colors.grey.shade500,
//             fontWeight: FontWeight.normal,
//           ),
//           actions: <Widget>[
//             Container(
//               width: media.size.width * 0.40,
//               height: media.size.height * 0.05,
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButtonComponent(
//                         onPressed: () {
//                           Navigator.of(context, rootNavigator: true).pop(false);
//                         },
//                         text: 'Não',
//                       ),
//                       SizedBox(
//                         width: 8,
//                       ),
//                       TextButtonComponent(
//                           onPressed: () {
//                             Navigator.of(context, rootNavigator: true)
//                                 .pop(true);
//                           },
//                           text: 'Sim')
//                     ],
//                   )
//                 ],
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }

//   warning(String message) async {
//     await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Alerta!'),
//           content: Text(message),
//           actions: <Widget>[
//             GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.red, borderRadius: BorderRadius.circular(5)),
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       top: 15, left: 25, bottom: 15, right: 25),
//                   child: Text(
//                     "OK",
//                     style: TextStyle(
//                         color: Colors.white, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

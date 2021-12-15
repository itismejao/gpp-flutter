import 'package:flutter/material.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

Padding versionComponent() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      'Versão 1.0.0',
      style: textStyle(
          color: const Color.fromRGBO(191, 183, 183, 1),
          fontWeight: FontWeight.w700,
          fontSize: 12,
          height: 1.8),
    ),
  );
}

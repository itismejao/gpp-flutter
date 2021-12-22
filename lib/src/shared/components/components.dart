import 'package:flutter/material.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

Text versionComponent() {
  return Text(
    'Versão 1.0.0',
    style: textStyle(
      color: Colors.grey.shade300,
      fontWeight: FontWeight.w700,
      fontSize: 12,
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:learning_flutter/currency_converter_curpertino_page.dart';
import 'package:learning_flutter/currency_converter_material_page.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyCurpertinoApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(home: CurrencyConverterMaterialPage());
  }
}

class MyCurpertinoApp extends StatelessWidget {
  const MyCurpertinoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(home: CurrencyConverterCurpertinoPage());
  }
}

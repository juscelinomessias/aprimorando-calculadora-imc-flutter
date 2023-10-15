import 'package:aprimorando_calculadora_de_imc/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Impede a rotação para paisagem
    DeviceOrientation.portraitDown, // Impede a rotação para paisagem invertida
  ]).then((_) {
    runApp(const MyApp());
  });
}

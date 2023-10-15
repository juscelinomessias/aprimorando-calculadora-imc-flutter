import 'package:flutter/material.dart';

class Imc {
  final String _id = UniqueKey().toString();
  double _peso = 0;
  double _altura = 0;
  String _resultado = "";

  Imc(this._peso, this._altura, this._resultado);

  String getId() {
    return _id;
  }

  double getPeso() {
    return _peso;
  }

  String getResultado() {
    return _resultado;
  }

  void setPeso(double peso) {
    _peso = peso;
  }

  double getAltura() {
    return _altura;
  }

  void setAltura(double altura) {
    _altura = altura;
  }

  void setResultado(String resultado) {
    _resultado = resultado;
  }
}

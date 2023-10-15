import 'package:aprimorando_calculadora_de_imc/classes/Imc.dart';
import 'package:flutter/material.dart';

class ResultadoImcPage extends StatefulWidget {
  final List<Imc> imcs;
  const ResultadoImcPage({Key? key, required this.imcs}) : super(key: key);

  @override
  State<ResultadoImcPage> createState() => _ResultadoImcPageState();
}

class _ResultadoImcPageState extends State<ResultadoImcPage> {
  @override
  Widget build(BuildContext context) {
    final _imcs = widget.imcs; // Acesse a lista de Imc através do widget

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resultados"),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
          child: ListView.separated(
            itemCount: _imcs.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemBuilder: (BuildContext context, int index) {
              var imc = _imcs.reversed.elementAt(index);
              return ListTile(
                title: Text("IMC: ${imc.getResultado().toString()}"),
                subtitle: Text(
                  "Peso: ${imc.getPeso().toStringAsFixed(2)} kg\nAltura: ${imc.getAltura().toStringAsFixed(2)} m",
                ),
              );
            },
          )),
    );
  }
}

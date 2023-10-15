import 'package:aprimorando_calculadora_de_imc/classes/Imc.dart';
import 'package:aprimorando_calculadora_de_imc/paginas/resultados_imc_page.dart';
import 'package:aprimorando_calculadora_de_imc/repositorios/imc_repositorio.dart';
import 'package:flutter/material.dart';

class CustonDrawer extends StatefulWidget {
  final List<Imc> imcs;
  const CustonDrawer({Key? key, required this.imcs}) : super(key: key);

  @override
  State<CustonDrawer> createState() => _CustonDrawerState();
}

class _CustonDrawerState extends State<CustonDrawer> {
  var imcRepositorio = ImcRepositorio();
  final _imcs = const <Imc>[];

  @override
  Widget build(BuildContext context) {
    final _imcs = widget.imcs; // Acesse a lista de Imc através do widget
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.amber),
              currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset('lib/imagens/logo-imc.png')),
              accountName: const Text("Juscelino Messias"),
              accountEmail: const Text("linooow@gmail.com")),
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              width: double.infinity,
              child: const Row(
                children: [
                  Icon(Icons.medical_services),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Resultados"),
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultadoImcPage(
                      imcs: _imcs), // Passar _imcs para ResultadoImcPage
                ),
              );
            },
          ),
          const Divider()
        ],
      ),
    );
  }
}

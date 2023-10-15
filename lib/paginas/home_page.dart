import 'package:aprimorando_calculadora_de_imc/classes/Imc.dart';
import 'package:aprimorando_calculadora_de_imc/repositorios/imc_repositorio.dart';
import 'package:aprimorando_calculadora_de_imc/servicos/calcular_imc_servico.dart';
import 'package:aprimorando_calculadora_de_imc/shared/widgets/custon_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var pesoController = TextEditingController();
  var alturaController = TextEditingController();

  var imcRepositorio = ImcRepositorio();
  var _imcs = const <Imc>[];

  @override
  void initState() {
    super.initState();
    obterImcs();
  }

  void obterImcs() async {
    _imcs = await imcRepositorio.listarImcs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("IMC")),
      drawer: CustonDrawer(imcs: _imcs),
      body: PageView(
        children: [
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        Expanded(
                          flex: 5,
                          child: Image.asset(
                            'lib/imagens/logo-imc.png',
                            height: 250,
                          ),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Calculadora de IMC",
                        style: TextStyle(
                            fontSize: 26,
                            color: Color(0xff9e5696),
                            fontWeight: FontWeight.w700)),
                    const Text("Como está a sua saúde?",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff5a3353),
                            fontWeight: FontWeight.w700)),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        controller: pesoController,
                        style: const TextStyle(color: Color(0xFF9d5596)),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 16, 26, 16),
                          hintText: "Peso",
                          hintStyle: const TextStyle(color: Color(0xff9e5696)),
                          filled: true,
                          fillColor: const Color(0xFFffffff),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(
                            Icons.speed,
                            color: Color(0xff9e5696),
                            size: 27,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        controller: alturaController,
                        style: const TextStyle(color: Color(0xFF9d5596)),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 16, 26, 16),
                          hintText: "Altura",
                          hintStyle: const TextStyle(color: Color(0xff9e5696)),
                          filled: true,
                          fillColor: const Color(0xFFffffff),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(
                            Icons.accessibility,
                            color: Color(0xff9e5696),
                            size: 27,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: TextButton(
                          onPressed: () async {
                            final peso =
                                double.tryParse(pesoController.text) ?? 0.0;
                            final altura =
                                double.tryParse(alturaController.text) ?? 0.0;
                            final resultadoImc =
                                await CalcularImcServico.calcularImc(
                                    peso, altura);

                            await imcRepositorio
                                .adicionar(Imc(peso, altura, resultadoImc));

                            setState(() => {});
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff5b3353),
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                32, 16, 32, 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text(
                            "Calcular",
                            style: TextStyle(
                                color: Color(0xffffc906), fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: ListView.separated(
                          itemCount:
                              1, // Defina o número de itens para 1 para exibir apenas o último valor
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                          itemBuilder: (BuildContext context, int index) {
                            if (_imcs.isNotEmpty) {
                              final lastImc = _imcs.last;
                              return ListTile(
                                title: Text(
                                    "IMC: ${lastImc.getResultado().toString()}"),
                                subtitle: Text(
                                  "Peso: ${lastImc.getPeso().toStringAsFixed(2)} kg\nAltura: ${lastImc.getAltura().toStringAsFixed(2)} m",
                                ),
                              );
                            } else {
                              return const ListTile(
                                title: Center(
                                  child: Text(
                                    "Nenhum resultado disponível.",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff5a3353),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

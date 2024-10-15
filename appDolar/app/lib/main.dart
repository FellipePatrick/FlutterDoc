import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    routes: <String, WidgetBuilder>{
      '/': (BuildContext context) => const Home(),
      '/valores': (BuildContext context) => const About(),
    },
  ));
}

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Recebe o argumento passado para a rota (se é X ou Y)
    final String valueLabel =
        ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text('Preencher valor de $valueLabel'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Informe o valor de $valueLabel:'),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Retorna o valor informado para a tela anterior
                  Navigator.pop(context, double.tryParse(_controller.text));
                },
                child: const Text("Enviar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double? x; // Variável para armazenar o valor de X
  double? y; // Variável para armazenar o valor de Y

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('Calculadora'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("X: "),
                TextButton(
                  child: Text(x != null ? x.toString() : "Informar X"),
                  onPressed: () async {
                    // Navega para a tela de valores, passando 'X' como parâmetro
                    final result = await Navigator.pushNamed(
                      context,
                      "/valores",
                      arguments: "X",
                    );
                    if (result != null) {
                      setState(() {
                        x = result as double;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Y: "),
                TextButton(
                  child: Text(y != null ? y.toString() : "Informar Y"),
                  onPressed: () async {
                    // Navega para a tela de valores, passando 'Y' como parâmetro
                    final result = await Navigator.pushNamed(
                      context,
                      "/valores",
                      arguments: "Y",
                    );
                    if (result != null) {
                      setState(() {
                        y = result as double;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Calcular"),
              onPressed: (x != null && y != null)
                  ? () {
                      // Realiza o cálculo e exibe o resultado
                      final double result = x! + y!;
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text("Resultado: $result"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  : null, // Só permite o cálculo se X e Y estiverem preenchidos
            ),
            const SizedBox(height: 20),
            Text(
                "Resultado: ${x != null && y != null ? x! + y! : 'Preencha os valores de X e Y'}"),
          ],
        ),
      ),
    );
  }
}

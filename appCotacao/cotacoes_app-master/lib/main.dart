import 'dart:io';
import 'package:cotacoes_app/widgets/card_bolsa_valores.dart';
import 'package:cotacoes_app/widgets/card_cotacao_dollar.dart';
import 'package:cotacoes_app/widgets/card_outras_moedas.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: const HomeMaterial(),
    );
  }
}

class HomeMaterial extends StatefulWidget {
  const HomeMaterial({super.key});

  @override
  State<HomeMaterial> createState() => _HomeMaterialState();
}

class _HomeMaterialState extends State<HomeMaterial> {
  late Future<Map<String, dynamic>> dadosCotacoes;

  @override
  void initState() {
    super.initState();
    dadosCotacoes = getDadosCotacoes();
  }

  Future<Map<String, dynamic>> getDadosCotacoes() async {
    try {
      final res = await http.get(
        Uri.parse(
          'http://api.hgbrasil.com/finance/quotations?key=<suakey>', // Substitua <suakey> pela sua chave
        ),
      );

      if (res.statusCode != HttpStatus.ok) {
        throw 'Erro de conexão';
      }

      final data = jsonDecode(res.body);
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cotações Brasil',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                dadosCotacoes = getDadosCotacoes(); // Atualiza os dados
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: dadosCotacoes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              // Verifica se "results" e "currencies" existem e são mapas
              if (snapshot.data!["results"] != null &&
                  snapshot.data!["results"]["currencies"] is Map) {
                Map<String, dynamic> currencies =
                    snapshot.data!["results"]["currencies"];

                // Dados do dólar
                String nomeMoeda = currencies["USD"]["name"] ?? "Desconhecido";
                double cotacao = currencies["USD"]["buy"]?.toDouble() ?? 0.0;
                double variacao =
                    currencies["USD"]["variation"]?.toDouble() ?? 0.0;

                // Dados da bolsa
                String nomeIndice = snapshot.data!["results"]["stocks"]
                        ["IBOVESPA"]["name"] ??
                    "IBOVESPA";
                String localizacao = snapshot.data!["results"]["stocks"]
                        ["IBOVESPA"]["location"] ??
                    "Desconhecido";
                String cotacaoBolsa = snapshot.data!["results"]["stocks"]
                            ["IBOVESPA"]["last"]
                        ?.toString() ??
                    "0.0";

                return ListView(
                  children: [
                    // Card principal para cotação do dólar
                    CardCotacaoDollar(
                      nomeMoeda: nomeMoeda,
                      cotacao: cotacao,
                      variacao: variacao,
                    ),
                    const SizedBox(height: 20),

                    // Seção de outras moedas
                    const Text(
                      'Outras Moedas',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: currencies.entries.map((entry) {
                          // Verifique se as chaves e valores são do tipo esperado
                          if (entry.value is Map) {
                            String name = entry.value["name"] ?? "Desconhecido";
                            double buy = entry.value["buy"]?.toDouble() ?? 0.0;
                            double variation =
                                entry.value["variation"]?.toDouble() ?? 0.0;

                            return Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: CardOutrasMoedas(
                                nomeMoeda: name,
                                cotacao: buy,
                                variacao: variation,
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Seção da bolsa de valores
                    const Text(
                      'Bolsa de Valores',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Passando dados para o CardBolsaValores
                        CardBolsaValores(
                          nomeIndice: nomeIndice,
                          localizacao: localizacao,
                          cotacao: cotacaoBolsa,
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text(
                    "Dados não encontrados",
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                );
              }
            }
            return const Center(
              child: Text(
                "Algum erro aconteceu",
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CardCotacaoDollar extends StatelessWidget {
  final String nomeMoeda;
  final double cotacao;
  final double variacao;

  const CardCotacaoDollar({
    super.key,
    required this.nomeMoeda,
    required this.cotacao,
    required this.variacao,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                nomeMoeda,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Cotação: R\$ ${cotacao.toStringAsFixed(2)}', // Formatação para moeda
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                'Variação: ${variacao.toStringAsFixed(2)}%', // Formatação para percentual
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

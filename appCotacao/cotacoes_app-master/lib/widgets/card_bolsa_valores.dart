import 'package:flutter/material.dart';

class CardBolsaValores extends StatelessWidget {
  final String nomeIndice; // Nome do índice
  final String localizacao; // Localização
  final String cotacao; // Cotação do índice

  const CardBolsaValores({
    super.key,
    required this.nomeIndice,
    required this.localizacao,
    required this.cotacao,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          nomeIndice,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          localizacao,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          cotacao,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

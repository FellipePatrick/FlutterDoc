import 'package:flutter/material.dart';

class CardOutrasMoedas extends StatelessWidget {
  final String nomeMoeda;
  final double cotacao;
  final double variacao;

  const CardOutrasMoedas({
    super.key,
    required this.nomeMoeda,
    required this.cotacao,
    required this.variacao,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              nomeMoeda,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              cotacao.toStringAsFixed(4),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              variacao.toString(),
              style: TextStyle(
                fontSize: 14,
                color: variacao >= 0 ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

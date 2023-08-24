import 'package:app1/models/exercicio_model.dart';
import 'package:app1/models/sentimentos_model.dart';
import 'package:flutter/material.dart';

class ExecicioTela extends StatelessWidget {
  ExecicioTela({super.key});

  final ExercicioModel exercicioModel = ExercicioModel(
    id: "1",
    name: "Remada Baixa",
    treino: "Treino A", 
    comoFazer: "Segura a barra e puxa");

  final List<sentimentosModel> listaSentimentos = [
    sentimentosModel(id: "01", sentimento: "Ativacao", data: "2022-02-07"),
    sentimentosModel(id: "02", sentimento: "Ativacao", data: "2022-02-19")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Puxada Alta Pronada - Treino A")),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("FAB FOI CLICADO!");
        }, 
        child: const Icon(Icons.add),),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: (){}, 
                child: const Text("Enviar foto"),
              ),
              const Text(
                "Como fazer?", 
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 18),),
                  const Text("Segura com as duas mãos"),
                  Divider(),
              const Text(
                "Como estou me sentindo?", 
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 18),),
                  const Text("Senti ativação"),
          ]      
          ,),
        )
      );
  }
}
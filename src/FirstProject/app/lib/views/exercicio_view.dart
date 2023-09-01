import 'package:app1/models/exercicio_model.dart';
import 'package:app1/models/sentimentos_model.dart';
import 'package:flutter/material.dart';

class ExecicioTela extends StatelessWidget {
  ExecicioTela({super.key});

  final ExercicioModel exercicioModel = ExercicioModel(
    id: "1",
    name: "Remada Baixa",
    treino: "Treino A", 
    comoFazer: " Na remada baixa, é essencial que, mesmo sem apoio, você mantenha as costas eretas e o torso vertical.");

  final List<sentimentosModel> listaSentimentos = [
    sentimentosModel(id: "01", sentimento: "Senti Ativacao", data: "2022-02-07"),
    sentimentosModel(id: "02", sentimento: "Senti Sono", data: "2022-02-19")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
        appBar: AppBar(title: Text("${exercicioModel.name} - ${exercicioModel.treino}")),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("FAB FOI CLICADO!");
        }, 
        child: const Icon(Icons.add),),
        body: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(8),
          child: ListView(
            children: [
              SizedBox(
                height: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        print("Foto enviada");
                      }, 
                      child: const Text("Enviar foto"),
                    ),
                    ElevatedButton(
                      onPressed: (){}, 
                      child: const Text("Enviar Foto"),)
                  ],
                ),
              ),
              const SizedBox(height: 16,),
              const Text(
                "Como fazer?", 
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 18),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${exercicioModel.comoFazer} "),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(color: Colors.black,),
                  ),
              const SizedBox(height: 8,),
              const Text(
                "Como estou me sentindo?", 
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 18),),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(listaSentimentos.length, (index) {
                      sentimentosModel sentimento = listaSentimentos[index];
                      return ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Text(sentimento.sentimento), 
                        subtitle: Text(sentimento.data),
                        leading: const Icon(Icons.double_arrow),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete, 
                            color: Colors.red), 
                          onPressed:(){
                            print("Deletando ${sentimento.sentimento}");
                        },)
                        );
                    }),
                  )
          ]      
          ,),
        )
      );
  }
}
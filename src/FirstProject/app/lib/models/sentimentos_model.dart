class sentimentosModel{
  String id;
  String sentimento;
  String data;

  sentimentosModel({
    required this.id,
    required this.sentimento,
    required this.data,
  });

  sentimentosModel.fromMap(Map<String, dynamic> map):
    id = map["id"],
    sentimento = map["sentimento"],
    data = map["data"];

  Map<String, dynamic> toMap(){
    return{
      "id": id,
      "sentimento": sentimento,
      "data": data,
    };
  }
}
// To parse this JSON data, do
//
//     final WeightReponse = WeightReponseFromJson(jsonString);

import 'dart:convert';

WeightReponse parseFromJson(String str) =>
    WeightReponse.fromJson(json.decode(str));

String parseToJson(WeightReponse data) => json.encode(data.toJson());

class WeightReponse {
  WeightReponse({
    this.result,
    this.message,
  });

  List<Weight>? result;
  String? message;

  factory WeightReponse.fromJson(Map<String, dynamic> json) => WeightReponse(
        result:
            List<Weight>.from(json["result"].map((x) => Weight.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "message": message,
      };
}

class Weight {
  Weight({
    required this.id,
    required this.value,
    required this.date,
  });

  String id;
  String value;
  String date;

  factory Weight.fromJson(Map<String, dynamic> json) => Weight(
        id: json["id"],
        value: json["value"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "date": date,
      };
}

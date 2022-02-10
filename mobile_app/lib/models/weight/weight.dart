class Weight {
  Weight({
    required this.id,
    required this.date,
    required this.value,
  });

  String id;
  String date;
  String value;

  factory Weight.fromJson(Map<String, dynamic> json) => Weight(
        id: json["id"],
        date: json["date"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "value": value,
      };
}

import 'package:mobile_app/models/weight/weight.dart';

class GetWeightResponse {
  GetWeightResponse({
    required this.status,
    this.message,
    this.result,
  });

  int status;
  String? message;
  List<Weight>? result;

  factory GetWeightResponse.fromJson(Map<String, dynamic> json) =>
      GetWeightResponse(
        status: json["status"],
        message: json["message"],
        result:
            List<Weight>.from(json["result"].map((x) => Weight.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

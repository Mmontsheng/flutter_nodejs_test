import 'package:mobile_app/models/weight/weight.dart';

class BaseWeightResponse {
  BaseWeightResponse({
    this.message,
    required this.status,
    this.result,
  });

  String? message;
  int status;
  Weight? result;

  factory BaseWeightResponse.fromJson(Map<String, dynamic> json) =>
      BaseWeightResponse(
        message: json["message"],
        status: json["status"],
        result: Weight.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "result": result?.toJson(),
      };
}

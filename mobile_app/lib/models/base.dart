import 'dart:convert';

LoginModel parseFromJson(String str) => LoginModel.fromJson(json.decode(str));

String parseToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.result,
    this.message,
  });

  dynamic result;
  String? message;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        result: json["result"] ?? '',
        message: json["message"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
      };
}

class LoginResponse {
  LoginResponse({
    this.result,
    this.message,
    required this.status,
  });

  int status;
  String? result;
  String? message;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        message: json["message"] ?? '',
        result: json["result"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "status": status,
      };
}

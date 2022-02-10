class DeleteWeightResponse {
  DeleteWeightResponse({
    required this.message,
    required this.status,
  });

  String message;
  int status;

  factory DeleteWeightResponse.fromJson(Map<String, dynamic> json) =>
      DeleteWeightResponse(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}

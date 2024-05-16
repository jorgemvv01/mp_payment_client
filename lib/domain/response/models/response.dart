class CustomResponse {
  String status;
  String message;
  dynamic data;

  CustomResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CustomResponse.fromJson(Map<String, dynamic> json) => CustomResponse(
    status: json["Status"],
    message: json["Message"],
    data: json["Data"] ?? {}
  );
}
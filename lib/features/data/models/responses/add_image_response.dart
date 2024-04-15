class AddImageResponse {
  AddImageResponse({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory AddImageResponse.fromJson(Map<String, dynamic> json) =>
      AddImageResponse(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}

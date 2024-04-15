class UserImageChangeResponse {
  UserImageChangeResponse({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory UserImageChangeResponse.fromJson(Map<String, dynamic> json) =>
      UserImageChangeResponse(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}

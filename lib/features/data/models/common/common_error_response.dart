import 'dart:convert';

import '../../../domain/entities/common/error_response.dart';

class ErrorResponseModel extends ErrorResponse {
  ErrorResponseModel({
    required this.responseCode,
    required this.responseError,
  }) : super(responseCode: responseCode, responseError: responseError);

  String responseCode;
  String responseError;

  factory ErrorResponseModel.fromRawJson(String str) =>
      ErrorResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      ErrorResponseModel(
        responseCode: json["response_code"],
        responseError: json["response_error"],
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_error": responseError,
      };
}

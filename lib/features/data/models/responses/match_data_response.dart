// To parse this JSON data, do
//
//     final matchDataResponse = matchDataResponseFromJson(jsonString);

import 'dart:convert';

import 'package:veep_meep/features/data/models/responses/veep_data_response.dart';

MatchDataResponse? matchDataResponseFromJson(String str) => MatchDataResponse.fromJson(json.decode(str));

String matchDataResponseToJson(MatchDataResponse? data) => json.encode(data!.toJson());

class MatchDataResponse {
  MatchDataResponse({
    required this.success,
    required this.message,
    this.output,
  });

  bool success;
  String message;
  List<VeepData>? output;

  factory MatchDataResponse.fromJson(Map<String, dynamic> json) => MatchDataResponse(
    success: json["success"],
    message: json["message"],
    output: json["output"] == null ? [] : List<VeepData>.from(json["output"]!.map((x) => VeepData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "output": output == null ? [] : List<dynamic>.from(output!.map((x) => x!.toJson())),
  };
}



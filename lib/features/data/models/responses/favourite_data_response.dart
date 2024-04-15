// To parse this JSON data, do
//
//     final favouriteDataRequest = favouriteDataRequestFromJson(jsonString);

import 'dart:convert';

import 'package:veep_meep/features/data/models/responses/veep_data_response.dart';


FavouriteDataResponse? favouriteDataResponseFromJson(String str) => FavouriteDataResponse.fromJson(json.decode(str));

String favouriteDataResponseToJson(FavouriteDataResponse? data) => json.encode(data!.toJson());

class FavouriteDataResponse {
  FavouriteDataResponse({
    required this.success,
    required this.message,
    this.output,
  });

  bool success;
  String message;
  FavouriteData? output;

  factory FavouriteDataResponse.fromJson(Map<String, dynamic> json) => FavouriteDataResponse(
    success: json["success"],
    message: json["message"],
    output: FavouriteData.fromJson(json["output"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "output": output!.toJson(),
  };
}

class FavouriteData {
  FavouriteData({
    this.liked,
  });

  List<VeepData>? liked;

  factory FavouriteData.fromJson(Map<String, dynamic> json) => FavouriteData(
    liked: json["liked"] == null ? [] : List<VeepData>.from(json["liked"]!.map((x) => VeepData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "liked": liked == null ? [] : List<dynamic>.from(liked!.map((x) => x!.toJson())),
  };
}



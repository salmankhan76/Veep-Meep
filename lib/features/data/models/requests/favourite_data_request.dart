// To parse this JSON data, do
//
//     final favouriteDataResponse = favouriteDataResponseFromJson(jsonString);

import 'dart:convert';

FavouriteDataRequest? favouriteDataRequestFromJson(String str) => FavouriteDataRequest.fromJson(json.decode(str));

String favouriteDataRequestToJson(FavouriteDataRequest? data) => json.encode(data!.toJson());

class FavouriteDataRequest {
  FavouriteDataRequest({
   required this.userId,
  });

  int? userId;

  factory FavouriteDataRequest.fromJson(Map<String, dynamic> json) => FavouriteDataRequest(
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
  };
}

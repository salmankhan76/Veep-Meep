// To parse this JSON data, do
//
//     final personalDataRequest = personalDataRequestFromJson(jsonString);

import 'dart:convert';

PersonalDataRequest? personalDataRequestFromJson(String str) => PersonalDataRequest.fromJson(json.decode(str));

String personalDataRequestToJson(PersonalDataRequest? data) => json.encode(data!.toJson());

class PersonalDataRequest {
  PersonalDataRequest({
    this.name,
    this.dob,
    this.sexuality,
    this.veganScale,
    this.gender,
    this.userId,
  });

  String? name;
  String? dob;
  String? sexuality;
  String? veganScale;
  String? gender;
  int? userId;

  factory PersonalDataRequest.fromJson(Map<String, dynamic> json) => PersonalDataRequest(
    name: json["name"],
    dob: json["dob"],
    sexuality: json["sexuality"],
    veganScale: json["vegan_scale"],
    gender: json["gender"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "dob": dob,
    "sexuality": sexuality,
    "vegan_scale": veganScale,
    "gender": gender,
    "user_id": userId,
  };
}

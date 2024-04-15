// To parse this JSON data, do
//
//     final socialsDataSubmitRequest = socialsDataSubmitRequestFromJson(jsonString);

import 'dart:convert';

SocialsDataSubmitRequest socialsDataSubmitRequestFromJson(String str) => SocialsDataSubmitRequest.fromJson(json.decode(str));

String socialsDataSubmitRequestToJson(SocialsDataSubmitRequest data) => json.encode(data.toJson());

class SocialsDataSubmitRequest {
  SocialsDataSubmitRequest({
     this.web,
     this.facebook,
     this.instagram,
     this.linkedin,
     this.snapchat,
     this.twitter,
     this.userId,
  });

  String? web;
  String? facebook;
  String? instagram;
  String? linkedin;
  String? snapchat;
  String? twitter;
  int? userId;

  factory SocialsDataSubmitRequest.fromJson(Map<String, dynamic> json) => SocialsDataSubmitRequest(
    web: json["web"],
    facebook: json["facebook"],
    instagram: json["instagram"],
    linkedin: json["linkedin"],
    snapchat: json["snapchat"],
    twitter: json["twitter"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "web": web,
    "facebook": facebook,
    "instagram": instagram,
    "linkedin": linkedin,
    "snapchat": snapchat,
    "twitter": twitter,
    "user_id": userId,
  };
}

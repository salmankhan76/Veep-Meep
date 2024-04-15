// To parse this JSON data, do
//
//     final regularEditRequest = regularEditRequestFromJson(jsonString);

import 'dart:convert';

RegularEditRequest regularEditRequestFromJson(String str) => RegularEditRequest.fromJson(json.decode(str));

String regularEditRequestToJson(RegularEditRequest data) => json.encode(data.toJson());

class RegularEditRequest {
  int userId;
  String dob;
  String fullName;
  String designation;
  String bio;
  int gender;
  int veganScale;
  String fb;
  String instagram;
  String linkedin;
  String snapchat;
  String twitter;
  String web;
  String hobbies;
  String city;
  String province;
  String country;

  RegularEditRequest({
    required this.userId,
    required this.dob,
    required this.fullName,
    required this.designation,
    required this.bio,
    required this.gender,
    required this.veganScale,
    required this.fb,
    required this.instagram,
    required this.linkedin,
    required this.snapchat,
    required this.twitter,
    required this.web,
    required this.hobbies,
    required this.city,
    required this.province,
    required this.country,
  });

  factory RegularEditRequest.fromJson(Map<String, dynamic> json) => RegularEditRequest(
    userId: json["user_id"],
    dob: json["dob"],
    fullName: json["full_name"],
    designation: json["designation"],
    bio: json["bio"],
    gender: json["gender"],
    veganScale: json["vegan_scale"],
    fb: json["fb"],
    instagram: json["instagram"],
    linkedin: json["linkedin"],
    snapchat: json["snapchat"],
    twitter: json["twitter"],
    web: json["web"],
    hobbies: json["hobbies"],
    city: json["city"],
    province: json["province"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "dob": dob,
    "full_name": fullName,
    "designation": designation,
    "bio": bio,
    "gender": gender,
    "vegan_scale": veganScale,
    "fb": fb,
    "instagram": instagram,
    "linkedin": linkedin,
    "snapchat": snapchat,
    "twitter": twitter,
    "web": web,
    "hobbies": hobbies,
    "city": city,
    "province": province,
    "country": country,
  };
}

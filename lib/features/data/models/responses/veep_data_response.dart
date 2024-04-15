// To parse this JSON data, do
//
//     final veepDataResponse = veepDataResponseFromJson(jsonString);

import 'dart:convert';

VeepDataResponse? veepDataResponseFromJson(String str) => VeepDataResponse.fromJson(json.decode(str));

String veepDataResponseToJson(VeepDataResponse? data) => json.encode(data!.toJson());

class VeepDataResponse {
  VeepDataResponse({
   required this.success,
    required this.message,
    this.output,
  });

  bool success;
  String message;
  List<VeepData>? output;

  factory VeepDataResponse.fromJson(Map<String, dynamic> json) => VeepDataResponse(
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

class VeepData {
  VeepData({
    this.veepId,
    this.name,
    this.fullName,
    this.dob,
    this.serviceName,
    this.slogan,
    this.description,
    this.serviceType,
    this.pdf,
    this.age,
    this.distance,
    this.isPicked,
    this.veepStatus,
    this.designation,
    this.bio,
    this.gender,
    this.veganScale,
    this.fb,
    this.instagram,
    this.linkedin,
    this.snapchat,
    this.twitter,
    this.web,
    this.hobbies,
    this.images,
    this.province,
    this.city,
    this.profileImage = '',
    this.country,
    this.lastActivated,
    this.expireTime,
    required this.accountType,
    this.mobileNumber,
    this.neighborhood
  });

  int? veepId;
  String? name;
  String? fullName;
  DateTime? dob;
  String? serviceName;
  String? slogan;
  String? description;
  String? serviceType;
  String? pdf;
  int? age;
  int? distance;
  int? veepStatus;
  bool? isPicked;
  String? profileImage;
  String? designation;
  String? bio;
  String? gender;
  String? veganScale;
  String? fb;
  String? instagram;
  String? linkedin;
  String? snapchat;
  String? twitter;
  String? web;
  String? hobbies;
  String? city;
  String? province;
  String? country;
  String? mobileNumber;
  List<String>? images;
  DateTime? lastActivated;
  DateTime? expireTime;
  int accountType;
  String? neighborhood;

  factory VeepData.fromJson(Map<String, dynamic> json) => VeepData(
    veepId: json["veep_id"],
    name: json["name"],
    fullName: json["full_name"] ?? '',
    dob:json["dob"] != null ? DateTime.parse(json["dob"]) : DateTime.now(),
    accountType: json["account_type"]??1,
    slogan: json["slogan"],
    profileImage: json["profile_picture"]??'',
    description: json["service_description"],
    serviceName: json["service_name"],
    serviceType: json["service_type"]!=null?json["service_type"].toString():'0',
    pdf: json["offering_file"]??'',
    age: json["age"],
    neighborhood: json["neighborhood"],
    mobileNumber: json["mobile_number"],
    distance: json["distance"],
    veepStatus:json["veep_status"],
    isPicked: json["isPicked"],
    designation: json["designation"],
    bio: json["bio"],
    gender: json["gender"] != null ? json["gender"].toString() : '1',
    veganScale: json["vegan_scale"] != null ? json["vegan_scale"].toString() : '1',
    fb: json["fb"],
    web: json["web"] ?? 'a@gmail',
    instagram: json["instagram"],
    linkedin: json["linkedin"],
    snapchat: json["snapchat"],
    twitter: json["twitter"],
    hobbies: json["hobbies"],
    city: json["city"],
    country: json["country"],
    province: json["province"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    lastActivated: json["last_activated"]!=null?DateTime.parse(json["last_activated"]):null,
    expireTime: json["expire_time"]!=null?DateTime.parse(json["expire_time"]):null,
  );

  Map<String, dynamic> toJson() => {
    "veep_id": veepId,
    "name": name,
    "full_name": fullName,
    "dob": dob,
    "account_type": accountType,
    "service_name": serviceName,
    "slogan": slogan,
    "profile_picture": profileImage,
    "service_description": description,
    "service_type": serviceType,
    "offering_file": pdf,
    "mobile_number": mobileNumber,
    "age": age,
    "distance": distance,
    "isPicked": isPicked,
    "veep_status": veepStatus,
    "designation": designation,
    "bio": bio,
    "gender": gender,
    "vegan_scale": veganScale,
    "fb": fb,
    "web": web,
    "instagram": instagram,
    "linkedin": linkedin,
    "snapchat": snapchat,
    "twitter": twitter,
    "hobbies": hobbies,
    "city":city,
    "country":country,
    "province":province,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "last_activated": lastActivated?.toIso8601String(),
    "expire_time": expireTime?.toIso8601String(),
  };
}

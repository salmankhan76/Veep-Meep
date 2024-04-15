// To parse this JSON data, do
//
//     final aboutDataSubmitRequest = aboutDataSubmitRequestFromJson(jsonString);

import 'dart:convert';

AboutDataSubmitRequest aboutDataSubmitRequestFromJson(String str) => AboutDataSubmitRequest.fromJson(json.decode(str));

String aboutDataSubmitRequestToJson(AboutDataSubmitRequest data) => json.encode(data.toJson());

class AboutDataSubmitRequest {
  AboutDataSubmitRequest({
     this.job,
     this.hobbies,
     this.about,
     this.country,
     this.province,
     this.city,
     this.neighbourhood,
     this.userId,
  });

  String? job;
  String? hobbies;
  String? about;
  String? country;
  String? province;
  String? city;
  String? neighbourhood;
  int? userId;

  factory AboutDataSubmitRequest.fromJson(Map<String, dynamic> json) => AboutDataSubmitRequest(
    job: json["job"],
    hobbies: json["hobbies"],
    about: json["about"],
    country: json["country"],
    province: json["province"],
    city: json["city"],
    neighbourhood: json["neighbourhood"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "job": job,
    "hobbies": hobbies,
    "about": about,
    "country": country,
    "province": province,
    "city": city,
    "neighbourhood": neighbourhood,
    "user_id": userId,
  };
}


import 'dart:typed_data';

class BizEditRequest {
  int userId;
  String serviceName;
  String slogan;
  String serviceDescription;
  int serviceType;
  String country;
  String province;
  String city;
  String fb;
  String instagram;
  String linkedin;
  String snapchat;
  String twitter;
  String web;
  String? extension;
  String? neighborhood;
  Uint8List? file;

  BizEditRequest({
    required this.userId,
    required this.serviceName,
    required this.slogan,
    required this.serviceDescription,
    required this.serviceType,
    required this.country,
    required this.province,
    required this.neighborhood,
    required this.city,
    required this.fb,
    required this.instagram,
    required this.linkedin,
    required this.snapchat,
    required this.twitter,
    required this.web,
    required this.extension,
    required this.file
  });
}

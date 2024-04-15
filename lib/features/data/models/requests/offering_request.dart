
import 'dart:typed_data';

class OfferingRequest {
  int userId;
  String serviceName;
  String slogan;
  String serviceDescription;
  int serviceType;
  String country;
  String province;
  String city;
  String neighbourhood;
  String? extension;
  Uint8List? file;

  OfferingRequest({
    required this.userId,
    required this.serviceName,
    required this.slogan,
    required this.serviceDescription,
    required this.serviceType,
    required this.country,
    required this.province,
    required this.city,
    required this.neighbourhood,
    required this.extension,
    required this.file
  });
}

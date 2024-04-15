import 'dart:typed_data';

class ContactUsRequest {
  final int userId;
  final String name;
  final String surname;
  final String email;
  final String country;
  final String? state;
  final String? city;
  final Uint8List? file;
  final String? extension;
  final String info;

  ContactUsRequest(
      {required this.userId,
      required this.name,
      required this.surname,
      required this.email,
      required this.country,
      this.state,
      this.city,
      this.file,
      this.extension,
      required this.info});
}

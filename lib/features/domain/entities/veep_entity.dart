class VeepEntity {
  final int veepId;
  final String? name;
  final String? profileImage;
  final String? designation;
  final int? distance;
  final int? age;
  final String? bio;
  final String? gender;
  final String? fb;
  final String? instagram;
  final String? linkedin;
  final String? snapchat;
  final String? twitter;
  final List<String>? images;
  final String? hobbies;
  final DateTime? lastActive;
  final DateTime? timeExpire;
  final bool? isPicked;
  final int? veepStatus;
  final int accountType;
  final String? serviceName;
  final String? city;
  final String? country;
  final String? slogan;
  final String? web;

  VeepEntity({
    required this.veepId,
    this.profileImage,
    this.name,
    this.designation,
    this.distance,
    this.isPicked,
    this.veepStatus,
    this.age,
    this.bio,
    this.gender,
    this.lastActive,
    this.timeExpire,
    this.fb,
    this.instagram,
    this.linkedin,
    this.snapchat,
    this.twitter,
    this.images,
    this.hobbies,
    this.serviceName,
    required this.accountType,
    this.country,
    this.city,
    this.slogan,
    this.web,
  });
}

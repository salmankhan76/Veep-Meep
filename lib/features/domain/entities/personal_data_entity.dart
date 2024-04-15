class PersonalDataEntity {
  String? name;
  String? dob;
  int? age;
  int? genderId;
  int? sexualityId;
  int? veganScaleID;
  String? job;
  String? hobbies;
  String? about;
  String? location;
  String? country;
  String? province;
  String? city;
  String? web;
  String? fb;
  String? instagram;
  String? linkedIn;
  String? snapChat;
  String? twitter;
  List<String>? images;

  PersonalDataEntity(
      {this.name,
        this.dob,
        this.age,
        this.genderId,
        this.sexualityId,
        this.veganScaleID,
        this.job,
        this.hobbies,
        this.about,
        this.location,
        this.country = '',
        this.province = '',
        this.city = '',
        this.web,
        this.fb,
        this.instagram,
        this.linkedIn,
        this.snapChat,
        this.twitter,
        this.images});
}

import 'package:veep_meep/features/data/models/requests/about_data_request.dart';
import 'package:veep_meep/features/data/models/requests/add_uimage_request.dart';
import 'package:veep_meep/features/data/models/requests/biz_edit_request.dart';
import 'package:veep_meep/features/data/models/requests/email_verification_request.dart';
import 'package:veep_meep/features/data/models/requests/regular_edit_request.dart';
import 'package:veep_meep/features/data/models/requests/socials_data_request.dart';

import '../../../data/models/requests/change_mobile_request.dart';
import '../../../data/models/requests/logout_request.dart';
import '../../../data/models/requests/offering_request.dart';
import '../../../data/models/requests/personal_data_request.dart';
import '../../../data/models/requests/profile_select_request.dart';
import '../../../data/models/requests/signup_request.dart';
import '../../../data/models/requests/user_identify_request.dart';
import '../../../data/models/requests/user_image_change_request.dart';
import '../base_event.dart';

abstract class AuthEvent extends BaseEvent {}

class SessionRefreshEvent extends AuthEvent {}

class GetPushTokenEvent extends AuthEvent {}

class SplashEvent extends AuthEvent {}

class GetBasicDataEvent extends AuthEvent {}

class GetUserDataEvent extends AuthEvent {
  final bool shouldHideProgress;

  GetUserDataEvent({this.shouldHideProgress = false});
}

class GetPrivacyData extends AuthEvent {}

class UserImageChangeEvent extends AuthEvent {
  final UserImageChangeRequest userImageChangeRequest;

  UserImageChangeEvent({required this.userImageChangeRequest});
}

class AddImageEvent extends AuthEvent {
  final AddImageRequest addImageRequest;

  AddImageEvent({required this.addImageRequest});
}

class GetEmailVerificationEvent extends AuthEvent {
  final EmailVerificationRequest emailVerificationRequest;

  GetEmailVerificationEvent({required this.emailVerificationRequest});
}

class PersonalDataEvent extends AuthEvent {
  final PersonalDataRequest personalDataRequest;

  PersonalDataEvent({required this.personalDataRequest});
}

class AboutDataEvent extends AuthEvent {
  final AboutDataSubmitRequest aboutDataSubmitRequest;

  AboutDataEvent({required this.aboutDataSubmitRequest});
}

class SocialsDataEvent extends AuthEvent {
  final SocialsDataSubmitRequest socialsDataSubmitRequest;

  SocialsDataEvent({required this.socialsDataSubmitRequest});
}

class SignupEvent extends AuthEvent {
  final SignupRequest signupRequest;

  SignupEvent({required this.signupRequest});
}

class SubmitOfferingEvent extends AuthEvent {
  final OfferingRequest offeringRequest;

  SubmitOfferingEvent({required this.offeringRequest});
}

class RegularEditEvent extends AuthEvent {
  final RegularEditRequest regularEditRequest;
  final bool shouldPopScreen;

  RegularEditEvent(
      {required this.regularEditRequest, required this.shouldPopScreen});
}

class BizEditEvent extends AuthEvent {
  final BizEditRequest bizEditRequest;
  final bool shouldPopScreen;

  BizEditEvent({required this.bizEditRequest, required this.shouldPopScreen});
}

class IdentifyUserEvent extends AuthEvent {
  final UserIdentifyRequest userIdentifyRequest;

  IdentifyUserEvent({required this.userIdentifyRequest});
}

class GetVeepDataEvent extends AuthEvent {
  final int userId;
  final bool shouldPop;

  GetVeepDataEvent({required this.userId, required this.shouldPop});
}

class LogoutEvent extends AuthEvent {
  final LogoutRequest logoutRequest;

  LogoutEvent({required this.logoutRequest});
}

class ProfileSelectEvent extends AuthEvent {
  final ProfileSelectRequest profileSelectRequest;

  ProfileSelectEvent({required this.profileSelectRequest});
}

class ChangePhoneNumberEvent extends AuthEvent {
  final ChangeMobileRequest changeMobileRequest;

  ChangePhoneNumberEvent({required this.changeMobileRequest});
}

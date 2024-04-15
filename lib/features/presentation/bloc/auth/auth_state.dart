import '../../../data/models/responses/email_verification-response.dart';
import '../../../data/models/responses/signup_response.dart';
import '../../../data/models/responses/veep_data_response.dart';
import '../base_state.dart';

abstract class AuthState extends BaseState<AuthState> {}

class InitialAuthState extends AuthState {}

class PushTokenSuccessState extends AuthState {}

class PushTokenFailedState extends AuthState {}

class PushEmailVerificationSuccessState extends AuthState {
  final String message;
  final  VerificationData? output;

  PushEmailVerificationSuccessState({required this.message,required this.output});
}


class PushOtpDataSuccessState extends AuthState {
  final String message;

  PushOtpDataSuccessState({required this.message});
}

class OtpSubmitDataSuccessState extends AuthState {
  final String message;

  OtpSubmitDataSuccessState({required this.message});
}

class PersonalDataSuccessState extends AuthState {
  final String message;

  PersonalDataSuccessState({required this.message});
}

class AboutDataSuccessState extends AuthState {
  final String message;

  AboutDataSuccessState({required this.message});
}
class SocialsDataSuccessState extends AuthState {
  final String message;

  SocialsDataSuccessState({required this.message});
}

class UserImageChangeSuccessState extends AuthState {
  final String message;

  UserImageChangeSuccessState({required this.message});
}

class VeepDataSuccessState extends AuthState {
  final String message;
  final bool shouldPop;
  final List<VeepData> output;

  VeepDataSuccessState({required this.message, required this.output,required this.shouldPop});
}

class SignupSuccessState extends AuthState {
  final String message;
  final SignUpData? signUpData;
  final String email;
  SignupSuccessState({required this.message, this.signUpData, required this.email});
}

class AddImageSuccessState extends AuthState {
  final String message;

  AddImageSuccessState({required this.message});
}

class SubmitOfferingSuccessState extends AuthState {
  final String message;
  SubmitOfferingSuccessState({required this.message});
}

class RegularEditSuccessState extends AuthState {
  final bool shouldPopScreen;
  final String message;

  RegularEditSuccessState({required this.message,required this.shouldPopScreen});
}

class BizEditSuccessState extends AuthState {
  final String message;
  final bool shouldPopScreen;

  BizEditSuccessState({required this.message,required this.shouldPopScreen});
}

class IdentifyUserSuccessState extends AuthState {
  final String message;
  IdentifyUserSuccessState({required this.message});
}

class LogoutSuccessState extends AuthState {
  final String message;
  LogoutSuccessState({required this.message});
}

class ProfileSelectSuccessState extends AuthState {
  final String message;
  ProfileSelectSuccessState({required this.message});
}

class ChangePhoneNumberSuccessState extends AuthState {
  final String message;
  final String mobileNumber;
  ChangePhoneNumberSuccessState({required this.message, required this.mobileNumber});
}

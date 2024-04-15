import '../base_state.dart';

abstract class OtpState extends BaseState<OtpState> {}

class InitialOtpState extends OtpState {}

class PushOtpDataSuccessState extends OtpState {
  final String message;

  PushOtpDataSuccessState({required this.message});
}

class OtpSubmitDataSuccessState extends OtpState {
  final String message;

  OtpSubmitDataSuccessState({required this.message});
}

class OtpSubmitDataFailedState extends OtpState {
  final String message;

  OtpSubmitDataFailedState({required this.message});
}

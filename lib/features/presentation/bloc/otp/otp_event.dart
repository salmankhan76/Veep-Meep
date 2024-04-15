import '../../../data/models/requests/otp_generate_request.dart';
import '../../../data/models/requests/otp_submit_request.dart';
import '../base_event.dart';

abstract class OtpEvent extends BaseEvent {}

class GetOtpDataEvent extends OtpEvent {
  final OtpGenerateRequest otpGenerateRequest;

  GetOtpDataEvent({required this.otpGenerateRequest});
}

class SubmitOtpDataEvent extends OtpEvent {
  final OtpSubmitRequest otpSubmitRequest;

  SubmitOtpDataEvent({required this.otpSubmitRequest});
}

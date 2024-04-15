import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../error/messages.dart';
import '../../../data/datasources/shared_preference.dart';
import '../../../data/models/common/common_error_response.dart';
import '../../../domain/repositories/repository.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'otp_event.dart';
import 'otp_state.dart';

class OtpBloc extends Base<OtpEvent, BaseState<OtpState>> {
  final AppSharedData appSharedData;
  final Repository repository;

  OtpBloc({required this.appSharedData, required this.repository})
      : super(InitialOtpState()) {
    on<GetOtpDataEvent>(_generateOtpAPI);
    on<SubmitOtpDataEvent>(_otpSubmitAPI);
  }

  _generateOtpAPI(
      GetOtpDataEvent event, Emitter<BaseState<OtpState>> emit) async {
    emit(APILoadingState());
    final result = await repository.generateOtpAPI(event.otpGenerateRequest);
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return PushOtpDataSuccessState(message: r.message);
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: r.message, responseCode: ''));
        }
      }),
    );
  }

  _otpSubmitAPI(
      SubmitOtpDataEvent event, Emitter<BaseState<OtpState>> emit) async {
    emit(APILoadingState());
    final result = await repository.otpSubmitAPI(event.otpSubmitRequest);
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return OtpSubmitDataSuccessState(message: r.message);
        } else {
          return OtpSubmitDataFailedState(message: r.message);
        }
      }),
    );
  }
}

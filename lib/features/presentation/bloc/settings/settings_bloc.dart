import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veep_meep/features/presentation/bloc/settings/settings_event.dart';
import 'package:veep_meep/features/presentation/bloc/settings/settings_state.dart';

import '../../../../error/messages.dart';
import '../../../data/datasources/shared_preference.dart';
import '../../../data/models/common/common_error_response.dart';
import '../../../data/models/requests/email_setting_request.dart';
import '../../../data/models/requests/location_request.dart';
import '../../../domain/repositories/repository.dart';
import '../base_bloc.dart';
import '../base_state.dart';

class SettingsBloc extends Base<SettingsEvent, BaseState<SettingsState>> {
  final AppSharedData appSharedData;
  final Repository repository;

  SettingsBloc({required this.appSharedData, required this.repository})
      : super(InitialSettingsState()) {
    on<ChangeUserNameEvent>(_changeUserNameAPI);
    on<ChangeUserEmailEvent>(_changeUserEmailAPI);
    on<LocationEvent>(_locationAPI);
    on<EmailSettingEvent>(_emailSettingAPI);
    on<ContactUsEvent>(_contactUsAPI);
  }

  _changeUserNameAPI(
      ChangeUserNameEvent event, Emitter<BaseState<SettingsState>> emit) async {
    emit(APILoadingState());
    final result =
        await repository.changeUserNameAPI(event.changeUserNameRequest);
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return ChangeUserNameSuccessState(message: r.message);
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: r.message, responseCode: ''));
        }
      }),
    );
  }

  _changeUserEmailAPI(ChangeUserEmailEvent event,
      Emitter<BaseState<SettingsState>> emit) async {
    emit(APILoadingState());
    final result =
        await repository.changeUserEmailAPI(event.changeUserEmailRequest);
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return ChangeUserEmailSuccessState(message: r.message);
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: r.message, responseCode: ''));
        }
      }),
    );
  }

  _locationAPI(
      LocationEvent event, Emitter<BaseState<SettingsState>> emit) async {
    emit(APILoadingState());
    final result =
        await repository.locationAPI(LocationRequest(userId: event.userId));
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return LocationSuccessState(message: r.message, output: r.output!);
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: r.message, responseCode: ''));
        }
      }),
    );
  }

  _emailSettingAPI(
      EmailSettingEvent event, Emitter<BaseState<SettingsState>> emit) async {
    emit(APILoadingState());
    final result = await repository.emailSettingAPI(
      EmailSettingRequest(
          userId: event.userId,
          emailSettingId: event.emailSettingId,
          status: event.status),
    );
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return EmailSettingSuccessState(message: r.message);
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: r.message, responseCode: ''));
        }
      }),
    );
  }

  _contactUsAPI(
      ContactUsEvent event, Emitter<BaseState<SettingsState>> emit) async {
    emit(
      APILoadingState(
        shouldShowDialog: event.contactUsRequest.file != null,
      ),
    );
    final result = await repository.contactUsAPI(event.contactUsRequest);
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return ContactUsSuccessState(message: r.message);
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: r.message, responseCode: ''));
        }
      }),
    );
  }
}

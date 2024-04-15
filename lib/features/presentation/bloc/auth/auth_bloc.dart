import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veep_meep/utils/app_constants.dart';

import '../../../../core/service/cloud_services.dart';
import '../../../../error/messages.dart';
import '../../../data/datasources/shared_preference.dart';
import '../../../data/models/common/common_error_response.dart';
import '../../../data/models/requests/veep_data_request.dart';
import '../../../domain/repositories/repository.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Base<AuthEvent, BaseState<AuthState>> {
  final AppSharedData appSharedData;
  final Repository repository;
  final CloudServices cloudServices;

  AuthBloc(
      {required this.appSharedData,
      required this.repository,
      required this.cloudServices})
      : super(InitialAuthState()) {
    on<GetPushTokenEvent>((event, emit) async {
      final hasToken = appSharedData.hasPushToken();
      if (hasToken) {
        emit(PushTokenSuccessState());
      } else {
        //await cloudServices.capturePushToken();
        emit(PushTokenFailedState());
      }
    });
    on<GetEmailVerificationEvent>(_emailVerificationAPI);
    on<PersonalDataEvent>(_personalDataAPI);
    on<UserImageChangeEvent>(_userImageChangeAPI);
    on<SignupEvent>(_signupAPI);
    on<AddImageEvent>(_addImageAPI);
    on<AboutDataEvent>(_aboutDataAPI);
    on<SocialsDataEvent>(_socialsDataAPI);
    on<SubmitOfferingEvent>(_submitOfferingAPI);
    on<RegularEditEvent>(_regularEditAPI);
    on<BizEditEvent>(_editOfferingAPI);
    on<IdentifyUserEvent>(_identifyUserAPI);
    on<GetVeepDataEvent>(_veepAPI);
    on<LogoutEvent>(_logoutAPI);
    on<ProfileSelectEvent>(_profileSelectAPI);
    on<ChangePhoneNumberEvent>(_changePhoneNumberAPI);
  }

  _emailVerificationAPI(GetEmailVerificationEvent event,
      Emitter<BaseState<AuthState>> emit) async {
    emit(APILoadingState());
    final result =
        await repository.emailVerificationAPI(event.emailVerificationRequest);
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return PushEmailVerificationSuccessState(
              message: r.message!, output: r.output!);
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: r.message!, responseCode: ''));
        }
      }),
    );
  }

  _personalDataAPI(
      PersonalDataEvent event, Emitter<BaseState<AuthState>> emit) async {
    emit(APILoadingState());
    final result = await repository.personalDataAPI(event.personalDataRequest);
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return PersonalDataSuccessState(message: r.message);
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: r.message, responseCode: ''));
        }
      }),
    );
  }

  _aboutDataAPI(
      AboutDataEvent event, Emitter<BaseState<AuthState>> emit) async {
    emit(APILoadingState());
    final result = await repository.aboutDataAPI(event.aboutDataSubmitRequest);
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return AboutDataSuccessState(message: r.message);
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: r.message, responseCode: ''));
        }
      }),
    );
  }

  _socialsDataAPI(
      SocialsDataEvent event, Emitter<BaseState<AuthState>> emit) async {
    emit(APILoadingState());
    final result =
        await repository.socialsDataAPI(event.socialsDataSubmitRequest);
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return SocialsDataSuccessState(message: r.message);
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: r.message, responseCode: ''));
        }
      }),
    );
  }

  _userImageChangeAPI(
      UserImageChangeEvent event, Emitter<BaseState<AuthState>> emit) async {
    emit(APILoadingState());
    final result =
        await repository.userImageChangeAPI(event.userImageChangeRequest);
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return UserImageChangeSuccessState(message: r.message);
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: r.message, responseCode: ''));
        }
      }),
    );
  }

  _veepAPI(GetVeepDataEvent event, Emitter<BaseState<AuthState>> emit) async {
    emit(APILoadingState());

    final result =
        await repository.veepAPI(VeepDataRequest(userId: event.userId));
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return VeepDataSuccessState(
              message: r.message,
              output: r.output!,
              shouldPop: event.shouldPop);
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseCode: '', responseError: r.message));
        }
      }),
    );
  }

  _signupAPI(SignupEvent event, Emitter<BaseState<AuthState>> emit) async {
    emit(APILoadingState());
    final result = await repository.signupAPI(event.signupRequest);
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return SignupSuccessState(
            message: r.message,
            signUpData: r.output,
            email: event.signupRequest.emailAddress,
          );
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: r.message, responseCode: ''));
        }
      }),
    );
  }

  _addImageAPI(AddImageEvent event, Emitter<BaseState<AuthState>> emit) async {
    emit(APILoadingState());
    final result = await repository.addImageAPI(event.addImageRequest);
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return AddImageSuccessState(message: r.message);
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: r.message, responseCode: ''));
        }
      }),
    );
  }

  _submitOfferingAPI(
      SubmitOfferingEvent event, Emitter<BaseState<AuthState>> emit) async {
    emit(APILoadingState(shouldShowDialog: true));
    final result = await repository.offeringAPI(event.offeringRequest);
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return SubmitOfferingSuccessState(message: r.message);
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: r.message, responseCode: ''));
        }
      }),
    );
  }

  _editOfferingAPI(
      BizEditEvent event, Emitter<BaseState<AuthState>> emit) async {
    emit(APILoadingState(shouldShowDialog: true));
    final result = await repository.bizEditAPI(event.bizEditRequest);
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return BizEditSuccessState(
              message: r.message, shouldPopScreen: event.shouldPopScreen);
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: r.message, responseCode: ''));
        }
      }),
    );
  }

  _regularEditAPI(
      RegularEditEvent event, Emitter<BaseState<AuthState>> emit) async {
    emit(APILoadingState());
    final result = await repository.regularEditAPI(event.regularEditRequest);
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return RegularEditSuccessState(
              message: r.message, shouldPopScreen: event.shouldPopScreen);
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: r.message, responseCode: ''));
        }
      }),
    );
  }

  _identifyUserAPI(
      IdentifyUserEvent event, Emitter<BaseState<AuthState>> emit) async {
    final result = await repository.userIdentifyAPI(event.userIdentifyRequest);
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          AppConstants.kIsBizAccount = r.output.accountType == 2;
          return IdentifyUserSuccessState(message: r.message);
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: r.message, responseCode: ''));
        }
      }),
    );
  }

  _logoutAPI(LogoutEvent event, Emitter<BaseState<AuthState>> emit) async {
    emit(APILoadingState());
    final result = await repository.logoutAPI(event.logoutRequest);
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return LogoutSuccessState(message: r.message);
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: r.message, responseCode: ''));
        }
      }),
    );
  }

  _profileSelectAPI(
      ProfileSelectEvent event, Emitter<BaseState<AuthState>> emit) async {
    emit(APILoadingState());
    final result =
        await repository.profileSelectAPI(event.profileSelectRequest);
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return ProfileSelectSuccessState(message: r.message);
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: r.message, responseCode: ''));
        }
      }),
    );
  }

  _changePhoneNumberAPI(
      ChangePhoneNumberEvent event, Emitter<BaseState<AuthState>> emit) async {
    emit(APILoadingState());
    final result = await repository.changeMobileAPI(event.changeMobileRequest);
    emit(
      result.fold((l) {
        return APIFailureState(
            errorResponseModel: ErrorResponseModel(
                responseError: ErrorMessages().mapFailureToMessage(l),
                responseCode: ''));
      }, (r) {
        if (r.success) {
          return ChangePhoneNumberSuccessState(
            message: r.message,
            mobileNumber: event.changeMobileRequest.mobileNumber,
          );
        } else {
          return APIFailureState(
              errorResponseModel: ErrorResponseModel(
                  responseError: r.message, responseCode: ''));
        }
      }),
    );
  }
}

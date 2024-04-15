import 'package:dartz/dartz.dart';
import 'package:veep_meep/features/data/models/requests/about_data_request.dart';
import 'package:veep_meep/features/data/models/requests/add_uimage_request.dart';
import 'package:veep_meep/features/data/models/requests/biz_edit_request.dart';
import 'package:veep_meep/features/data/models/requests/change_user_email_request.dart';
import 'package:veep_meep/features/data/models/requests/change_user_name_request.dart';
import 'package:veep_meep/features/data/models/requests/email_setting_request.dart';
import 'package:veep_meep/features/data/models/requests/favourite_data_request.dart';
import 'package:veep_meep/features/data/models/requests/location_request.dart';
import 'package:veep_meep/features/data/models/requests/match_data_request.dart';
import 'package:veep_meep/features/data/models/requests/personal_data_request.dart';
import 'package:veep_meep/features/data/models/requests/regular_edit_request.dart';
import 'package:veep_meep/features/data/models/requests/send_message_request.dart';
import 'package:veep_meep/features/data/models/requests/socials_data_request.dart';
import 'package:veep_meep/features/data/models/requests/veep_data_request.dart';
import 'package:veep_meep/features/data/models/responses/about_data_response.dart';
import 'package:veep_meep/features/data/models/responses/add_image_response.dart';
import 'package:veep_meep/features/data/models/responses/biz_edit_response.dart';
import 'package:veep_meep/features/data/models/responses/change_user_email_response.dart';
import 'package:veep_meep/features/data/models/responses/change_user_name_response.dart';
import 'package:veep_meep/features/data/models/responses/email_setting_response.dart';
import 'package:veep_meep/features/data/models/responses/favourite_data_response.dart';
import 'package:veep_meep/features/data/models/responses/get_messages_response.dart';
import 'package:veep_meep/features/data/models/responses/location_response.dart';
import 'package:veep_meep/features/data/models/responses/match_data_response.dart';
import 'package:veep_meep/features/data/models/responses/personal_data_response.dart';
import 'package:veep_meep/features/data/models/responses/regular_edit_response.dart';
import 'package:veep_meep/features/data/models/responses/send_message_response.dart';
import 'package:veep_meep/features/data/models/responses/socials_data_response.dart';
import 'package:veep_meep/features/data/models/responses/veep_data_response.dart';
import 'package:veep_meep/features/data/models/responses/veeped_users_response.dart';

import '../../../core/network/network_info.dart';
import '../../../error/exceptions.dart';
import '../../../error/failures.dart';
import '../../../error/messages.dart';
import '../../domain/repositories/repository.dart';
import '../datasources/remote_data_source.dart';
import '../models/common/common_error_response.dart';
import '../models/requests/change_mobile_request.dart';
import '../models/requests/contact_us_request.dart';
import '../models/requests/email_verification_request.dart';
import '../models/requests/logout_request.dart';
import '../models/requests/offering_request.dart';
import '../models/requests/otp_generate_request.dart';
import '../models/requests/otp_submit_request.dart';
import '../models/requests/profile_select_request.dart';
import '../models/requests/signup_request.dart';
import '../models/requests/user_identify_request.dart';
import '../models/requests/user_image_change_request.dart';
import '../models/responses/change_mobile_response.dart';
import '../models/responses/contact_us_response.dart';
import '../models/responses/email_verification-response.dart';
import '../models/responses/generate_otp_response.dart';
import '../models/responses/logout_response.dart';
import '../models/responses/offering_response.dart';
import '../models/responses/otp_submit_response.dart';
import '../models/responses/profile_select_response.dart';
import '../models/responses/signup_response.dart';
import '../models/responses/user_identify_response.dart';
import '../models/responses/user_image_change_resposne.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, VeepDataResponse>> veepAPI(
      VeepDataRequest veepDataRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.veepAPI(veepDataRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, EmailVerificationResponse>> emailVerificationAPI(
      EmailVerificationRequest emailVerificationRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource
            .emailVerificationAPI(emailVerificationRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, GenerateOtpResponse>> generateOtpAPI(
      OtpGenerateRequest otpGenerateRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.generateOtpAPI(otpGenerateRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, OtpSubmitResponse>> otpSubmitAPI(
      OtpSubmitRequest otpSubmitRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.otpSubmitAPI(otpSubmitRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, PersonalDataResponse>> personalDataAPI(
      PersonalDataRequest personalDataRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.personalDataAPI(personalDataRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, MatchDataResponse>> matchAPI(
      MatchDataRequest matchDataRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.matchAPI(matchDataRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, FavouriteDataResponse>> favouriteAPI(
      FavouriteDataRequest favouriteDataRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.favouriteAPI(favouriteDataRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, UserImageChangeResponse>> userImageChangeAPI(
      UserImageChangeRequest userImageChangeRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.userImageChangeAPI(userImageChangeRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, ChangeUsernameResponse>> changeUserNameAPI(
      ChangeUserNameRequest changeUserNameRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.changeUserNameAPI(changeUserNameRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, ChangeUserEmailResponse>> changeUserEmailAPI(
      ChangeUserEmailRequest changeUserEmailRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.changeUserEmailAPI(changeUserEmailRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, LocationResponse>> locationAPI(
      LocationRequest locationRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.locationAPI(locationRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, EmailSettingResponse>> emailSettingAPI(
      EmailSettingRequest emailSettingRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.emailSettingAPI(emailSettingRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, SignupResponse>> signupAPI(
      SignupRequest signupRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.signupAPI(signupRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, AboutDataSubmitResponse>> aboutDataAPI(
      AboutDataSubmitRequest aboutDataSubmitRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.aboutDataAPI(aboutDataSubmitRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, SocialsDataSubmitResponse>> socialsDataAPI(
      SocialsDataSubmitRequest socialsDataSubmitRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.socialsDataAPI(socialsDataSubmitRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, AddImageResponse>> addImageAPI(
      AddImageRequest addImageRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.addImageAPI(addImageRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, OfferingResponse>> offeringAPI(
      OfferingRequest offeringRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.offeringAPI(offeringRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, RegularEditResponse>> regularEditAPI(
      RegularEditRequest regularEditRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.regularEditAPI(regularEditRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BizEditResponse>> bizEditAPI(
      BizEditRequest bizEditRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.bizEditAPI(bizEditRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, UserIdentifyResponse>> userIdentifyAPI(
      UserIdentifyRequest userIdentifyRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.userIdentifyAPI(userIdentifyRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, LogoutResponse>> logoutAPI(
      LogoutRequest logoutRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.logoutAPI(logoutRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, ProfileSelectResponse>> profileSelectAPI(
      ProfileSelectRequest profileSelectRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.profileSelectAPI(profileSelectRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, ChangeMobileResponse>> changeMobileAPI(
      ChangeMobileRequest changeMobileRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.changeMobileAPI(changeMobileRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, ContactUsResponse>> contactUsAPI(
      ContactUsRequest contactUsRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.contactUsAPI(contactUsRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, VeepedUserResponse>> getAllVeepedChatUserAPI() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getAllVeepedUserAPI();

        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, SendMsgResponse>> sendMessageAPI(
      SendMsgRequest sendMsgRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.sendMessageAPI(sendMsgRequest);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, GetMessagesResponse>> getAllMessagesAPI(
      int receiver_id) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getAllMessagesAPI(receiver_id);

        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on UnAuthorizedException catch (ex) {
        return Left(AuthorizedFailure(ex.errorResponseModel));
      } on DioException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on Exception {
        return Left(
          ServerFailure(
            ErrorResponseModel(
                responseError: ErrorMessages.ERROR_SOMETHING_WENT_WRONG,
                responseCode: ''),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}

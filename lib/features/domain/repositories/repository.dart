import 'package:dartz/dartz.dart';
import 'package:veep_meep/features/data/models/requests/about_data_request.dart';
import 'package:veep_meep/features/data/models/requests/add_uimage_request.dart';
import 'package:veep_meep/features/data/models/requests/biz_edit_request.dart';
import 'package:veep_meep/features/data/models/requests/favourite_data_request.dart';
import 'package:veep_meep/features/data/models/requests/match_data_request.dart';
import 'package:veep_meep/features/data/models/requests/regular_edit_request.dart';
import 'package:veep_meep/features/data/models/requests/send_message_request.dart';
import 'package:veep_meep/features/data/models/requests/socials_data_request.dart';
import 'package:veep_meep/features/data/models/requests/veep_data_request.dart';
import 'package:veep_meep/features/data/models/responses/about_data_response.dart';
import 'package:veep_meep/features/data/models/responses/add_image_response.dart';
import 'package:veep_meep/features/data/models/responses/biz_edit_response.dart';
import 'package:veep_meep/features/data/models/responses/favourite_data_response.dart';
import 'package:veep_meep/features/data/models/responses/get_messages_response.dart';
import 'package:veep_meep/features/data/models/responses/match_data_response.dart';
import 'package:veep_meep/features/data/models/responses/regular_edit_response.dart';
import 'package:veep_meep/features/data/models/responses/send_message_response.dart';
import 'package:veep_meep/features/data/models/responses/socials_data_response.dart';
import 'package:veep_meep/features/data/models/responses/veep_data_response.dart';

import '../../../error/failures.dart';
import '../../data/models/requests/change_mobile_request.dart';
import '../../data/models/requests/change_user_email_request.dart';
import '../../data/models/requests/change_user_name_request.dart';
import '../../data/models/requests/contact_us_request.dart';
import '../../data/models/requests/email_setting_request.dart';
import '../../data/models/requests/email_verification_request.dart';
import '../../data/models/requests/location_request.dart';
import '../../data/models/requests/logout_request.dart';
import '../../data/models/requests/offering_request.dart';
import '../../data/models/requests/otp_generate_request.dart';
import '../../data/models/requests/otp_submit_request.dart';
import '../../data/models/requests/personal_data_request.dart';
import '../../data/models/requests/profile_select_request.dart';
import '../../data/models/requests/signup_request.dart';
import '../../data/models/requests/user_identify_request.dart';
import '../../data/models/requests/user_image_change_request.dart';
import '../../data/models/responses/change_mobile_response.dart';
import '../../data/models/responses/change_user_email_response.dart';
import '../../data/models/responses/change_user_name_response.dart';
import '../../data/models/responses/contact_us_response.dart';
import '../../data/models/responses/email_setting_response.dart';
import '../../data/models/responses/email_verification-response.dart';
import '../../data/models/responses/generate_otp_response.dart';
import '../../data/models/responses/location_response.dart';
import '../../data/models/responses/logout_response.dart';
import '../../data/models/responses/offering_response.dart';
import '../../data/models/responses/otp_submit_response.dart';
import '../../data/models/responses/personal_data_response.dart';
import '../../data/models/responses/profile_select_response.dart';
import '../../data/models/responses/signup_response.dart';
import '../../data/models/responses/user_identify_response.dart';
import '../../data/models/responses/user_image_change_resposne.dart';
import '../../data/models/responses/veeped_users_response.dart';

abstract class Repository {
  Future<Either<Failure, VeepDataResponse>> veepAPI(
      VeepDataRequest veepDataRequest);

  Future<Either<Failure, EmailVerificationResponse>> emailVerificationAPI(
      EmailVerificationRequest emailVerificationRequest);

  Future<Either<Failure, GenerateOtpResponse>> generateOtpAPI(
      OtpGenerateRequest otpGenerateRequest);

  Future<Either<Failure, OtpSubmitResponse>> otpSubmitAPI(
      OtpSubmitRequest otpSubmitRequest);

  Future<Either<Failure, PersonalDataResponse>> personalDataAPI(
      PersonalDataRequest personalDataRequest);

  Future<Either<Failure, MatchDataResponse>> matchAPI(
      MatchDataRequest matchDataRequest);

  Future<Either<Failure, FavouriteDataResponse>> favouriteAPI(
      FavouriteDataRequest favouriteDataRequest);

  Future<Either<Failure, UserImageChangeResponse>> userImageChangeAPI(
      UserImageChangeRequest userImageChangeRequest);

  Future<Either<Failure, ChangeUsernameResponse>> changeUserNameAPI(
      ChangeUserNameRequest changeUserNameRequest);

  Future<Either<Failure, ChangeUserEmailResponse>> changeUserEmailAPI(
      ChangeUserEmailRequest changeUserEmailRequest);

  Future<Either<Failure, LocationResponse>> locationAPI(
      LocationRequest locationRequest);

  Future<Either<Failure, EmailSettingResponse>> emailSettingAPI(
      EmailSettingRequest emailSettingRequest);

  Future<Either<Failure, AboutDataSubmitResponse>> aboutDataAPI(
      AboutDataSubmitRequest aboutDataSubmitRequest);

  Future<Either<Failure, SocialsDataSubmitResponse>> socialsDataAPI(
      SocialsDataSubmitRequest socialsDataSubmitRequest);

  Future<Either<Failure, AddImageResponse>> addImageAPI(
      AddImageRequest addImageRequest);

  Future<Either<Failure, SignupResponse>> signupAPI(
      SignupRequest signupRequest);

  Future<Either<Failure, OfferingResponse>> offeringAPI(
      OfferingRequest offeringRequest);

  Future<Either<Failure, RegularEditResponse>> regularEditAPI(
      RegularEditRequest regularEditRequest);

  Future<Either<Failure, BizEditResponse>> bizEditAPI(
      BizEditRequest bizEditRequest);

  Future<Either<Failure, UserIdentifyResponse>> userIdentifyAPI(
      UserIdentifyRequest userIdentifyRequest);

  Future<Either<Failure, LogoutResponse>> logoutAPI(
      LogoutRequest logoutRequest);

  Future<Either<Failure, ProfileSelectResponse>> profileSelectAPI(
      ProfileSelectRequest profileSelectRequest);

  Future<Either<Failure, ChangeMobileResponse>> changeMobileAPI(
      ChangeMobileRequest changeMobileRequest);

  Future<Either<Failure, ContactUsResponse>> contactUsAPI(
      ContactUsRequest contactUsRequest);

  Future<Either<Failure, VeepedUserResponse>> getAllVeepedChatUserAPI();

  Future<Either<Failure, SendMsgResponse>> sendMessageAPI(
      SendMsgRequest sendMsgRequest);

  Future<Either<Failure, GetMessagesResponse>> getAllMessagesAPI(
      int receiver_id);
}

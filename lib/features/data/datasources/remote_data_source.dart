import 'dart:core';

import 'package:dio/dio.dart';
import 'package:veep_meep/features/data/models/requests/about_data_request.dart';
import 'package:veep_meep/features/data/models/requests/add_uimage_request.dart';
import 'package:veep_meep/features/data/models/requests/biz_edit_request.dart';
import 'package:veep_meep/features/data/models/requests/favourite_data_request.dart';
import 'package:veep_meep/features/data/models/requests/match_data_request.dart';
import 'package:veep_meep/features/data/models/requests/regular_edit_request.dart';
import 'package:veep_meep/features/data/models/requests/socials_data_request.dart';
import 'package:veep_meep/features/data/models/responses/about_data_response.dart';
import 'package:veep_meep/features/data/models/responses/add_image_response.dart';
import 'package:veep_meep/features/data/models/responses/biz_edit_response.dart';
import 'package:veep_meep/features/data/models/responses/favourite_data_response.dart';
import 'package:veep_meep/features/data/models/responses/get_messages_response.dart';
import 'package:veep_meep/features/data/models/responses/match_data_response.dart';
import 'package:veep_meep/features/data/models/responses/regular_edit_response.dart';
import 'package:veep_meep/features/data/models/responses/socials_data_response.dart';
import 'package:veep_meep/utils/enums.dart';

import '../../../core/network/api_helper.dart';
import '../../../core/network/mock_api_helper.dart';
import '../models/requests/change_mobile_request.dart';
import '../models/requests/change_user_email_request.dart';
import '../models/requests/change_user_name_request.dart';
import '../models/requests/contact_us_request.dart';
import '../models/requests/email_setting_request.dart';
import '../models/requests/email_verification_request.dart';
import '../models/requests/location_request.dart';
import '../models/requests/logout_request.dart';
import '../models/requests/offering_request.dart';
import '../models/requests/otp_generate_request.dart';
import '../models/requests/otp_submit_request.dart';
import '../models/requests/personal_data_request.dart';
import '../models/requests/profile_select_request.dart';
import '../models/requests/signup_request.dart';
import '../models/requests/user_identify_request.dart';
import '../models/requests/user_image_change_request.dart';
import '../models/requests/veep_data_request.dart';
import '../models/requests/send_message_request.dart';
import '../models/responses/change_mobile_response.dart';
import '../models/responses/change_user_email_response.dart';
import '../models/responses/change_user_name_response.dart';
import '../models/responses/contact_us_response.dart';
import '../models/responses/email_setting_response.dart';
import '../models/responses/email_verification-response.dart';
import '../models/responses/generate_otp_response.dart';
import '../models/responses/location_response.dart';
import '../models/responses/logout_response.dart';
import '../models/responses/offering_response.dart';
import '../models/responses/otp_submit_response.dart';
import '../models/responses/personal_data_response.dart';
import '../models/responses/profile_select_response.dart';
import '../models/responses/signup_response.dart';
import '../models/responses/user_identify_response.dart';
import '../models/responses/user_image_change_resposne.dart';
import '../models/responses/veep_data_response.dart';
import '../models/responses/veeped_users_response.dart';
import '../models/responses/send_message_response.dart';

abstract class RemoteDataSource {
  Future<VeepDataResponse> veepAPI(VeepDataRequest loginRequest);

  Future<EmailVerificationResponse> emailVerificationAPI(
      EmailVerificationRequest emailVerificationRequest);

  Future<GenerateOtpResponse> generateOtpAPI(
      OtpGenerateRequest otpGenerateRequest);

  Future<OtpSubmitResponse> otpSubmitAPI(OtpSubmitRequest otpSubmitRequest);

  Future<PersonalDataResponse> personalDataAPI(
      PersonalDataRequest personalDataRequest);

  Future<AboutDataSubmitResponse> aboutDataAPI(
      AboutDataSubmitRequest aboutDataSubmitRequest);

  Future<SocialsDataSubmitResponse> socialsDataAPI(
      SocialsDataSubmitRequest socialsDataSubmitRequest);

  Future<ChangeUsernameResponse> changeUserNameAPI(
      ChangeUserNameRequest changeUserNameRequest);

  Future<ChangeUserEmailResponse> changeUserEmailAPI(
      ChangeUserEmailRequest changeUserEmailRequest);

  Future<LocationResponse> locationAPI(LocationRequest locationRequest);

  Future<EmailSettingResponse> emailSettingAPI(
      EmailSettingRequest emailSettingRequest);

  Future<MatchDataResponse> matchAPI(MatchDataRequest matchDataRequest);

  Future<FavouriteDataResponse> favouriteAPI(
      FavouriteDataRequest favouriteDataRequest);

  Future<UserImageChangeResponse> userImageChangeAPI(
      UserImageChangeRequest userImageChangeRequest);

  Future<SignupResponse> signupAPI(SignupRequest signupRequest);

  Future<AddImageResponse> addImageAPI(AddImageRequest addImageRequest);

  Future<OfferingResponse> offeringAPI(OfferingRequest offeringRequest);

  Future<RegularEditResponse> regularEditAPI(
      RegularEditRequest regularEditRequest);

  Future<BizEditResponse> bizEditAPI(BizEditRequest bizEditRequest);

  Future<UserIdentifyResponse> userIdentifyAPI(
      UserIdentifyRequest userIdentifyRequest);

  Future<LogoutResponse> logoutAPI(LogoutRequest logoutRequest);

  Future<ProfileSelectResponse> profileSelectAPI(
      ProfileSelectRequest profileSelectRequest);

  Future<ChangeMobileResponse> changeMobileAPI(
      ChangeMobileRequest changeMobileRequest);

  Future<ContactUsResponse> contactUsAPI(ContactUsRequest contactUsRequest);

  Future<VeepedUserResponse> getAllVeepedUserAPI();

  Future<SendMsgResponse> sendMessageAPI(SendMsgRequest sendMsgRequest);

  Future<GetMessagesResponse> getAllMessagesAPI(int receiver_id);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final APIHelper apiHelper;
  final MockAPIHelper mockAPIHelper;

  RemoteDataSourceImpl({required this.apiHelper, required this.mockAPIHelper});

  @override
  Future<VeepDataResponse> veepAPI(VeepDataRequest veepDataRequest) async {
    try {
      final response = await apiHelper.post("veep", body: veepDataRequest);
      return VeepDataResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<EmailVerificationResponse> emailVerificationAPI(
      EmailVerificationRequest emailVerificationRequest) async {
    try {
      final response = await apiHelper.post("user/signin",
          body: emailVerificationRequest.toJson());
      return EmailVerificationResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<GenerateOtpResponse> generateOtpAPI(
      OtpGenerateRequest otpGenerateRequest) async {
    try {
      final response = await apiHelper.post(
          otpGenerateRequest.otpUseCase == OTPUseCase.SIGNUP
              ? 'otp/generate'
              : otpGenerateRequest.otpUseCase == OTPUseCase.EMAIL_EDIT
                  ? 'otp/send'
                  : "otp/user/manage",
          body: otpGenerateRequest.toJson());
      return GenerateOtpResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<OtpSubmitResponse> otpSubmitAPI(
      OtpSubmitRequest otpSubmitRequest) async {
    try {
      final response =
          await apiHelper.post("otp/validate", body: otpSubmitRequest.toJson());
      return OtpSubmitResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<PersonalDataResponse> personalDataAPI(
      PersonalDataRequest personalDataRequest) async {
    try {
      final response = await apiHelper.post("personal/submit",
          body: personalDataRequest.toJson());
      return PersonalDataResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<ChangeUsernameResponse> changeUserNameAPI(
      ChangeUserNameRequest changeUserNameRequest) async {
    try {
      final response = await apiHelper.post("change/username",
          body: changeUserNameRequest.toJson());
      return ChangeUsernameResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<ChangeUserEmailResponse> changeUserEmailAPI(
      ChangeUserEmailRequest changeUserEmailRequest) async {
    try {
      final response = await apiHelper.post("change/useremail",
          body: changeUserEmailRequest.toJson());
      return ChangeUserEmailResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<LocationResponse> locationAPI(LocationRequest locationRequest) async {
    try {
      final response = await mockAPIHelper.post("location/data");
      return LocationResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<EmailSettingResponse> emailSettingAPI(
      EmailSettingRequest emailSettingRequest) async {
    try {
      final response = await mockAPIHelper.post("setting/unsubscribe");
      return EmailSettingResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<MatchDataResponse> matchAPI(MatchDataRequest matchDataRequest) async {
    try {
      final response = await mockAPIHelper.post("match");
      return MatchDataResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<FavouriteDataResponse> favouriteAPI(
      FavouriteDataRequest favouriteDataRequest) async {
    try {
      final response = await mockAPIHelper.post("favourite");
      return FavouriteDataResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<UserImageChangeResponse> userImageChangeAPI(
      UserImageChangeRequest userImageChangeRequest) async {
    try {
      var formData = FormData.fromMap({
        'user_id': userImageChangeRequest.userId,
        'file_extension': userImageChangeRequest.extension,
        'updated_by': userImageChangeRequest.updateBy,
      });

      final MultipartFile file = MultipartFile.fromBytes(
          userImageChangeRequest.profile!,
          filename: "profile_picture");
      MapEntry<String, MultipartFile> imageEntry =
          MapEntry("profile_picture", file);
      formData.files.add(imageEntry);

      final response = await apiHelper.post("user/image", body: formData);
      return UserImageChangeResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<SignupResponse> signupAPI(SignupRequest signupRequest) async {
    try {
      final response =
          await apiHelper.post("user/signup", body: signupRequest.toJson());
      return SignupResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<AboutDataSubmitResponse> aboutDataAPI(
      AboutDataSubmitRequest aboutDataSubmitRequest) async {
    try {
      final response = await apiHelper.post("about/submit",
          body: aboutDataSubmitRequest.toJson());
      return AboutDataSubmitResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<SocialsDataSubmitResponse> socialsDataAPI(
      SocialsDataSubmitRequest socialsDataSubmitRequest) async {
    try {
      final response = await apiHelper.post("socials/submit",
          body: socialsDataSubmitRequest.toJson());
      return SocialsDataSubmitResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<AddImageResponse> addImageAPI(AddImageRequest addImageRequest) async {
    try {
      var formData = FormData.fromMap({
        'user_id': addImageRequest.userId,
      });

      for (var item in addImageRequest.data) {
        if (item.gridImage != null && item.extension != null) {
          final MultipartFile file = MultipartFile.fromBytes(item.gridImage!,
              filename: "profile_picture_${item.orderId + 1}");
          MapEntry<String, MultipartFile> imageEntry =
              MapEntry("profile_picture_${item.orderId + 1}", file);
          formData.fields.add(
              MapEntry('file_extension_${item.orderId + 1}', item.extension!));
          formData.files.add(imageEntry);
        }
      }

      final response = await apiHelper.post("image/submit", body: formData);
      return AddImageResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<OfferingResponse> offeringAPI(OfferingRequest offeringRequest) async {
    try {
      var formData = FormData.fromMap({
        'user_id': offeringRequest.userId,
        'service_name': offeringRequest.serviceName,
        'slogan': offeringRequest.slogan,
        'service_description': offeringRequest.serviceDescription,
        'service_type': offeringRequest.serviceType,
        'country': offeringRequest.country,
        'province': offeringRequest.province,
        'city': offeringRequest.city,
        'neighbourhood': offeringRequest.neighbourhood,
        'extension': offeringRequest.extension,
      });

      if (offeringRequest.file != null) {
        final MultipartFile file = MultipartFile.fromBytes(
            offeringRequest.file!,
            filename: "offering_file");
        MapEntry<String, MultipartFile> imageEntry =
            MapEntry("offering_file", file);
        formData.files.add(imageEntry);
      }

      final response = await apiHelper.post("offering/submit", body: formData);
      return OfferingResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<RegularEditResponse> regularEditAPI(
      RegularEditRequest regularEditRequest) async {
    try {
      final response = await apiHelper.post("profile/edit/veep",
          body: regularEditRequest.toJson());
      return RegularEditResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BizEditResponse> bizEditAPI(BizEditRequest bizEditRequest) async {
    try {
      var formData = FormData.fromMap({
        'user_id': bizEditRequest.userId,
        'service_name': bizEditRequest.serviceName,
        'slogan': bizEditRequest.slogan,
        'service_description': bizEditRequest.serviceDescription,
        'service_type': bizEditRequest.serviceType,
        'country': bizEditRequest.country,
        'neighborhood': bizEditRequest.neighborhood,
        'province': bizEditRequest.province,
        'city': bizEditRequest.city,
        'extension': bizEditRequest.extension,
        'web': bizEditRequest.web,
        'fb': bizEditRequest.fb,
        'instagram': bizEditRequest.instagram,
        'linkedin': bizEditRequest.linkedin,
        'snapchat': bizEditRequest.snapchat,
        'twitter': bizEditRequest.twitter,
      });

      if (bizEditRequest.file != null) {
        final MultipartFile file = MultipartFile.fromBytes(bizEditRequest.file!,
            filename: "offering_file");
        MapEntry<String, MultipartFile> imageEntry =
            MapEntry("offering_file", file);
        formData.files.add(imageEntry);
      }

      final response = await apiHelper.post("offering/edit", body: formData);
      return BizEditResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<UserIdentifyResponse> userIdentifyAPI(
      UserIdentifyRequest userIdentifyRequest) async {
    try {
      final response = await apiHelper.post("user/identify",
          body: userIdentifyRequest.toJson());
      return UserIdentifyResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<LogoutResponse> logoutAPI(LogoutRequest logoutRequest) async {
    try {
      final response =
          await apiHelper.post("logout", body: logoutRequest.toJson());
      return LogoutResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<ProfileSelectResponse> profileSelectAPI(
      ProfileSelectRequest profileSelectRequest) async {
    try {
      final response = await apiHelper.post("profile/select",
          body: profileSelectRequest.toJson());
      return ProfileSelectResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<ChangeMobileResponse> changeMobileAPI(
      ChangeMobileRequest changeMobileRequest) async {
    try {
      final response = await apiHelper.post("change/mobilenumber",
          body: changeMobileRequest.toJson());
      return ChangeMobileResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<ContactUsResponse> contactUsAPI(
      ContactUsRequest contactUsRequest) async {
    try {
      var formData = FormData.fromMap({
        'user_id': contactUsRequest.userId,
        'province': contactUsRequest.state,
        'city': contactUsRequest.city,
        'extension': contactUsRequest.extension,
        'country': contactUsRequest.country,
        'name': contactUsRequest.name,
        'surname': contactUsRequest.surname,
        'email_address': contactUsRequest.email,
        'description': contactUsRequest.info,
      });

      if (contactUsRequest.file != null) {
        final MultipartFile file = MultipartFile.fromBytes(
            contactUsRequest.file!,
            filename: "attachment");
        MapEntry<String, MultipartFile> imageEntry =
            MapEntry("attachment", file);
        formData.files.add(imageEntry);
      }

      final response = await apiHelper.post("contact", body: formData);
      return ContactUsResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<VeepedUserResponse> getAllVeepedUserAPI() async {
    try {
      final response = await apiHelper.get("chat/get-veeps");
      return VeepedUserResponse.fromJson(response.data);
    } catch (e) {
      print('An error occurred: $e');
      rethrow;
    }
  }

  @override
  Future<SendMsgResponse> sendMessageAPI(SendMsgRequest sendMsgRequest) async {
    try {
      final response = await apiHelper.post("chat/send-message",
          body: sendMsgRequest.toJson());
      return SendMsgResponse.fromJson(response.data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<GetMessagesResponse> getAllMessagesAPI(int receiver_id) async {
    try {
      final response = await apiHelper
          .get("chat/get-messages?receiver_id=" + receiver_id.toString());
      return GetMessagesResponse.fromJson(response.data);
    } catch (e) {
      print('An error occurred: $e');
      rethrow;
    }
  }
}

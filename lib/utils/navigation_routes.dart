import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:veep_meep/features/domain/entities/personal_data_entity.dart';
import 'package:veep_meep/features/domain/entities/veep_entity.dart';
import 'package:veep_meep/features/presentation/views/chat/all_chat_view.dart';
import 'package:veep_meep/features/presentation/views/chat/camera_preview_view.dart';
import 'package:veep_meep/features/presentation/views/chat/chat_gallery_video_view.dart';
import 'package:veep_meep/features/presentation/views/home/favorite_view.dart';
import 'package:veep_meep/features/presentation/views/profile/profile_outer_view.dart';
import 'package:veep_meep/features/presentation/views/settings/contact_us.dart';
import 'package:veep_meep/features/presentation/views/settings/username.dart';
import 'package:veep_meep/features/presentation/views/sign%20in/verify_otp_view.dart';
import 'package:veep_meep/features/presentation/views/veeper%20view/discover_view.dart';

import '../features/presentation/views/error/connection_lost_view.dart';
import '../features/presentation/views/error/error_view.dart';
import '../features/presentation/views/error/terms_conditions_view.dart';
import '../features/presentation/views/home/home_view.dart';
import '../features/presentation/views/intro/intro_view.dart';
import '../features/presentation/views/login/email_verification_view.dart';
import '../features/presentation/views/login/email_view.dart';
import '../features/presentation/views/login/login_view.dart';
import '../features/presentation/views/login/welcome_view.dart';
import '../features/presentation/views/offering/edit_offering.dart';
import '../features/presentation/views/offering/offering_view.dart';
import '../features/presentation/views/profile/my_photos.dart';
import '../features/presentation/views/profile/my_photos_picker.dart';
import '../features/presentation/views/profile/pdf_view.dart';
import '../features/presentation/views/profile/profile_edit_view.dart';
import '../features/presentation/views/profile/profile_inner_view.dart';
import '../features/presentation/views/settings/filters_view.dart';
import '../features/presentation/views/settings/location.dart';
import '../features/presentation/views/settings/restore_view.dart';
import '../features/presentation/views/settings/settings.dart';
import '../features/presentation/views/settings/settings_email_view.dart';
import '../features/presentation/views/sign in/about_view.dart';
import '../features/presentation/views/sign in/add_photos_view.dart';
import '../features/presentation/views/sign in/personal_data_sub_view.dart';
import '../features/presentation/views/sign in/websites_view.dart';
import '../features/presentation/views/splash/splash_view.dart';
import '../features/presentation/views/unlock_options/biz_options_view.dart';
import '../features/presentation/views/unlock_options/customer_option_view.dart';
import '../features/presentation/views/unlock_options/user_options_view.dart';
import '../features/presentation/views/veeper view/discover_profile_view.dart';
import '../features/presentation/views/chat/chat_camera_view.dart';
import '../features/presentation/views/chat/chat_gallery_image_view.dart';

class Routes {
  static const String kSplashView = "kSplashView";
  static const String kIntroView = "kIntroView";
  static const String kPersonalDataSubmitView = "kPersonalDataSubmitView";
  static const String kAboutView = "kAboutView";
  static const String kWebsitesView = "kWebsitesView";
  static const String kAddPhotosView = "kAddPhotosView";
  static const String kVerifyOtpView = "kVerifyOtpView";
  static const String kUserOptionsView = "kUserOptionsView";
  static const String kCustomerOptionsView = "kCustomerOptionsView";
  static const String kHomeView = "kHomeView";
  static const String kLoginView = "kLoginView";
  static const String kEmailView = "kEmailView";
  static const String kWelcomeView = "kWelcomeView";
  static const String kEmailVerificationView = "kEmailVerificationView";
  static const String kUsername = "kUsername";
  static const String kLocationView = "kLocationView";
  static const String kRestoreView = "kRestoreView";
  static const String kSettingsView = "kSettingsView";
  static const String kSettingsEmailView = "kSettingsEmailView";
  static const String kBizOptionsView = "kBizOptionsView";
  static const String kDiscoverView = "kDiscoverView";
  static const String kDiscoverProfileView = "kDiscoverProfileView";
  static const String kMatchView = "kMatchView";
  static const String kFavoriteView = "kFavoriteView";
  static const String kProfileEditView = "kProfileEditView";
  static const String kProfileInnerView = "kProfileInnerView";
  static const String kMyPhotosView = "kMyPhotosView";
  static const String kAllChatView = "kAllChatView";
  static const String kChatCameraView = "kChatCameraView";
  static const String kChatCameraPreView = "kChatCameraPreView";
  static const String kChatGalleryImageView = "kChatGalleryImageView";
  static const String kChatGalleryVideoView = "kChatGalleryVideoView";
  static const String kOfferingView = "kOfferingView";
  static const String kEditOffering = "kEditOffering";
  static const String kProfileOuterView = "kProfileOuterView";
  static const String kErrorView = "kErrorView";
  static const String kConnectionLostView = "kConnectionLostView";
  static const String kTermsAndConditionsView = "kTermsAndConditionsView";
  static const String kFiltersView = "kFiltersView";
  static const String kPDFView = "kPDFView";
  static const String kMyPhotosPickerView = "kMyPhotosPickerView";
  static const String kContactUsView = "kContactUsView";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.kSplashView:
        return PageTransition(
            child: SplashView(), type: PageTransitionType.fade);
      case Routes.kIntroView:
        return PageTransition(
            child: IntroView(), type: PageTransitionType.fade);

      case Routes.kPersonalDataSubmitView:
        return PageTransition(
            child: PersonalDataSubmitView(), type: PageTransitionType.fade);
      case Routes.kAboutView:
        return PageTransition(
            child: AboutView(), type: PageTransitionType.fade);
      case Routes.kAddPhotosView:
        return PageTransition(
            child: AddPhotosView(), type: PageTransitionType.fade);
      case Routes.kVerifyOtpView:
        return PageTransition(
            child: VerifyOtpView(
              args: settings.arguments as OtpArgs,
            ),
            type: PageTransitionType.fade);
      case Routes.kHomeView:
        return PageTransition(child: HomeView(), type: PageTransitionType.fade);
      case Routes.kUserOptionsView:
        return PageTransition(
            child: UserOptionsView(), type: PageTransitionType.fade);
      case Routes.kCustomerOptionsView:
        return PageTransition(
            child: CustomerOptionsView(), type: PageTransitionType.fade);
      case Routes.kLoginView:
        return PageTransition(
            child: LoginView(), type: PageTransitionType.fade);
      case Routes.kEmailView:
        return PageTransition(
            child: EmailView(args: settings.arguments as EmailViewArgs),
            type: PageTransitionType.fade);
      case Routes.kWelcomeView:
        return PageTransition(
            child: WelcomeView(), type: PageTransitionType.fade);
      case Routes.kEmailVerificationView:
        return PageTransition(
            child: EmailVerificationView(), type: PageTransitionType.fade);
      case Routes.kWebsitesView:
        return PageTransition(
            child: WebsitesView(
              personalDataEntity: settings.arguments as PersonalDataEntity,
            ),
            type: PageTransitionType.fade);

      case Routes.kUsername:
        return PageTransition(
            child: UsernameView(
              userName: settings.arguments as String,
            ),
            type: PageTransitionType.fade);
      case Routes.kLocationView:
        return PageTransition(
            child: LocationView(), type: PageTransitionType.fade);
      case Routes.kRestoreView:
        return PageTransition(
            child: RestoreView(), type: PageTransitionType.fade);
      case Routes.kSettingsView:
        return PageTransition(
            child: SettingsView(), type: PageTransitionType.fade);
      case Routes.kSettingsEmailView:
        return PageTransition(
            child: SettingsEmailView(
              userEmail: settings.arguments as String,
            ),
            type: PageTransitionType.fade);
      case Routes.kProfileEditView:
        return PageTransition(
            child: ProfileEditView(), type: PageTransitionType.fade);
      case Routes.kProfileInnerView:
        return PageTransition(
            child: ProfileInnerView(), type: PageTransitionType.fade);
      case Routes.kProfileOuterView:
        return PageTransition(
            child: ProfileOuterView(), type: PageTransitionType.fade);
      case Routes.kBizOptionsView:
        return PageTransition(
            child: BizOptionsView(), type: PageTransitionType.fade);
      case Routes.kDiscoverView:
        return PageTransition(
            child: DiscoverView(), type: PageTransitionType.fade);
      case Routes.kDiscoverProfileView:
        return PageTransition(
            child: DiscoverProfileView(
              veepEntity: settings.arguments as VeepEntity,
            ),
            type: PageTransitionType.fade);
      case Routes.kFavoriteView:
        return PageTransition(
            child: FavoriteView(), type: PageTransitionType.fade);
      case Routes.kMyPhotosView:
        return PageTransition(
            child: MyPhotosView(), type: PageTransitionType.fade);
      case Routes.kOfferingView:
        return PageTransition(
            child: OfferingView(
              personalDataEntity: settings.arguments as PersonalDataEntity,
            ),
            type: PageTransitionType.fade);

      case Routes.kEditOffering:
        return PageTransition(
            child: EditOffering(), type: PageTransitionType.fade);

      case Routes.kAllChatView:
        return PageTransition(
            child: AllChatView(), type: PageTransitionType.fade);
      case Routes.kChatCameraView:
        return PageTransition(
            child: ChatCameraView(), type: PageTransitionType.fade);
      case Routes.kChatCameraPreView:
        return PageTransition(
            child: CameraPreviewWidget(), type: PageTransitionType.fade);
      case Routes.kChatGalleryImageView:
        return PageTransition(
            child: const ChatGalleryImageView(), type: PageTransitionType.fade);
      case Routes.kChatGalleryVideoView:
        return PageTransition(
            child: const ChatGalleryVideosView(),
            type: PageTransitionType.fade);
      /* case Routes.kMatchView:
          return PageTransition(
           child: MatchView(), type: PageTransitionType.fade);*/

      case Routes.kErrorView:
        return PageTransition(
            child: ErrorView(), type: PageTransitionType.fade);
      case Routes.kConnectionLostView:
        return PageTransition(
            child: ConnectionLostView(), type: PageTransitionType.fade);
      case Routes.kTermsAndConditionsView:
        return PageTransition(
            child: TermsAndConditionsView(), type: PageTransitionType.fade);

      case Routes.kFiltersView:
        return PageTransition(
            child: FiltersView(), type: PageTransitionType.fade);
      case Routes.kPDFView:
        return PageTransition(
            child: PDFView(
              args: settings.arguments as PDFViewArgs,
            ),
            type: PageTransitionType.fade);
      case Routes.kMyPhotosPickerView:
        return PageTransition(
            child: MyPhotosPickerView(), type: PageTransitionType.fade);
      case Routes.kContactUsView:
        return PageTransition(
            child: ContactUsView(), type: PageTransitionType.fade);

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("Invalid Route"),
            ),
          ),
        );
    }
  }
}

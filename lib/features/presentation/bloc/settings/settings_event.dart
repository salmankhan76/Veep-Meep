import '../../../data/models/requests/change_user_email_request.dart';
import '../../../data/models/requests/change_user_name_request.dart';
import '../../../data/models/requests/contact_us_request.dart';
import '../base_event.dart';

abstract class SettingsEvent extends BaseEvent {}

class ChangeUserNameEvent extends SettingsEvent {
  final ChangeUserNameRequest changeUserNameRequest;

  ChangeUserNameEvent({required this.changeUserNameRequest});
}

class ChangeUserEmailEvent extends SettingsEvent {
  final ChangeUserEmailRequest changeUserEmailRequest;

  ChangeUserEmailEvent({required this.changeUserEmailRequest});
}

class LocationEvent extends SettingsEvent {
  final int userId;

  LocationEvent({required this.userId});
}

class EmailSettingEvent extends SettingsEvent {
  final int userId;
  final int emailSettingId;
  final int status;

  EmailSettingEvent(
      {required this.userId,
      required this.emailSettingId,
      required this.status});
}


class ContactUsEvent extends SettingsEvent {
  final ContactUsRequest contactUsRequest;
  ContactUsEvent({required this.contactUsRequest});
}
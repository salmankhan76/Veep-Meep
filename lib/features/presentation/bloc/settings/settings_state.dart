import '../../../data/models/responses/location_response.dart';
import '../base_state.dart';

abstract class SettingsState extends BaseState<SettingsState> {}

class InitialSettingsState extends SettingsState {}

class ChangeUserNameSuccessState extends SettingsState {
  final String message;

  ChangeUserNameSuccessState({required this.message});
}

class ChangeUserEmailSuccessState extends SettingsState {
  final String message;

  ChangeUserEmailSuccessState({required this.message});
}

class LocationSuccessState extends SettingsState {
  final String message;
  final List<LocationData> output;

  LocationSuccessState({required this.output, required this.message});
}

class EmailSettingSuccessState extends SettingsState {
  final String message;

  EmailSettingSuccessState({required this.message});
}

class ContactUsSuccessState extends SettingsState {
  final String message;
  ContactUsSuccessState({required this.message});
}

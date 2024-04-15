import 'package:shared_preferences/shared_preferences.dart';

const String _APP_TOKEN = 'app_token';
const String _PUSH_TOKEN = 'push_token';
const String _USER_ID = 'user_id';
const String _EMAIL_ADDRESS = 'email_address';
const String _LOGIN_AVAILABLE = 'login_available';

class AppSharedData {
  late SharedPreferences secureStorage;

  AppSharedData(SharedPreferences preferences) {
    secureStorage = preferences;
  }

  ///APP TOKEN
  bool hasAppToken() {
    return secureStorage.containsKey(_APP_TOKEN);
  }

  setAppToken(String token) {
    secureStorage.setString(_APP_TOKEN, token);
  }

  String? getAppToken() {
    if (secureStorage.containsKey(_APP_TOKEN)) {
      return secureStorage.getString(_APP_TOKEN);
    } else {
      return "";
    }
  }

  clearAppToken(){
    secureStorage.remove(_APP_TOKEN);
  }

  ///APP TOKEN
  bool hasLoginAvailable() {
    return secureStorage.containsKey(_LOGIN_AVAILABLE);
  }

  setLoginAvailable(bool isAvailable) {
    secureStorage.setBool(_LOGIN_AVAILABLE, isAvailable);
  }

  bool? getLoginAvailable() {
    if (secureStorage.containsKey(_LOGIN_AVAILABLE)) {
      return secureStorage.getBool(_LOGIN_AVAILABLE);
    } else {
      return false;
    }
  }

  clearLogin(){
    secureStorage.remove(_LOGIN_AVAILABLE);
  }

  ///Email Address
  bool hasEmailAddress() {
    return secureStorage.containsKey(_EMAIL_ADDRESS);
  }

  setEmailAddress(String email) {
    secureStorage.setString(_EMAIL_ADDRESS, email);
  }

  String? getEmailAddress() {
    if (secureStorage.containsKey(_EMAIL_ADDRESS)) {
      return secureStorage.getString(_EMAIL_ADDRESS);
    } else {
      return "";
    }
  }

  clearEmail(){
    secureStorage.remove(_EMAIL_ADDRESS);
  }

  ///USERID
  bool hasUserId() {
    return secureStorage.containsKey(_USER_ID);
  }

  setUserId(int userId) {
    secureStorage.setInt(_USER_ID, userId);
  }

  int? getUserId() {
    if (secureStorage.containsKey(_USER_ID)) {
      return secureStorage.getInt(_USER_ID);
    } else {
      return 0;
    }
  }

  clearUserId(){
    secureStorage.remove(_USER_ID);
  }

  ///PUSH TOKEN
  setPushToken(String token) {
    secureStorage.setString(_PUSH_TOKEN, token);
  }

  bool hasPushToken() {
    return secureStorage.containsKey(_PUSH_TOKEN);
  }

  String? getPushToken() {
    if (secureStorage.containsKey(_PUSH_TOKEN)) {
      return secureStorage.getString(_PUSH_TOKEN);
    } else {
      return "token";
    }
  }
}

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  //* to store auth status
  static Future<void> setAuthStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(dotenv.get('AUTH_TOKEN'), status);
  }

  //* to store user phone number
  static Future<void> setPhoneNumber(String PhoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(dotenv.get('NUMBER_TOKEN'), PhoneNumber);
  }

  //* to store profile complete status
  static Future<void> setProfileStatus(bool status) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(dotenv.get('PROFILE_TOKEN'), true);
  }

  //* get profile complete status
  static Future<bool> getProfileStatus() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(dotenv.get('PROFILE_TOKEN')) ?? false;
  }

  //* get user phone number
  static Future<String> getPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(dotenv.get('NUMBER_TOKEN')) ?? "";
  }

  //* get auth status
  static Future<bool> getAuthStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(dotenv.get('AUTH_TOKEN')) ?? false;
  }
}

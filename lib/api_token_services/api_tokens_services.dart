import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppIdVersion {
  static String androidId = '';

  static String iosId = '';

  static String version = 'v 1.0.0';
}

class Api {
  static String mainUrl = '';

  static String apiUrl = '$mainUrl/api/v1/';

  static String mediaUrl = '$mainUrl/storage';
}

class TokensManagement {
  static String authToken = '';

  static Map<String, String> headers = {};

  static String phoneToken = '';

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static Future<void> setAuthToken({required String authToken}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('authToken', authToken);
    headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $authToken',
    };
  }

  static Future<void> getAuthToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final storedToken = sharedPreferences.getString('authToken');
    authToken = storedToken ?? '';
    headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $authToken',
    };
  }

  /// Call this function on logout
  static Future<void> clearSharedPreference() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  static Future<void> getPhoneToken() =>
      _firebaseMessaging.getToken().then((token) => phoneToken = token ?? '');
}

class KeyboardRule {
  static List<TextInputFormatter> numberInputRule = [
    FilteringTextInputFormatter.deny('.'),
    FilteringTextInputFormatter.deny(','),
    FilteringTextInputFormatter.deny('-'),
    FilteringTextInputFormatter.deny(' '),
  ];
}

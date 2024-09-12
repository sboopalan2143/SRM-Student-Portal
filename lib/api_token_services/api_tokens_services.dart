import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppIdVersion {
  static String androidId = '';

  static String iosId = '';

  static String version = 'v 1.0.0';
}

class Api {
  static String mainUrl =
      'https://mobileapp.erpsrm.com/srmstudentportal/StudentAndroid?wsdl/evarsitywebservice/StudentAndroid';

  static String apiUrl = '$mainUrl/api/v1/';

  static String mediaUrl = '$mainUrl/storage';
}

class TokensManagement {
  static String studentId = '';
  static String studentName = '';
  static String semesterId = '';
  static String officeId = '';

  static String deviceId = '';
  static String androidVersion = '';
  static String model = '';
  static String sdkVersion = '';
  static String appVersion = '';

  static Map<String, String> headers = {};

  static String phoneToken = '';

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static Future<void> setLoginDetails({
    required String studentId,
    required String studentName,
    required String semesterId,
    required String officeId,
  }) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('studentId', studentId);
    await sharedPreferences.setString('studentName', studentName);
    await sharedPreferences.setString('semesterId', semesterId);
    await sharedPreferences.setString('officeId', officeId);
  }

  static Future<void> setAppDeviceInfo({
    required String deviceId,
    required String androidVersion,
    required String model,
    required String sdkVersion,
    required String appVersion,
  }) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('deviceId', deviceId);
    await sharedPreferences.setString('androidversion', androidVersion);
    await sharedPreferences.setString('model', model);
    await sharedPreferences.setString('sdkVersion', sdkVersion);
    await sharedPreferences.setString('appversion', appVersion);
  }

  static Future<void> getAppDeviceInfo() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final storedDeviceId = sharedPreferences.getString('deviceId');
    final storedAndroidVersion = sharedPreferences.getString('androidversion');
    final storedModel = sharedPreferences.getString('model');
    final storeSdkVersion = sharedPreferences.getString('sdkVersion');
    final storedAppVersion = sharedPreferences.getString('appversion');
    deviceId = storedDeviceId ?? '';
    androidVersion = storedAndroidVersion ?? '';
    model = storedModel ?? '';
    sdkVersion = storeSdkVersion ?? '';
    appVersion = storedAppVersion ?? '';
  }

  static Future<void> getStudentId() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final storedId = sharedPreferences.getString('studentId');
    final storedName = sharedPreferences.getString('studentName');
    final storedSemId = sharedPreferences.getString('semesterId');
    final storedoffId = sharedPreferences.getString('officeId');
    studentId = storedId ?? '';
    studentName = storedName ?? '';
    semesterId = storedSemId ?? '';
    officeId = storedoffId ?? '';
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

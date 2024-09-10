import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/login/model/login_response_model.dart';
import 'package:sample/login/riverpod/login_state.dart';

class LoginProvider extends StateNotifier<LoginState> {
  LoginProvider() : super(LoginInitial());

  void disposeState() => state = LoginInitial();

  // void _setLoading() => state = LoginStateLoading(
  //       successMessage: '',
  //       errorMessage: '',
  //       userName: TextEditingController(),
  //       password: TextEditingController(),
  //       studentData: LoginData.empty,
  //     );

  Future<void> getAppVersion() async {
    final deviceInfo = DeviceInfoPlugin();
    final packageInfo = await PackageInfo.fromPlatform();
    //  final  flutterVersion = await FlutterVersion.instance;

    final version = packageInfo.version;
    log('version>>>$version');
    final buildNumber = packageInfo.buildNumber;
    log('buildnumber>>>$buildNumber');
    // final flutterSdkVersion = flutterVersion.frameworkVersion;
    var deviceId = '';
    var androidVersion = '';
    var model = '';
    var androidSdkVersion = '';

    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id; // Unique ID on Android
      androidVersion = androidInfo.version.release;
      model = androidInfo.model;
      androidSdkVersion = androidInfo.version.sdkInt.toString();
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iosInfo = await deviceInfo.iosInfo;

      deviceId = iosInfo.identifierForVendor!; // Unique ID on iOS
      androidVersion = iosInfo.systemVersion;
      model = iosInfo.utsname.machine;
    }

    await TokensManagement.setAppDeviceInfo(
      deviceId: deviceId,
      androidVersion: androidVersion,
      model: model,
      sdkVersion: androidSdkVersion,
      appVersion: version,
    );
  }

  Future<void> login(EncryptionProvider encrypt) async {
    log('enters here');
    final data = encrypt.getEncryptedData(
      '<username>${state.userName.text}</username><password>${state.password.text}</password><deviceid>21f8</deviceid><accesstoken>fP</accesstoken>',
    );
    log('gets here');
    final response = await HttpService.sendSoapRequest('getStudentLogin', data);
    log('response >>>>> $response');
    if (response.$1 == 0) {
      state = NoNetworkAvailable(
        successMessage: '',
        errorMessage: '',
        userName: TextEditingController(),
        password: TextEditingController(),
        studentData: LoginData.empty,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final loginRes =
          details['getStudentLoginResponse'] as Map<String, dynamic>;
      final returnData = loginRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      var studentData = LoginData.empty;
      try {
        final studentLoginDetails =
            LoginResponseModel.fromJson(decryptedData.mapData!);
        studentData = studentLoginDetails.data![0];
        state = state.copyWith(studentData: studentData);
        log('SudentData >>>>> ${studentData.courseid}');

        if (studentLoginDetails.status == 'Success') {
          await TokensManagement.setLoginDetails(
            studentId: '${studentData.sid}',
            studentName: '${studentData.studentname}',
            semesterId: '${studentData.semesterid}',
          );
          await getAppVersion();
          state = LoginStateSuccessful(
            successMessage: studentLoginDetails.status!,
            errorMessage: '',
            userName: TextEditingController(),
            password: TextEditingController(),
            studentData: state.studentData,
          );
        } else if (studentLoginDetails.status != 'Success') {
          state = LoginStateError(
            successMessage: '',
            errorMessage: 'Error',
            userName: state.userName,
            password: state.password,
            studentData: LoginData.empty,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = LoginStateError(
          successMessage: '',
          errorMessage: error.message!,
          userName: state.userName,
          password: state.password,
          studentData: LoginData.empty,
        );
      }
    } else if (response.$1 != 200) {
      state = LoginStateError(
        successMessage: '',
        errorMessage: 'Error',
        userName: state.userName,
        password: state.password,
        studentData: LoginData.empty,
      );
    }
  }
}

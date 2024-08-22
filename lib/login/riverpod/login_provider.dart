import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/login/model/login_response_model.dart';
import 'package:sample/login/riverpod/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginProvider extends StateNotifier<LoginState> {
  LoginProvider() : super(LoginInitial());

  void disposeState() => state = LoginInitial();

  void _setLoading() => state = LoginStateLoading(
        successMessage: '',
        errorMessage: '',
        userName: TextEditingController(),
        password: TextEditingController(),
      );

  Future<void> login(EncryptionProvider encrypt) async {
    log('username>>>${state.userName.text}');
    log('password>>>${state.password.text}');
    log('<username>${state.userName.text}</username><password>${state.password.text}</password><deviceid>21f8</deviceid><accesstoken>fP</accesstoken>');
    final data = encrypt.getEncryptedData(
      '<username>${state.userName.text}</username><password>${state.password.text}</password><deviceid>21f8</deviceid><accesstoken>fP</accesstoken>',
    );
    log('encrypted data>>>>>$data');
    final response = await HttpService.sendSoapRequest('getStudentLogin', data);

    log('$response');
    if (response.$1 == 0) {
      state = NoNetworkAvailable(
        successMessage: '',
        errorMessage: '',
        userName: TextEditingController(),
        password: TextEditingController(),
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final loginRes =
          details['getStudentLoginResponse'] as Map<String, dynamic>;
      final returnData = loginRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      var studentData = <LoginData>[];
      final studentLoginDetails = LoginResponseModel.fromJson(decryptedData);
      studentData.addAll(studentLoginDetails.data!);
      if (studentLoginDetails.status == 'success') {
        state = LoginStateSuccessful(
          successMessage: studentLoginDetails.status!,
          errorMessage: '',
          userName: TextEditingController(),
          password: TextEditingController(),
        );
      }

      disposeState();
    } else if (response.$1 != 200) {
      state = LoginStateError(
        successMessage: '',
        errorMessage: 'Error',
        userName: TextEditingController(),
        password: TextEditingController(),
      );
    }
  }
}

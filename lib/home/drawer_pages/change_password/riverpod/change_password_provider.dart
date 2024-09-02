import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/home/drawer_pages/change_password/riverpod/change_password_state.dart';

class ChangePasswordProvider extends StateNotifier<ChangePasswordState> {
  ChangePasswordProvider() : super(ChangePasswordInitial());

  void disposeState() => state = ChangePasswordInitial();

  // void _setLoading() => state = ChangePasswordStateLoading(
  //       message: '',
  //       currentPassword: TextEditingController(),
  //       newPassword: TextEditingController(),
  //       confirmPassword: TextEditingController(),
  //     );

  Future<void> changePassword(EncryptionProvider encrypt) async {
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><oldpassword>${state.currentPassword.text}</oldpassword><newpassword>${state.currentPassword.text}</newpassword><confirmpassword>${state.currentPassword.text}</confirmpassword>',
    );
    final response =
        await HttpService.sendSoapRequest('ChangeUserPassword', data);

    if (response.$1 == 0) {
      state = NoNetworkAvailableChangePassword(
        message: '',
        currentPassword: TextEditingController(),
        newPassword: TextEditingController(),
        confirmPassword: TextEditingController(),
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final changePasswordRes =
          details['ChangeUserPasswordResponse'] as Map<String, dynamic>;
      final returnData = changePasswordRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      log('${decryptedData.stringData}');
      state = ChangePasswordStateSuccessful(
        message: '${decryptedData.stringData}',
        currentPassword: TextEditingController(),
        newPassword: TextEditingController(),
        confirmPassword: TextEditingController(),
      );
    } else if (response.$1 != 200) {
      state = ChangePasswordStateError(
        message: 'Error',
        currentPassword: TextEditingController(),
        newPassword: TextEditingController(),
        confirmPassword: TextEditingController(),
      );
    }
  }
}

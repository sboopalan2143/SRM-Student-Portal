import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/home/drawer_pages/change_password/riverpod/change_password_state.dart';

class ChangePasswordProvider extends StateNotifier<ChangePasswordState> {
  ChangePasswordProvider() : super(ChangePasswordInitial());

  void disposeState() => state = ChangePasswordInitial();

  void _setLoading() => state = ChangePasswordStateLoading(
        successMessage: '',
        errorMessage: '',
        currentPassword: TextEditingController(),
        newPassword: TextEditingController(),
        confirmPassword: TextEditingController(),
      );

  Future<void> changePassword(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>21f84947bd6aa060</deviceid><accesstoken>TR</accesstoken><androidversion>TR</androidversion><model>TR</model><sdkversion>TR</sdkversion><appversion>TR</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('ChangeUserPassword', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableChangePassword(
        successMessage: '',
        errorMessage: '',
        currentPassword: TextEditingController(),
        newPassword: TextEditingController(),
        confirmPassword: TextEditingController(),
      );
    } else if (response.$1 == 200) {
      state = ChangePasswordStateSuccessful(
        successMessage: '',
        errorMessage: '',
        currentPassword: TextEditingController(),
        newPassword: TextEditingController(),
        confirmPassword: TextEditingController(),
      );
    } else if (response.$1 != 200) {
      state = ChangePasswordStateError(
        successMessage: '',
        errorMessage: 'Error',
        currentPassword: TextEditingController(),
        newPassword: TextEditingController(),
        confirmPassword: TextEditingController(),
      );
    }
  }
}

import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_state.dart';
import 'package:sample/login/model/login_response_model.dart';

class ProfileProvider extends StateNotifier<ProfileState> {
  ProfileProvider() : super(ProfileInitial());

  void disposeState() => state = ProfileInitial();

  void _setLoading() => state = const ProfileStateLoading(
        successMessage: '',
        errorMessage: '',
      );

  Future<void> getProfileDetails(EncryptionProvider encrypt) async {
    final data = encrypt.getEncryptedData(
      '<studentid>1828</studentid><deviceid>21f84947bd6aa060</deviceid><accesstoken>TR</accesstoken><androidversion>TR</androidversion><model>TR</model><sdkversion>TR</sdkversion><appversion>TR</appversion>',
    );
    log('encrypted data>>>>>$data');
    final response =
        await HttpService.sendSoapRequest('getPersonalDetails', data);

    log('$response');
    if (response.$1 == 0) {
      state = const NoNetworkAvailableProfile(
        successMessage: '',
        errorMessage: '',
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
        state = ProfileStateSuccessful(
          successMessage: studentLoginDetails.status!,
          errorMessage: '',
        );
      }

      disposeState();
    } else if (response.$1 != 200) {
      state = const ProfileStateError(
        successMessage: '',
        errorMessage: 'Error',
      );
    }
  }
}

import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_state.dart';
import 'package:sample/login/model/login_response_model.dart';

class ProfileProvider extends StateNotifier<ProfileState> {
  ProfileProvider() : super(ProfileInitial());

  void disposeState() => state = ProfileInitial();

  void _setLoading() => state = const ProfileStateLoading(
        successMessage: '',
        errorMessage: '',
      );

  Future<void> getProfileDetails(WidgetRef ref) async {
    final providerRead = ref.read(encryptionProvider.notifier);
    TokensManagement.getStudentId();
    log('studentid profile${TokensManagement.studentId}');
    final data = providerRead.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>21f84947bd6aa060</deviceid><accesstoken>TR</accesstoken><androidversion>TR</androidversion><model>TR</model><sdkversion>TR</sdkversion><appversion>TR</appversion>',
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
      final decryptedData = providerRead.getDecryptedData('$data');
      var studentData = <LoginData>[];

      disposeState();
    } else if (response.$1 != 200) {
      state = const ProfileStateError(
        successMessage: '',
        errorMessage: 'Error',
      );
    }
  }
}

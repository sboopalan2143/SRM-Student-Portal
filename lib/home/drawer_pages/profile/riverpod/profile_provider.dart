// import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/drawer_pages/profile/model/profile_response_model.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_state.dart';

class ProfileProvider extends StateNotifier<ProfileDetailsState> {
  ProfileProvider() : super(ProfileInitial());

  void disposeState() => state = ProfileInitial();

  void _setLoading() => state = ProfileDetailsStateLoading(
        successMessage: '',
        errorMessage: '',
        profileData: ProfileDetails.empty,
      );

  Uint8List hexToBytes(String text) {
    final data = Uint8List(0);
    try {
      final length = text.length;
      final data = Uint8List(length ~/ 2);

      for (var i = 0; i < length; i += 2) {
        final high = int.parse(text[i], radix: 16) << 4;
        final low = int.parse(text[i + 1], radix: 16);
        data[i ~/ 2] = (high + low).toUnsigned(8);
      }
    } catch (e) {
      log('$e');
    }
    return data;
  }

  Future<void> getProfileDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>21f84947bd6aa060</deviceid><accesstoken>TR</accesstoken><androidversion>TR</androidversion><model>TR</model><sdkversion>TR</sdkversion><appversion>TR</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getPersonalDetails', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableProfile(
        successMessage: '',
        errorMessage: '',
        profileData: ProfileDetails.empty,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final loginRes =
          details['getPersonalDetailsResponse'] as Map<String, dynamic>;
      final returnData = loginRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      var profileDetails = ProfileDetails.empty;
      try {
        final profileDataResponse =
            ProfileResponseModel.fromJson(decryptedData.mapData!);
        profileDetails = profileDataResponse.data![0];
        state = state.copyWith(profileData: profileDetails);

        if (profileDataResponse.status == 'Success') {
          state = ProfileDetailsStateSuccessful(
            successMessage: profileDataResponse.status!,
            errorMessage: '',
            profileData: state.profileData,
          );
        } else if (profileDataResponse.status != 'Success') {
          state = ProfileDetailsStateError(
            successMessage: '',
            errorMessage: profileDataResponse.status!,
            profileData: ProfileDetails.empty,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = ProfileDetailsStateError(
          successMessage: '',
          errorMessage: error.message!,
          profileData: ProfileDetails.empty,
        );
      }
    } else if (response.$1 != 200) {
      state = ProfileDetailsStateError(
        successMessage: '',
        errorMessage: 'Error',
        profileData: ProfileDetails.empty,
      );
    }
  }
}

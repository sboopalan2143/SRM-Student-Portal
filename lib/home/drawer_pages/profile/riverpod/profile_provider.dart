// import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/drawer_pages/profile/model/profile_hive_model.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_state.dart';

class ProfileProvider extends StateNotifier<ProfileDetailsState> {
  ProfileProvider() : super(ProfileInitial());

  void disposeState() => state = ProfileInitial();

  void _setLoading() => state = ProfileDetailsStateLoading(
        successMessage: '',
        errorMessage: '',
        profileDataHive: ProfileHiveData.empty,
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

  Future<void> getProfileApi(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getPersonalDetails', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableProfile(
        successMessage: '',
        errorMessage: 'No Network. Connect to Internet',
        profileDataHive: ProfileHiveData.empty,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final loginRes =
          details['getPersonalDetailsResponse'] as Map<String, dynamic>;
      final returnData = loginRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      final listData = decryptedData.mapData!['Data'] as List<dynamic>;
      log('PROFILE listData length>>>${listData.length}');
      if (listData.isNotEmpty) {
        final box = await Hive.openBox<ProfileHiveData>('profile');
        if (box.isEmpty) {
          for (var i = 0; i < listData.length; i++) {
            final parseData =
                ProfileHiveData.fromJson(listData[i] as Map<String, dynamic>);
            await box.add(parseData);
          }
        } else {
          await box.clear();
          for (var i = 0; i < listData.length; i++) {
            final parseData =
                ProfileHiveData.fromJson(listData[i] as Map<String, dynamic>);
            await box.add(parseData);
          }
        }
        await box.close();
        if (decryptedData.mapData!['Status'] == 'Success') {
          state = ProfileDetailsStateSuccessful(
            successMessage: decryptedData.mapData!['Message'] as String,
            errorMessage: '',
            profileDataHive: ProfileHiveData.empty,
          );
        } else if (decryptedData.mapData!['Status'] != 'Success') {
          state = ProfileDetailsStateError(
            successMessage: '',
            errorMessage: decryptedData.mapData!['Message'] as String,
            profileDataHive: ProfileHiveData.empty,
          );
        }
      } else {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = ProfileDetailsStateError(
          successMessage: '',
          errorMessage: error.message!,
          profileDataHive: ProfileHiveData.empty,
        );
      }
    } else if (response.$1 != 200) {
      state = ProfileDetailsStateError(
        successMessage: '',
        errorMessage: 'Error',
        profileDataHive: ProfileHiveData.empty,
      );
    }
  }

  Future<void> getProfileHive(String search) async {
    try {
      _setLoading();
      final box = await Hive.openBox<ProfileHiveData>('profile');
      final profile = <ProfileHiveData>[...box.values];

      state = state.copyWith(
        profileDataHive: profile[0],
      );
      await box.close();
    } catch (e) {
      await getProfileHive(search);
    }
  }
}

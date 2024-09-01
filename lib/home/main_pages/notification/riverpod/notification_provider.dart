import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/library/model/library_member_response_model.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_state.dart';

class NotificationProvider extends StateNotifier<NotificationState> {
  NotificationProvider() : super(NotificationInitial());

  void disposeState() => state = NotificationInitial();

  void setNotificationNavString(String text) {
    state = state.copyWith(navNotificationString: text);
    log(state.navNotificationString);
  }

  void _setLoading() => state = NotificationLoading(
        successMessage: '',
        errorMessage: '',
        navNotificationString: state.navNotificationString,
        notificationData: <dynamic>[],
      );

  Future<void> getNotificationDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getViewNotificationListJson', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableNotification(
        successMessage: '',
        errorMessage: '',
        navNotificationString: state.navNotificationString,
        notificationData: <dynamic>[],
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRes = details['getViewNotificationListJsonResponse']
          as Map<String, dynamic>;
      final returnData = hostelRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      log('decrypted>>>>>>>>$decryptedData');
//change model
      try {
        final hostelDataResponse =
            LibraryMemberResponseModel.fromJson(decryptedData.mapData!);
        // hostelDetails = hostelDataResponse.data![0];
        // state = state.copyWith(libraryMemberData: libraryMemberDetails);
        if (hostelDataResponse.status == 'Success') {
          state = NotificationSuccessFull(
            successMessage: hostelDataResponse.status!,
            errorMessage: '',
            navNotificationString: state.navNotificationString,
            notificationData: <dynamic>[],
          );
        } else if (hostelDataResponse.status != 'Success') {
          state = NotificationError(
            successMessage: '',
            errorMessage: hostelDataResponse.status!,
            navNotificationString: state.navNotificationString,
            notificationData: <dynamic>[],
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = NotificationError(
          successMessage: '',
          errorMessage: error.message!,
          navNotificationString: state.navNotificationString,
          notificationData: <dynamic>[],
        );
      }
    } else if (response.$1 != 200) {
      state = NotificationError(
        successMessage: '',
        errorMessage: 'Error',
        navNotificationString: state.navNotificationString,
        notificationData: <dynamic>[],
      );
    }
  }
}

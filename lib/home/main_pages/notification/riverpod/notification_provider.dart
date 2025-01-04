import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/notification/model/notification_model.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_state.dart';

class NotificationProvider extends StateNotifier<NotificationState> {
  NotificationProvider() : super(NotificationInitial());

  void disposeState() => state = NotificationInitial();

  void _setLoading() => state = const NotificationLoading(
        successMessage: '',
        errorMessage: '',
        notificationData: <NotificationData>[],
      );

  Future<void> getNotificationDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getNoticeBoardDetailsjson', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableNotification(
        successMessage: '',
        errorMessage: '',
        notificationData: state.notificationData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRes =
          details['getNoticeBoardDetailsjsonResponse'] as Map<String, dynamic>;
      final returnData = hostelRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      var notificationData = state.notificationData;
      log('decrypted>>>>>>>>$decryptedData');
//change model
      try {
        final notificationDataResponse =
            NotificationModel.fromJson(decryptedData.mapData!);

        notificationData = notificationDataResponse.data!;
        state = state.copyWith(notificationData: notificationData);
        if (notificationDataResponse.status == 'Success') {
          state = NotificationSuccessFull(
            successMessage: notificationDataResponse.status!,
            errorMessage: '',
            notificationData: state.notificationData,
          );
        } else if (notificationDataResponse.status != 'Success') {
          state = NotificationError(
            successMessage: '',
            errorMessage: notificationDataResponse.status!,
            notificationData: state.notificationData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = NotificationError(
          successMessage: '',
          errorMessage: error.message!,
          notificationData: state.notificationData,
        );
      }
    } else if (response.$1 != 200) {
      state = NotificationError(
        successMessage: '',
        errorMessage: 'Error',
        notificationData: state.notificationData,
      );
    }
  }
}

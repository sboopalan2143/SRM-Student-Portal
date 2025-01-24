import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/notification/model/notification_count_model.dart';
import 'package:sample/home/main_pages/notification/model/notification_model.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_count_state.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_state.dart';

class NotificationCountProvider extends StateNotifier<NotificationCountState> {
  NotificationCountProvider() : super(NotificationCountInitial());

  void disposeState() => state = NotificationCountInitial();

  void _setLoading() => state = const NotificationCountLoading(
        successMessage: '',
        errorMessage: '',
        notificationCountData: <NotificationCountData>[],
      );

  Future<void> getNotificationCountDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getViewUnReadNotification', data);
    if (response.$1 == 0) {
      state = NoNetworkCountAvailableNotification(
        successMessage: '',
        errorMessage: '',
        notificationCountData: state.notificationCountData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRes =
          details['getViewUnReadNotificationResponse'] as Map<String, dynamic>;
      final returnData = hostelRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      var notificationCountData = state.notificationCountData;
      log('notificationCountData >>>>>>>>$notificationCountData');
//change model
      try {
        final notificationCountDataResponse =
            NotificationCountModel.fromJson(decryptedData.mapData!);

        notificationCountData = notificationCountDataResponse.data!;
        state = state.copyWith(notificationCountData: notificationCountData);
        if (notificationCountDataResponse.status == 'Success') {
          state = NotificationCountSuccessFull(
            successMessage: notificationCountDataResponse.status!,
            errorMessage: '',
            notificationCountData: state.notificationCountData,
          );
        } else if (notificationCountDataResponse.status != 'Success') {
          state = NotificationCountError(
            successMessage: '',
            errorMessage: notificationCountDataResponse.status!,
            notificationCountData: state.notificationCountData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = NotificationCountError(
          successMessage: '',
          errorMessage: error.message!,
          notificationCountData: state.notificationCountData,
        );
      }
    } else if (response.$1 != 200) {
      state = NotificationCountError(
        successMessage: '',
        errorMessage: 'Error',
        notificationCountData: state.notificationCountData,
      );
    }
  }

  Future<void> getreadNotificationDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('saveReadNotification', data);
    if (response.$1 == 0) {
      state = NoNetworkCountAvailableNotification(
        successMessage: '',
        errorMessage: '',
        notificationCountData: state.notificationCountData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRes =
          details['getViewUnReadNotificationResponse'] as Map<String, dynamic>;
      final returnData = hostelRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      var notificationCountData = state.notificationCountData;
      log('notificationCountData >>>>>>>>$notificationCountData');
//change model
      try {
        final notificationCountDataResponse =
            NotificationCountModel.fromJson(decryptedData.mapData!);

        notificationCountData = notificationCountDataResponse.data!;
        state = state.copyWith(notificationCountData: notificationCountData);
        if (notificationCountDataResponse.status == 'Success') {
          state = NotificationCountSuccessFull(
            successMessage: notificationCountDataResponse.status!,
            errorMessage: '',
            notificationCountData: state.notificationCountData,
          );
        } else if (notificationCountDataResponse.status != 'Success') {
          state = NotificationCountError(
            successMessage: '',
            errorMessage: notificationCountDataResponse.status!,
            notificationCountData: state.notificationCountData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = NotificationCountError(
          successMessage: '',
          errorMessage: error.message!,
          notificationCountData: state.notificationCountData,
        );
      }
    } else if (response.$1 != 200) {
      state = NotificationCountError(
        successMessage: '',
        errorMessage: 'Error',
        notificationCountData: state.notificationCountData,
      );
    }
  }
}

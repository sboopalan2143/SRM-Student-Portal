import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/academics/overall_attendance_page/model/dhasboard_overall_attendance_model.dart';
import 'package:sample/home/main_pages/academics/overall_attendance_page/model/overall_attendance_model.dart';
import 'package:sample/home/main_pages/academics/overall_attendance_page/riverpod/dhasboard_overall_attendance_state.dart';
import 'package:sample/home/main_pages/academics/overall_attendance_page/riverpod/overall_attendance_state.dart';
import 'package:sample/home/main_pages/notification/model/notification_count_model.dart';
import 'package:sample/home/main_pages/notification/model/notification_model.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_count_state.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_state.dart';

class DhasboardOverallAttendanceProvider
    extends StateNotifier<DhasboardOverallAttendanceState> {
  DhasboardOverallAttendanceProvider()
      : super(DhasboardOverallAttendanceInitial());

  void disposeState() => state = DhasboardOverallAttendanceInitial();

  void _setLoading() => state = DhasboardOverallAttendanceStateLoading(
        successMessage: '',
        errorMessage: '',
        DhasboardOverallattendanceData: <DhasboardOverallAttendanceData>[],
      );

  Future<void> getDhasboardOverallAttendanceDetails(
      EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response = await HttpService.sendSoapRequest(
        'getOverAllAttendancePercentagejson', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableDhasboardOverallAttendance(
        successMessage: '',
        errorMessage: '',
        DhasboardOverallattendanceData: state.DhasboardOverallattendanceData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRes = details['getOverAllAttendancePercentagejsonResponse']
          as Map<String, dynamic>;
      final returnData = hostelRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      var DhasboardOverallattendanceData = state.DhasboardOverallattendanceData;
      log('DhasboardOverallattendanceData >>>>>>>>$DhasboardOverallattendanceData');
//change model
      try {
        final DhasboardOverallattendanceDataResponse =
            DhasboardOverAllAttendancePercentageModel.fromJson(
                decryptedData.mapData!);

        DhasboardOverallattendanceData =
            DhasboardOverallattendanceDataResponse.data!;
        state = state.copyWith(
            DhasboardOverallattendanceData: DhasboardOverallattendanceData);
        if (DhasboardOverallattendanceDataResponse.status == 'Success') {
          state = DhasboardOverallAttendanceStateSuccessful(
            successMessage: DhasboardOverallattendanceDataResponse.status!,
            errorMessage: '',
            DhasboardOverallattendanceData:
                state.DhasboardOverallattendanceData,
          );
        } else if (DhasboardOverallattendanceDataResponse.status != 'Success') {
          state = DhasboardOverallAttendanceStateError(
            successMessage: '',
            errorMessage: DhasboardOverallattendanceDataResponse.status!,
            DhasboardOverallattendanceData:
                state.DhasboardOverallattendanceData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = DhasboardOverallAttendanceStateError(
          successMessage: '',
          errorMessage: error.message!,
          DhasboardOverallattendanceData: state.DhasboardOverallattendanceData,
        );
      }
    } else if (response.$1 != 200) {
      state = DhasboardOverallAttendanceStateError(
        successMessage: '',
        errorMessage: 'Error',
        DhasboardOverallattendanceData: state.DhasboardOverallattendanceData,
      );
    }
  }
}

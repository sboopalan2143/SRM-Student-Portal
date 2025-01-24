import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/academics/overall_attendance_page/model/overall_attendance_model.dart';
import 'package:sample/home/main_pages/academics/overall_attendance_page/riverpod/overall_attendance_state.dart';
import 'package:sample/home/main_pages/notification/model/notification_count_model.dart';
import 'package:sample/home/main_pages/notification/model/notification_model.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_count_state.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_state.dart';

class OverallAttendanceProvider extends StateNotifier<OverallAttendanceState> {
  OverallAttendanceProvider() : super(OverallAttendanceInitial());

  void disposeState() => state = OverallAttendanceInitial();

  void _setLoading() => state = OverallAttendanceStateLoading(
        successMessage: '',
        errorMessage: '',
        OverallattendanceData: <SubjectOverallAttendanceData>[],
      );

  Future<void> getSubjectWiseOverallAttendanceDetails(
      EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response = await HttpService.sendSoapRequest(
        'getSubjectwiseOverAllAttendance', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableOverallAttendance(
        successMessage: '',
        errorMessage: '',
        OverallattendanceData: state.OverallattendanceData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRes = details['getSubjectwiseOverAllAttendanceResponse']
          as Map<String, dynamic>;
      final returnData = hostelRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      var OverallattendanceData = state.OverallattendanceData;
      log('OverallattendanceData >>>>>>>>$OverallattendanceData');
//change model
      try {
        final OverallattendanceDataResponse =
            SubjectwiseOverallAttendanceModel.fromJson(decryptedData.mapData!);

        OverallattendanceData = OverallattendanceDataResponse.data!;
        state = state.copyWith(OverallattendanceData: OverallattendanceData);
        if (OverallattendanceDataResponse.status == 'Success') {
          state = OverallAttendanceStateSuccessful(
            successMessage: OverallattendanceDataResponse.status!,
            errorMessage: '',
            OverallattendanceData: state.OverallattendanceData,
          );
        } else if (OverallattendanceDataResponse.status != 'Success') {
          state = OverallAttendanceStateError(
            successMessage: '',
            errorMessage: OverallattendanceDataResponse.status!,
            OverallattendanceData: state.OverallattendanceData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = OverallAttendanceStateError(
          successMessage: '',
          errorMessage: error.message!,
          OverallattendanceData: state.OverallattendanceData,
        );
      }
    } else if (response.$1 != 200) {
      state = OverallAttendanceStateError(
        successMessage: '',
        errorMessage: 'Error',
        OverallattendanceData: state.OverallattendanceData,
      );
    }
  }
}

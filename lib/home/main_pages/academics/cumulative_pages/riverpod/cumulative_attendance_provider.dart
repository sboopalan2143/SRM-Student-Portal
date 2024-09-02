import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/model/cumulative_attendance_model.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/riverpod/cumulative_attendance_state.dart';

class CummulativeAttendanceProvider
    extends StateNotifier<CummulativeAttendanceState> {
  CummulativeAttendanceProvider() : super(CummulativeAttendanceInitial());

  void disposeState() => state = CummulativeAttendanceInitial();

  void _setLoading() => state = CummulativeAttendanceStateLoading(
        successMessage: '',
        errorMessage: '',
        cummulativeAttendanceData: state.cummulativeAttendanceData,
      );

  Future<void> getCummulativeAttendanceDetails(
    EncryptionProvider encrypt,
  ) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getCummulativeAttendance', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableCummulativeAttendance(
        successMessage: '',
        errorMessage: '',
        cummulativeAttendanceData: state.cummulativeAttendanceData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final cummulativeAttendanceRes =
          details['getCummulativeAttendanceResponse'] as Map<String, dynamic>;
      final returnData =
          cummulativeAttendanceRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      var cummulativeAttendanceData = state.cummulativeAttendanceData;
      log('decrypted>>>>>>>>$decryptedData');

      // var cummulativeAttendanceData = <CummulativeAttendanceData>[];
      try {
        //change model

        final cummulativeAttendanceDataResponse =
            GetCumulativeAttedence.fromJson(decryptedData.mapData!);
        cummulativeAttendanceData = cummulativeAttendanceDataResponse.data!;
        state = state.copyWith(
            cummulativeAttendanceData: cummulativeAttendanceData,);
        if (cummulativeAttendanceDataResponse.status == 'Success') {
          state = CummulativeAttendanceStateSuccessful(
            successMessage: cummulativeAttendanceDataResponse.status!,
            errorMessage: '',
            cummulativeAttendanceData: state.cummulativeAttendanceData,
          );
        } else if (cummulativeAttendanceDataResponse.status != 'Success') {
          state = CummulativeAttendanceStateError(
            successMessage: '',
            errorMessage:
                '''${cummulativeAttendanceDataResponse.status!}, ${cummulativeAttendanceDataResponse.message!}''',
            cummulativeAttendanceData: state.cummulativeAttendanceData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = CummulativeAttendanceStateError(
          successMessage: '',
          errorMessage: error.message!,
          cummulativeAttendanceData: state.cummulativeAttendanceData,
        );
      }
    } else if (response.$1 != 200) {
      state = CummulativeAttendanceStateError(
        successMessage: '',
        errorMessage: 'Error',
        cummulativeAttendanceData: state.cummulativeAttendanceData,
      );
    }
  }
}

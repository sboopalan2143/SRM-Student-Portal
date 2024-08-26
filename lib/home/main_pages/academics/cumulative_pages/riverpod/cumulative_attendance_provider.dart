import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/riverpod/cumulative_attendance_state.dart';
import 'package:sample/home/main_pages/academics/subject_pages/model/subject_response_model.dart';

class CummulativeAttendanceProvider
    extends StateNotifier<CummulativeAttendanceState> {
  CummulativeAttendanceProvider() : super(CummulativeAttendanceInitial());

  void disposeState() => state = CummulativeAttendanceInitial();

  void _setLoading() => state = const CummulativeAttendanceState(
        successMessage: '',
        errorMessage: '',
        // cummulativeAttendanceData: <CummulativeAttendanceData>[],
      );

  Future<void> getCummulativeAttendanceDetails(
      EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>21f84947bd6aa060</deviceid><accesstoken>TR</accesstoken><androidversion>TR</androidversion><model>TR</model><sdkversion>TR</sdkversion><appversion>TR</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getCummulativeAttendance', data);
    if (response.$1 == 0) {
      state = const NoNetworkAvailableCummulativeAttendance(
        successMessage: '',
        errorMessage: '',
        //  cummulativeAttendanceData: <CummulativeAttendanceData>[],
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final cummulativeAttendanceRes =
          details['getCummulativeAttendanceResponse'] as Map<String, dynamic>;
      final returnData =
          cummulativeAttendanceRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      log('decrypted>>>>>>>>$decryptedData');

      // var cummulativeAttendanceData = <CummulativeAttendanceData>[];
      try {
        //change model
        final cummulativeAttendanceDataResponse =
            SubjectResponseModel.fromJson(decryptedData);
        // cummulativeAttendanceData = attendanceDataResponse.data!;
// state = state.copyWith(cummulativeAttendanceData: cummulativeAttendanceData);
        if (cummulativeAttendanceDataResponse.status == 'Success') {
          state = CummulativeAttendanceStateSuccessful(
            successMessage: cummulativeAttendanceDataResponse.status!,
            errorMessage: '',
            //cummulativeAttendanceData: <CummulativeAttendanceData>[],
          );
        } else if (cummulativeAttendanceDataResponse.status != 'Success') {
          state = CummulativeAttendanceStateError(
            successMessage: '',
            errorMessage: cummulativeAttendanceDataResponse.status!,
            //  cummulativeAttendanceData: <CummulativeAttendanceData>[],
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData);
        state = CummulativeAttendanceStateError(
          successMessage: '',
          errorMessage: error.message!,
          // cummulativeAttendanceData: <CummulativeAttendanceData>[],
        );
      }
    } else if (response.$1 != 200) {
      state = const CummulativeAttendanceStateError(
        successMessage: '',
        errorMessage: 'Error',
        // cummulativeAttendanceData: <CummulativeAttendanceData>[],
      );
    }
  }
}

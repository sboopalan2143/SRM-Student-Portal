import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/model/attendance_response_model.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/riverpod/attendance_state.dart';
import 'package:sample/home/main_pages/academics/subject_pages/model/subject_response_model.dart';
// import 'package:sample/home/main_pages/academics/subject_pages/riverpod/subjects_state.dart';

class AttendanceProvider extends StateNotifier<AttendanceState> {
  AttendanceProvider() : super(AttendanceInitial());

  void disposeState() => state = AttendanceInitial();

  void _setLoading() => state = AttendanceStateLoading(
        successMessage: '',
        errorMessage: '',
        attendanceData: <SubjectAttendanceData>[],
      );

  Future<void> getAttendanceDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>21f84947bd6aa060</deviceid><accesstoken>TR</accesstoken><androidversion>TR</androidversion><model>TR</model><sdkversion>TR</sdkversion><appversion>TR</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getSubjectwiseAttendance', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableAttendance(
        successMessage: '',
        errorMessage: '',
        attendanceData: state.attendanceData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final attendanceRes =
          details['getSubjectwiseAttendanceResponse'] as Map<String, dynamic>;
      final returnData = attendanceRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      var attendanceData = state.attendanceData;
      log('decrypted>>>>>>>>$decryptedData');

      // var attendanceData = <dynamic>[];
      try {
        //change model
        final attendanceDataResponse =
            GetSubjectWiseAttedence.fromJson(decryptedData);
        attendanceData = attendanceDataResponse.data!;
        state = state.copyWith(attendanceData: attendanceData);
        if (attendanceDataResponse.status == 'Success') {
          // final studentIdJson =
          //     attendanceData.map((e) => e.toJson()).toList().toString();
          // await TokensManagement.setStudentId(
          //   studentId: studentIdJson,
          // );
          state = AttendanceStateSuccessful(
            successMessage: attendanceDataResponse.status!,
            errorMessage: '',
            attendanceData: state.attendanceData,
          );
        } else if (attendanceDataResponse.status != 'Success') {
          state = AttendanceStateError(
            successMessage: '',
            errorMessage: attendanceDataResponse.status!,
            attendanceData: state.attendanceData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData);
        state = AttendanceStateError(
          successMessage: '',
          errorMessage: error.message!,
          attendanceData: state.attendanceData,
        );
      }
    } else if (response.$1 != 200) {
      state = AttendanceStateError(
        successMessage: '',
        errorMessage: 'Error',
        attendanceData: state.attendanceData,
      );
    }
  }
}

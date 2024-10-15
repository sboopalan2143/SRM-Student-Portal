import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/model/attendance_hive.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/model/attendance_response_model.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/riverpod/attendance_state.dart';
// import 'package:sample/home/main_pages/academics/subject_pages/riverpod/subjects_state.dart';

class AttendanceProvider extends StateNotifier<AttendanceState> {
  AttendanceProvider() : super(AttendanceInitial());

  void disposeState() => state = AttendanceInitial();

  void _setLoading() => state = AttendanceStateLoading(
        successMessage: '',
        errorMessage: '',
        attendanceData: <SubjectAttendanceData>[],
        attendancehiveData: <SubjectAttendanceHiveData>[],
      );

  Future<void> getAttendanceDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    log('body>>>>><studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>');
    final response =
        await HttpService.sendSoapRequest('getSubjectwiseAttendance', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableAttendance(
        successMessage: '',
        errorMessage: '',
        attendanceData: state.attendanceData,
        attendancehiveData: state.attendancehiveData,
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
        // //change model
        // final attendanceDataResponse =
        //     GetSubjectWiseAttedence.fromJson(decryptedData.mapData!);
        // attendanceData = attendanceDataResponse.data!;
        // state = state.copyWith(attendanceData: attendanceData);
        for (var i = 0; i < attendanceData.length; i++) {
          final parseData = SubjectAttendanceHiveData.fromJson(
              attendanceData[i] as Map<String, dynamic>);
          log('data>>>>${parseData.subjectcode}');
          final box = await Hive.openBox<SubjectAttendanceHiveData>(
              'subjectattendance');
          final index = box.values
              .toList()
              .indexWhere((e) => e.subjectcode == parseData.subjectcode);
          if (index != -1) {
            await box.putAt(index, parseData);
          } else {
            await box.add(parseData);
          }
        }
        if (decryptedData.mapData!['Status'] == 'Success') {
          // final studentIdJson =
          //     attendanceData.map((e) => e.toJson()).toList().toString();
          // await TokensManagement.setStudentId(
          //   studentId: studentIdJson,
          // );
          state = AttendanceStateSuccessful(
            successMessage: decryptedData.mapData!['Message'] as String,
            errorMessage: '',
            attendanceData: state.attendanceData,
            attendancehiveData: state.attendancehiveData,
          );
        } else if (decryptedData.mapData!['Message'] as String != 'Success') {
          state = AttendanceStateError(
            successMessage: '',
            errorMessage: decryptedData.mapData!['Message'] as String,
            attendanceData: state.attendanceData,
            attendancehiveData: state.attendancehiveData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = AttendanceStateError(
          successMessage: '',
          errorMessage: error.message!,
          attendanceData: state.attendanceData,
          attendancehiveData: state.attendancehiveData,
        );
      }
    } else if (response.$1 != 200) {
      state = AttendanceStateError(
        successMessage: '',
        errorMessage: 'Error',
        attendanceData: state.attendanceData,
        attendancehiveData: state.attendancehiveData,
      );
    }
  }

  Future<void> getHiveAttendanceDetails(String search) async {
    try {
      _setLoading();
      final box =
          await Hive.openBox<SubjectAttendanceHiveData>('subjectattendance');
      final profile = <SubjectAttendanceHiveData>[...box.values];
      log('profile length>>>${profile[0].subjectcode}');

      state = AttendanceStateSuccessful(
        successMessage: '',
        errorMessage: '',
        attendanceData: state.attendanceData,
        attendancehiveData: state.attendancehiveData,
      );
    } catch (e) {
      await getHiveAttendanceDetails(search);
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/model/attendance_hive.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/riverpod/attendance_state.dart';

class AttendanceProvider extends StateNotifier<AttendanceState> {
  AttendanceProvider() : super(AttendanceInitial());

  void disposeState() => state = AttendanceInitial();

  void _setLoading() => state = AttendanceStateLoading(
        successMessage: '',
        errorMessage: '',
        attendancehiveData: <AttendanceHiveData>[],
      );

  Future<void> getAttendanceDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getSubjectwiseAttendance', data);
    if (response.$1 == 0) {
      state = const NoNetworkAvailableAttendance(
        successMessage: '',
        errorMessage: 'No Network. Connect to Internet',
        attendancehiveData: <AttendanceHiveData>[],
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final attendanceRes =
          details['getSubjectwiseAttendanceResponse'] as Map<String, dynamic>;
      final returnData = attendanceRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      if (decryptedData.mapData!['Status'] == 'Success') {
        final listData = decryptedData.mapData!['Data'] as List<dynamic>;

        // var attendanceData = <dynamic>[];
        if (listData.isNotEmpty) {
          // //change model
          // final attendanceDataResponse =
          //     GetSubjectWiseAttedence.fromJson(decryptedData.mapData!);
          // attendanceData = attendanceDataResponse.data!;
          // state = state.copyWith(attendanceData: attendanceData);
          final box = await Hive.openBox<AttendanceHiveData>(
            'Attendance',
          );
          if (box.isEmpty) {
            for (var i = 0; i < listData.length; i++) {
              final parseData = AttendanceHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          } else {
            await box.clear();
            for (var i = 0; i < listData.length; i++) {
              final parseData = AttendanceHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          }
          await box.close();

          // final studentIdJson =
          //     attendanceData.map((e) => e.toJson()).toList().toString();
          // await TokensManagement.setStudentId(
          //   studentId: studentIdJson,
          // );
          state = AttendanceStateSuccessful(
            successMessage: decryptedData.mapData!['Message'] as String,
            errorMessage: '',
            attendancehiveData: <AttendanceHiveData>[],
          );
        } else {
          final error = ErrorModel.fromJson(decryptedData.mapData!);
          state = AttendanceStateError(
            successMessage: '',
            errorMessage: error.message!,
            attendancehiveData: <AttendanceHiveData>[],
          );
        }
      } else if (decryptedData.mapData!['Message'] as String != 'Success') {
        state = AttendanceStateError(
          successMessage: '',
          errorMessage: decryptedData.mapData!['Message'] as String,
          attendancehiveData: <AttendanceHiveData>[],
        );
      }
    } else if (response.$1 != 200) {
      state = const AttendanceStateError(
        successMessage: '',
        errorMessage: 'Error',
        attendancehiveData: <AttendanceHiveData>[],
      );
    }
  }

  Future<void> getHiveAttendanceDetails(String search) async {
    try {
      _setLoading();
      final box = await Hive.openBox<AttendanceHiveData>('Attendance');
      final attendancelishive = <AttendanceHiveData>[...box.values];

      state = state.copyWith(
        attendancehiveData: attendancelishive,
      );
      await box.close();
    } catch (e) {
      await getHiveAttendanceDetails(search);
    }
  }
}

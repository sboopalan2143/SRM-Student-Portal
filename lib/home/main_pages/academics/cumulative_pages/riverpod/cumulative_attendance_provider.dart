import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/model/cummulative_attendance_hive.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/riverpod/cumulative_attendance_state.dart';

class CummulativeAttendanceProvider
    extends StateNotifier<CummulativeAttendanceState> {
  CummulativeAttendanceProvider() : super(CummulativeAttendanceInitial());

  void disposeState() => state = CummulativeAttendanceInitial();

  void _setLoading() => state = CummulativeAttendanceStateLoading(
        successMessage: '',
        errorMessage: '',
        cummulativeAttendanceData: state.cummulativeAttendanceData,
        cummulativeHiveAttendanceData: state.cummulativeHiveAttendanceData,
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
        cummulativeHiveAttendanceData: state.cummulativeHiveAttendanceData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final cummulativeAttendanceRes =
          details['getCummulativeAttendanceResponse'] as Map<String, dynamic>;
      final returnData =
          cummulativeAttendanceRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      final cummulativelistAttendanceData =
          decryptedData.mapData!['Data'] as List<dynamic>;
      log('decrypted>>>>>>>>$decryptedData');

      // var cummulativeAttendanceData = <CummulativeAttendanceData>[];
      try {
        //change model

        // final cummulativeAttendanceDataResponse =
        //     GetCumulativeAttedence.fromJson(decryptedData.mapData!);
        // cummulativeAttendanceData = cummulativeAttendanceDataResponse.data!;
        // state = state.copyWith(
        //   cummulativeAttendanceData: cummulativeAttendanceData,
        // );
        for (var i = 0; i < cummulativelistAttendanceData.length; i++) {
          final parseData = CumulativeAttendanceHiveData.fromJson(
              cummulativelistAttendanceData[i] as Map<String, dynamic>);
          log('data>>>>${parseData.attendancemonthyear}');
          final box = await Hive.openBox<CumulativeAttendanceHiveData>(
            'cumulativeattendance',
          );
          final index = box.values.toList().indexWhere(
              (e) => e.attendancemonthyear == parseData.attendancemonthyear);
          if (index != -1) {
            await box.putAt(index, parseData);
          } else {
            await box.add(parseData);
          }
        }
        if (decryptedData.mapData!['Status'] == 'Success') {
          state = CummulativeAttendanceStateSuccessful(
            successMessage: decryptedData.mapData!['Message'] as String,
            errorMessage: '',
            cummulativeAttendanceData: state.cummulativeAttendanceData,
            cummulativeHiveAttendanceData: state.cummulativeHiveAttendanceData,
          );
        } else if (decryptedData.mapData!['Message'] != 'Success') {
          state = CummulativeAttendanceStateError(
            successMessage: '',
            errorMessage:
                '''${decryptedData.mapData!['Message']}, ${decryptedData.mapData!['Message']}''',
            cummulativeAttendanceData: state.cummulativeAttendanceData,
            cummulativeHiveAttendanceData: state.cummulativeHiveAttendanceData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = CummulativeAttendanceStateError(
          successMessage: '',
          errorMessage: error.message!,
          cummulativeAttendanceData: state.cummulativeAttendanceData,
          cummulativeHiveAttendanceData: state.cummulativeHiveAttendanceData,
        );
      }
    } else if (response.$1 != 200) {
      state = CummulativeAttendanceStateError(
        successMessage: '',
        errorMessage: 'Error',
        cummulativeAttendanceData: state.cummulativeAttendanceData,
        cummulativeHiveAttendanceData: state.cummulativeHiveAttendanceData,
      );
    }
  }

  Future<void> getHiveCummulativeDetails(String search) async {
    try {
      _setLoading();
      final box = await Hive.openBox<CumulativeAttendanceHiveData>(
        'cumulativeattendance',
      );
      final cumulativeattendance = <CumulativeAttendanceHiveData>[
        ...box.values
      ];
      log('cumulative length>>>${cumulativeattendance[0].attendancemonthyear}');

      state = CummulativeAttendanceStateSuccessful(
        successMessage: '',
        errorMessage: '',
        cummulativeAttendanceData: state.cummulativeAttendanceData,
        cummulativeHiveAttendanceData: cumulativeattendance,
      );
    } catch (e) {
      await getHiveCummulativeDetails(search);
    }
  }
}

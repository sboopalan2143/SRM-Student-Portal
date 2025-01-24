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
        errorMessage: 'No Network. Connect to Internet',
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
      if (decryptedData.mapData!['Status'] == 'Success') {
        final listData = decryptedData.mapData!['Data'] as List<dynamic>;
        log('decrypted>>>>>>>>$decryptedData');

        // var cummulativeAttendanceData = <CummulativeAttendanceData>[];
        // try {
        //change model

        // final cummulativeAttendanceDataResponse =
        //     GetCumulativeAttedence.fromJson(decryptedData.mapData!);
        // cummulativeAttendanceData = cummulativeAttendanceDataResponse.data!;
        // state = state.copyWith(
        //   cummulativeAttendanceData: cummulativeAttendanceData,
        // );
        if (listData.isNotEmpty) {
          final box = await Hive.openBox<CumulativeAttendanceHiveData>(
            'cumulativeattendance',
          );
          if (box.isEmpty) {
            for (var i = 0; i < listData.length; i++) {
              final parseData = CumulativeAttendanceHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          } else {
            await box.clear();
            for (var i = 0; i < listData.length; i++) {
              final parseData = CumulativeAttendanceHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          }
          await box.close();

          state = CummulativeAttendanceStateSuccessful(
            successMessage: decryptedData.mapData!['Message'] as String,
            errorMessage: '',
            cummulativeHiveAttendanceData: state.cummulativeHiveAttendanceData,
          );
        } else {
          final error = ErrorModel.fromJson(decryptedData.mapData!);
          state = CummulativeAttendanceStateError(
            successMessage: '',
            errorMessage: error.message!,
            cummulativeHiveAttendanceData: state.cummulativeHiveAttendanceData,
          );
        }
      } else if (decryptedData.mapData!['Message'] != 'Success') {
        state = CummulativeAttendanceStateError(
          successMessage: '',
          errorMessage:
              '''${decryptedData.mapData!['Message']}, ${decryptedData.mapData!['Message']}''',
          cummulativeHiveAttendanceData: state.cummulativeHiveAttendanceData,
        );
      }
    } else if (response.$1 != 200) {
      state = CummulativeAttendanceStateError(
        successMessage: '',
        errorMessage: 'Error',
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
        ...box.values,
      ];

      state = state.copyWith(
        cummulativeHiveAttendanceData: cumulativeattendance,
      );
    } catch (e) {
      await getHiveCummulativeDetails(search);
    }
  }
}

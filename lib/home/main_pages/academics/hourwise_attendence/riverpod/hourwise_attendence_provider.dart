import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/academics/hourwise_attendence/hourwise_model.dart/hourwise_hive_model.dart';
import 'package:sample/home/main_pages/academics/hourwise_attendence/riverpod/hourwise_attendence_state.dart';

class HourwiseProvider extends StateNotifier<HourwiseState> {
  HourwiseProvider() : super(HourwiseInitial());

  void disposeState() => state = HourwiseInitial();

  void _setLoading() => state = const HourwiseStateLoading(
        successMessage: '',
        errorMessage: '',
        listHourWiseHiveData: <HourwiseHiveData>[],
      );

  Future<void> gethourwiseDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    log('Student ID>>> ${TokensManagement.studentId}');
    log('encrypted data>>>>>$data');
    final response =
        await HttpService.sendSoapRequest('getHourwiseAttendance', data);

    if (response.$1 == 0) {
      state = NoNetworkAvailablehourwise(
        successMessage: '',
        errorMessage: 'No Network. Connect to Internet',
        listHourWiseHiveData: state.listHourWiseHiveData,
      );

      log('hourwise response >>>> $response');
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hourwiseRes =
          details['getHourwiseAttendanceResponse'] as Map<String, dynamic>;
      final returnData = hourwiseRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      // final listHourWiseData = state.listHourWiseData;
      if (decryptedData.mapData!['Status'] == 'Success') {
        final listData = decryptedData.mapData!['Data'] as List<dynamic>;
        log('decrypted>>>>>>>>$decryptedData');

        if (listData.isNotEmpty) {
          // final hourWiseDetails =
          //     HourwisePaidDetails.fromJson(decryptedData.mapData!);
          // listHourWiseData.addAll(hourWiseDetails.data!);
          // state = state.copyWith(listHourWiseData: listHourWiseData);
          final box = await Hive.openBox<HourwiseHiveData>(
            'hourwisedata',
          );
          if (box.isEmpty) {
            for (var i = 0; i < listData.length; i++) {
              final parseData = HourwiseHiveData.fromJson(
                  listData[i] as Map<String, dynamic>);

              await box.add(parseData);
            }
          } else {
            await box.clear();
            for (var i = 0; i < listData.length; i++) {
              final parseData = HourwiseHiveData.fromJson(
                  listData[i] as Map<String, dynamic>);

              await box.add(parseData);
            }
          }
          await box.close();

          // final studentIdJson =
          //     listHourWiseData.map((e) => e.toJson()).toList().toString();
          // await TokensManagement.setStudentId(
          //   studentId: studentIdJson,
          // );

          state = HourwiseStateSuccessful(
            successMessage: decryptedData.mapData!['Status'] as String,
            errorMessage: '',
            listHourWiseHiveData: state.listHourWiseHiveData,
          );
          // disposeState();
        } else {
          final error = ErrorModel.fromJson(decryptedData.mapData!);
          state = HourwiseError(
            successMessage: '',
            errorMessage: error.message!,
            listHourWiseHiveData: state.listHourWiseHiveData,
          );
        }
      } else if (decryptedData.mapData!['Status'] != 'Success') {
        state = HourwiseError(
          successMessage: '',
          errorMessage:
              '''${decryptedData.mapData!['Status']!}, ${decryptedData.mapData!['Status']}''',
          listHourWiseHiveData: state.listHourWiseHiveData,
        );
      }
    } else if (response.$1 != 200) {
      state = HourwiseError(
        successMessage: '',
        errorMessage: 'Error',
        listHourWiseHiveData: state.listHourWiseHiveData,
      );
    }
  }

  Future<void> getHiveHourwise(String search) async {
    try {
      _setLoading();
      final box = await Hive.openBox<HourwiseHiveData>(
        'hourwisedata',
      );
      final hourwise = <HourwiseHiveData>[...box.values];

      state = state.copyWith(
        listHourWiseHiveData: hourwise,
      );
      await box.close();
    } catch (e) {
      await getHiveHourwise(search);
    }
  }
}

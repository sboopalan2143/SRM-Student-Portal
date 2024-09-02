import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/academics/hourwise_attendence/hourwise_model.dart/hourwise_model.dart';
import 'package:sample/home/main_pages/academics/hourwise_attendence/riverpod/hourwise_attendence_state.dart';

class HourwiseProvider extends StateNotifier<HourwiseState> {
  HourwiseProvider() : super(HourwiseInitial());

  void disposeState() => state = HourwiseInitial();

  void _setLoading() => state = HourwiseStateLoading(
        successMessage: '',
        errorMessage: '',
        listHourWiseData: <HourwiseData>[],
        hourwiseData: HourwiseData.empty,
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
        errorMessage: '',
        hourwiseData: state.hourwiseData,
        listHourWiseData: state.listHourWiseData,
      );

      log('hourwise response >>>> $response');
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hourwiseRes =
          details['getHourwiseAttendanceResponse'] as Map<String, dynamic>;
      final returnData = hourwiseRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      final listHourWiseData = state.listHourWiseData;
      log('decrypted>>>>>>>>$decryptedData');

      try {
        final hourWiseDetails =
            HourwisePaidDetails.fromJson(decryptedData.mapData!);
        listHourWiseData.addAll(hourWiseDetails.data!);
        state = state.copyWith(listHourWiseData: listHourWiseData);

        if (hourWiseDetails.status == 'Success') {
          // final studentIdJson =
          //     listHourWiseData.map((e) => e.toJson()).toList().toString();
          // await TokensManagement.setStudentId(
          //   studentId: studentIdJson,
          // );

          state = HourwiseStateSuccessful(
            successMessage: hourWiseDetails.status!,
            errorMessage: '',
            hourwiseData: state.hourwiseData,
            listHourWiseData: state.listHourWiseData,
          );
          // disposeState();
        } else if (hourWiseDetails.status != 'Success') {
          state = HourwiseError(
            successMessage: '',
            errorMessage:
                '''${hourWiseDetails.status!}, ${hourWiseDetails.message!}''',
            hourwiseData: state.hourwiseData,
            listHourWiseData: state.listHourWiseData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = HourwiseError(
          successMessage: '',
          errorMessage: error.message!,
          hourwiseData: state.hourwiseData,
          listHourWiseData: state.listHourWiseData,
        );
      }
    } else if (response.$1 != 200) {
      state = HourwiseError(
        successMessage: '',
        errorMessage: 'Error',
        hourwiseData: state.hourwiseData,
        listHourWiseData: state.listHourWiseData,
      );
    }
  }
}

import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/academics/hourwise_attendence/hourwise_model.dart/hourwise_model.dart';
import 'package:sample/home/main_pages/academics/hourwise_attendence/riverpod/hourwise_attendence_state.dart';

class HourwiseProvider extends StateNotifier<hourwiseState> {
  HourwiseProvider() : super(hourwiseInitial());

  void disposeState() => state = hourwiseInitial();

  Future<void> gethourwiseDetails(EncryptionProvider encrypt) async {
    // await TokensManagement.getStudentId();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>21f84947bd6aa060</deviceid><accesstoken>TR</accesstoken><androidversion>TR</androidversion><model>TR</model><sdkversion>TR</sdkversion><appversion>TR</appversion>',
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
      final loginRes =
          details['getHourwiseAttendanceResponse'] as Map<String, dynamic>;
      final returnData = loginRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      final listHourWiseData = state.listHourWiseData;
      try {
        final hourWiseDetails = HourwisePaidDetails.fromJson(decryptedData);
        listHourWiseData.addAll(hourWiseDetails.data!);
        state = state.copyWith(listHourWiseData: listHourWiseData);

        if (hourWiseDetails.status == 'Success') {
          final studentIdJson =
              listHourWiseData.map((e) => e.toJson()).toList().toString();
          await TokensManagement.setStudentId(
            studentId: studentIdJson,
          );

          state = hourwiseStateSuccessful(
            successMessage: hourWiseDetails.status!,
            errorMessage: '',
            hourwiseData: state.hourwiseData,
            listHourWiseData: state.listHourWiseData,
          );
          // disposeState();
        } else if (hourWiseDetails.status != 'Success') {
          state = hourwiseError(
            successMessage: '',
            errorMessage: 'Error',
            hourwiseData: state.hourwiseData,
            listHourWiseData: state.listHourWiseData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData);
        state = hourwiseError(
          successMessage: '',
          errorMessage: error.message!,
          hourwiseData: state.hourwiseData,
          listHourWiseData: state.listHourWiseData,
        );
      }
    } else if (response.$1 != 200) {
      state = hourwiseError(
        successMessage: '',
        errorMessage: 'Error',
        hourwiseData: state.hourwiseData,
        listHourWiseData: state.listHourWiseData,
      );
    }
  }
}

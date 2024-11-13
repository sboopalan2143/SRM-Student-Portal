import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/model/exam_details_hive_model.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/riverpod/exam_details_state.dart';

class ExamDetailsProvider extends StateNotifier<ExamDetailsState> {
  ExamDetailsProvider() : super(ExamDetailsInitial());

  void disposeState() => state = ExamDetailsInitial();

  void _setLoading() => state = const ExamDetailsStateLoading(
        successMessage: '',
        errorMessage: '',
        examDetailsHiveData: <ExamDetailsHiveData>[],
      );

  Future<void> getExamDetailsApi(
    EncryptionProvider encrypt,
  ) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response = await HttpService.sendSoapRequest('getExamDetails', data);
    if (response.$1 == 0) {
      state = const NoNetworkAvailableExamDetails(
        successMessage: '',
        errorMessage: 'No Network. Connect to Internet',
        examDetailsHiveData: <ExamDetailsHiveData>[],
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final examDetailsRes =
          details['getExamDetailsResponse'] as Map<String, dynamic>;
      final returnData = examDetailsRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      log('decrypted>>>>>>>>$decryptedData');
      if (decryptedData.mapData!['Status'] == 'Success') {
        // var examDetailsData = <ExamDetailsData>[];
        final listData = decryptedData.mapData!['Data'] as List<dynamic>;
        // log('listData length>>>${examDetailslistData.length}');
        if (listData.isNotEmpty) {
          // final examDetailsResponse =
          //     ExamDetails.fromJson(decryptedData.mapData!);
          // examDetailsData = examDetailsResponse.data!;
          // state = state.copyWith(examDetailsData: examDetailsData);
          // log('exam details ${examDetailsData.length}');
          final box = await Hive.openBox<ExamDetailsHiveData>('examDetails');
          if (box.isEmpty) {
            for (var i = 0; i < listData.length; i++) {
              final parseData = ExamDetailsHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          } else {
            await box.clear();
            for (var i = 0; i < listData.length; i++) {
              final parseData = ExamDetailsHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          }
          await box.close();

          state = ExamDetailsStateSuccessful(
            successMessage: decryptedData.mapData!['Message'] as String,
            errorMessage: '',
            examDetailsHiveData: <ExamDetailsHiveData>[],
          );
        } else {
          final error = ErrorModel.fromJson(decryptedData.mapData!);
          state = ExamDetailsError(
            successMessage: '',
            errorMessage: error.message!,
            examDetailsHiveData: <ExamDetailsHiveData>[],
          );
        }
      } else if (decryptedData.mapData!['Status'] != 'Success') {
        state = ExamDetailsError(
          successMessage: '',
          errorMessage: decryptedData.mapData!['Message'] as String,
          examDetailsHiveData: <ExamDetailsHiveData>[],
        );
      }
    } else if (response.$1 != 200) {
      state = const ExamDetailsError(
        successMessage: '',
        errorMessage: 'Error',
        examDetailsHiveData: <ExamDetailsHiveData>[],
      );
    }
  }

  Future<void> getHiveExamDetails(String search) async {
    try {
      final box = await Hive.openBox<ExamDetailsHiveData>('examDetails');
      final examDetailsHive = <ExamDetailsHiveData>[...box.values];

      state = state.copyWith(
        examDetailsHiveData: examDetailsHive,
      );
      await box.close();
    } catch (e) {
      await getHiveExamDetails(search);
    }
  }
}

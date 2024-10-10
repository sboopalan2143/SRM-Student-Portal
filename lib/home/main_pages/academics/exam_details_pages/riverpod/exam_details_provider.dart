import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/drawer_pages/profile/model/profile_response_model.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/model/exam_details_model.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/riverpod/exam_details_state.dart';

import '../model/exam_details_hive_model.dart';

class ExamDetailsProvider extends StateNotifier<ExamDetailsState> {
  ExamDetailsProvider() : super(ExamDetailsInitial());

  void disposeState() => state = ExamDetailsInitial();

  void _setLoading() => state = const ExamDetailsStateLoading(
        successMessage: '',
        errorMessage: '',
        examDetailsData: <ExamDetailsData>[],
        examDetailsHiveData: <ExamDetailsHiveData>[],
      );

  Future<void> getExamDetails(
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
        errorMessage: '',
        examDetailsData: <ExamDetailsData>[],
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

      // var examDetailsData = <ExamDetailsData>[];
      final examDetailslistData =
          decryptedData.mapData!['Data'] as List<dynamic>;
      log('listData length>>>${examDetailslistData.length}');
      try {
        // final examDetailsResponse =
        //     ExamDetails.fromJson(decryptedData.mapData!);
        // examDetailsData = examDetailsResponse.data!;
        // state = state.copyWith(examDetailsData: examDetailsData);
        // log('exam details ${examDetailsData.length}');
        for (var i = 0; i < examDetailslistData.length; i++) {
          final parseData = ExamDetailsHiveData.fromJson(
              examDetailslistData[i] as Map<String, dynamic>);
          log('data>>>>${parseData.subjectcode}');
          final box = await Hive.openBox<ExamDetailsHiveData>('Exam Details');
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
          state = ExamDetailsStateSuccessful(
            successMessage: decryptedData.mapData!['Message'] as String,
            errorMessage: '',
            examDetailsData: state.examDetailsData,
            examDetailsHiveData: <ExamDetailsHiveData>[],
          );
        } else if (decryptedData.mapData!['Status'] != 'Success') {
          state = ExamDetailsError(
            successMessage: '',
            errorMessage: decryptedData.mapData!['Message'] as String,
            examDetailsData: <ExamDetailsData>[],
            examDetailsHiveData: <ExamDetailsHiveData>[],
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = ExamDetailsError(
          successMessage: '',
          errorMessage: error.message!,
          examDetailsData: <ExamDetailsData>[],
          examDetailsHiveData: <ExamDetailsHiveData>[],
        );
      }
    } else if (response.$1 != 200) {
      state = const ExamDetailsError(
        successMessage: '',
        errorMessage: 'Error',
        examDetailsData: <ExamDetailsData>[],
        examDetailsHiveData: <ExamDetailsHiveData>[],
      );
    }
  }

  Future<void> getHiveExamDetails(String search) async {
    try {
      _setLoading();
      final box = await Hive.openBox<ExamDetailsHiveData>('Exam Details');
      final examDetailsHive = <ExamDetailsHiveData>[...box.values];
      log('profile length>>>${examDetailsHive[0].subjectcode}');

      state = ExamDetailsStateSuccessful(
        successMessage: '',
        errorMessage: '',
        examDetailsData: state.examDetailsData,
        examDetailsHiveData: examDetailsHive,
      );
    } catch (e) {
      await getHiveExamDetails(search);
    }
  }
}

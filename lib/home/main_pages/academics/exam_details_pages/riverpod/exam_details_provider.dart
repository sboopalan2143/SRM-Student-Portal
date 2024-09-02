import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/model/exam_details_model.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/riverpod/exam_details_state.dart';

class ExamDetailsProvider extends StateNotifier<ExamDetailsState> {
  ExamDetailsProvider() : super(ExamDetailsInitial());

  void disposeState() => state = ExamDetailsInitial();

  void _setLoading() => state = const ExamDetailsStateLoading(
        successMessage: '',
        errorMessage: '',
        examDetailsData: <ExamDetailsData>[],
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
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final examDetailsRes =
          details['getExamDetailsResponse'] as Map<String, dynamic>;
      final returnData = examDetailsRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      log('decrypted>>>>>>>>$decryptedData');

      var examDetailsData = <ExamDetailsData>[];
      try {
        final examDetailsResponse =
            ExamDetails.fromJson(decryptedData.mapData!);
        examDetailsData = examDetailsResponse.data!;
        state = state.copyWith(examDetailsData: examDetailsData);
        log('exam details ${examDetailsData.length}');
        if (examDetailsResponse.status == 'Success') {
          state = ExamDetailsStateSuccessful(
            successMessage: examDetailsResponse.status!,
            errorMessage: '',
            examDetailsData: state.examDetailsData,
          );
        } else if (examDetailsResponse.status != 'Success') {
          state = ExamDetailsError(
            successMessage: '',
            errorMessage:
                '''${examDetailsResponse.status!}, ${examDetailsResponse.message!}''',
            examDetailsData: state.examDetailsData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = ExamDetailsError(
          successMessage: '',
          errorMessage: error.message!,
          examDetailsData: <ExamDetailsData>[],
        );
      }
    } else if (response.$1 != 200) {
      state = const ExamDetailsError(
        successMessage: '',
        errorMessage: 'Error',
        examDetailsData: <ExamDetailsData>[],
      );
    }
  }
}

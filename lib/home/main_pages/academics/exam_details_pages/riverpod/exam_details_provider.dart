import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/riverpod/exam_details_state.dart';
import 'package:sample/login/model/login_response_model.dart';

class ExamDetailsProvider extends StateNotifier<examDetailsState> {
  ExamDetailsProvider() : super(examDetailsInitial());

  void disposeState() => state = examDetailsInitial();

  void _setLoading() => state = examDetailsStateLoading(
        successMessage: '',
        errorMessage: '',
      );

  Future<void> getexamDetailsDetails(EncryptionProvider encrypt) async {
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>21f84947bd6aa060</deviceid><accesstoken>TR</accesstoken><androidversion>TR</androidversion><model>TR</model><sdkversion>TR</sdkversion><appversion>TR</appversion>',
    );
    log('encrypted data>>>>>$data');
    final response = await HttpService.sendSoapRequest('getExamDetails', data);

    log('$response');
    if (response.$1 == 0) {
      state = const NoNetworkAvailableexamDetails(
        successMessage: '',
        errorMessage: '',
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final loginRes =
          details['getStudentLoginResponse'] as Map<String, dynamic>;
      final returnData = loginRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      var studentData = <LoginData>[];
      final studentLoginDetails = LoginResponseModel.fromJson(decryptedData);
      studentData.addAll(studentLoginDetails.data!);
      if (studentLoginDetails.status == 'success') {
        state = examDetailsStateSuccessful(
          successMessage: studentLoginDetails.status!,
          errorMessage: '',
        );
      }

      disposeState();
    } else if (response.$1 != 200) {
      state = const examDetailsError(
        successMessage: '',
        errorMessage: 'Error',
      );
    }
  }

  void setFeesNavString(String text) {}
}

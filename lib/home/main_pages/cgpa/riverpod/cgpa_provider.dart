import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/cgpa/model/cgpa_model.dart';
import 'package:sample/home/main_pages/cgpa/riverpod/cgpa_state.dart';

class CgpaProvider extends StateNotifier<CgpaState> {
  CgpaProvider() : super(CgpaInitial());

  void disposeState() => state = CgpaInitial();

  void _setLoading() => state = const CgpaLoading(
        successMessage: '',
        errorMessage: '',
        cgpaData: <CGPAData>[],
      );

  Future<void> getCgpaDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response = await HttpService.sendSoapRequest('getCGPA', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableCgpa(
        successMessage: '',
        errorMessage: '',
        cgpaData: state.cgpaData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRes = details['getCGPAResponse'] as Map<String, dynamic>;
      final returnData = hostelRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      var cgpaData = state.cgpaData;
      log('cgpaData >>>>>>>>$cgpaData');
//change model
      try {
        final cgpaDataResponse = CGPAModel.fromJson(decryptedData.mapData!);

        cgpaData = cgpaDataResponse.data!;
        state = state.copyWith(cgpaData: cgpaData);
        if (cgpaDataResponse.status == 'Success') {
          state = CgpaSuccessFull(
            successMessage: cgpaDataResponse.status!,
            errorMessage: '',
            cgpaData: state.cgpaData,
          );
        } else if (cgpaDataResponse.status != 'Success') {
          state = CgpaError(
            successMessage: '',
            errorMessage: cgpaDataResponse.status!,
            cgpaData: state.cgpaData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = CgpaError(
          successMessage: '',
          errorMessage: error.message!,
          cgpaData: state.cgpaData,
        );
      }
    } else if (response.$1 != 200) {
      state = CgpaError(
        successMessage: '',
        errorMessage: 'Error',
        cgpaData: state.cgpaData,
      );
    }
  }
}

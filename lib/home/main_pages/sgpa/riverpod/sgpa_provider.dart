import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/sgpa/model/sgpa_model.dart';
import 'package:sample/home/main_pages/sgpa/riverpod/sgpa_state.dart';

class SgpaProvider extends StateNotifier<SgpaState> {
  SgpaProvider() : super(SgpaInitial());

  void disposeState() => state = SgpaInitial();

  void _setLoading() => state = const SgpaLoading(
        successMessage: '',
        errorMessage: '',
        sgpaData: <SGPAData>[],
      );

  Future<void> getSgpaDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response = await HttpService.sendSoapRequest('getSGPA', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableSgpa(
        successMessage: '',
        errorMessage: '',
        sgpaData: state.sgpaData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRes = details['getSGPAResponse'] as Map<String, dynamic>;
      final returnData = hostelRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      var sgpaData = state.sgpaData;

      log('cgpaData >>>>>>>>$sgpaData');
//change model
      try {
        final sgpaDataResponse = SGPAModel.fromJson(decryptedData.mapData!);

        sgpaData = sgpaDataResponse.data!;
        state = state.copyWith(sgpaData: sgpaData);
        if (sgpaDataResponse.status == 'Success') {
          state = SgpaSuccessFull(
              successMessage: sgpaDataResponse.status!,
              errorMessage: '',
              sgpaData: state.sgpaData);
        } else if (sgpaDataResponse.status != 'Success') {
          state = SgpaError(
            successMessage: '',
            errorMessage: sgpaDataResponse.status!,
            sgpaData: state.sgpaData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = SgpaError(
          successMessage: '',
          errorMessage: error.message!,
          sgpaData: state.sgpaData,
        );
      }
    } else if (response.$1 != 200) {
      state = SgpaError(
        successMessage: '',
        errorMessage: 'Error',
        sgpaData: state.sgpaData,
      );
    }
  }
}

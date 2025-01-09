import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/cgpa/model/cgpa_model.dart';
import 'package:sample/home/main_pages/cgpa/riverpod/cgpa_state.dart';
import 'package:sample/home/main_pages/fees_due_home_page.dart/model/fees_due_home_page_model.dart';
import 'package:sample/home/main_pages/fees_due_home_page.dart/riverpod/fees_dhasboard_Page_state.dart';

class FeesDhasboardProvider extends StateNotifier<FeesDhasboardState> {
  FeesDhasboardProvider() : super(FeesDhasboardInitial());

  void disposeState() => state = FeesDhasboardInitial();

  void _setLoading() => state = const FeesDhasboardLoading(
        successMessage: '',
        errorMessage: '',
        feesDueDhasboardData: <FeesDueHomePageData>[],
      );

  Future<void> getFeesDhasboardDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getStudentHomePageFeeDue', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableFeesDhasboard(
        successMessage: '',
        errorMessage: '',
        feesDueDhasboardData: state.feesDueDhasboardData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRes =
          details['getStudentHomePageFeeDueResponse'] as Map<String, dynamic>;
      final returnData = hostelRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      var feesDueDhasboardData = state.feesDueDhasboardData;
      log('feesDueDhasboardData >>>>>>>>$feesDueDhasboardData');
//change model
      try {
        final feesDueDhasboardDataResponse =
            StudentHomePageFeeDueModel.fromJson(decryptedData.mapData!);

        feesDueDhasboardData = feesDueDhasboardDataResponse.data!;
        state = state.copyWith(feesDueDhasboardData: feesDueDhasboardData);
        if (feesDueDhasboardDataResponse.status == 'Success') {
          state = FeesDhasboardSuccessFull(
            successMessage: feesDueDhasboardDataResponse.status!,
            errorMessage: '',
            feesDueDhasboardData: state.feesDueDhasboardData,
          );
        } else if (feesDueDhasboardDataResponse.status != 'Success') {
          state = FeesDhasboardError(
            successMessage: '',
            errorMessage: feesDueDhasboardDataResponse.status!,
            feesDueDhasboardData: state.feesDueDhasboardData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = FeesDhasboardError(
          successMessage: '',
          errorMessage: error.message!,
          feesDueDhasboardData: state.feesDueDhasboardData,
        );
      }
    } else if (response.$1 != 200) {
      state = FeesDhasboardError(
        successMessage: '',
        errorMessage: 'Error',
        feesDueDhasboardData: state.feesDueDhasboardData,
      );
    }
  }
}

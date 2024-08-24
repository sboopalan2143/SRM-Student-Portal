import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/fees/Fees_model.dart/finance_response_model.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_state.dart';

class FeesProvider extends StateNotifier<FeesState> {
  FeesProvider() : super(FeesInitial());

  void disposeState() => state = FeesInitial();

  void _setLoading() => state = const FeesStateLoading(
        successMessage: '',
        errorMessage: '',
        navFeesString: '',
        financeData: <FinanceData>[],
      );

  Future<void> getFinanceDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>21f84947bd6aa060</deviceid><accesstoken>TR</accesstoken><androidversion>TR</androidversion><model>TR</model><sdkversion>TR</sdkversion><appversion>TR</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getFinanceDetails', data);
    if (response.$1 == 0) {
      state = const NoNetworkAvailableFees(
        successMessage: '',
        errorMessage: '',
        navFeesString: '',
        financeData: <FinanceData>[],
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final financeRes =
          details['getFinanceDetailsResponse'] as Map<String, dynamic>;
      final returnData = financeRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      log('decrypted>>>>>>>>$decryptedData');

      final listData = <FinanceData>[];
      try {
        final financeDataResponse =
            FinanceResponseModel.fromJson(decryptedData);
        listData.addAll(financeDataResponse.data!);
        state = state.copyWith(financeData: listData);
        if (financeDataResponse.status == 'Success') {
          state = FeesStateSuccessful(
            successMessage: financeDataResponse.message!,
            errorMessage: '',
            navFeesString: '',
            financeData: state.financeData,
          );
        } else if (financeDataResponse.status != 'Success') {
          state = FeesError(
            successMessage: '',
            errorMessage: financeDataResponse.message!,
            navFeesString: '',
            financeData: <FinanceData>[],
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData);
        state = FeesError(
          successMessage: '',
          errorMessage: error.message!,
          navFeesString: '',
          financeData: <FinanceData>[],
        );
      }
    } else if (response.$1 != 200) {
      state = const FeesError(
        successMessage: '',
        errorMessage: 'Error',
        navFeesString: '',
        financeData: <FinanceData>[],
      );
    }
  }

  void setFeesNavString(String text) {
    state = state.copyWith(
      navFeesString: text,
    );
  }
}

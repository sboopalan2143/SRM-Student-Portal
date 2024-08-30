import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/fees/model.dart/feespaidmodel.dart';
import 'package:sample/home/main_pages/fees/model.dart/finance_response_model.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_state.dart';

class FeesProvider extends StateNotifier<FeesState> {
  FeesProvider() : super(FeesInitial());

  void disposeState() => state = FeesInitial();

  void _setLoading() => state = FeesStateLoading(
        successMessage: '',
        errorMessage: '',
        navFeesString: state.navFeesString,
        financeData: <FinanceData>[],
        feespaidData: <FeesPaidData>[],
      );

  Future<void> getFinanceDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getFinanceDetails', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableFees(
        successMessage: '',
        errorMessage: '',
        navFeesString: state.navFeesString,
        financeData: <FinanceData>[],
        feespaidData: <FeesPaidData>[],
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
            navFeesString: state.navFeesString,
            financeData: state.financeData,
            feespaidData: state.feespaidData,
          );
        } else if (financeDataResponse.status != 'Success') {
          state = FeesError(
            successMessage: '',
            errorMessage: financeDataResponse.message!,
            navFeesString: state.navFeesString,
            financeData: <FinanceData>[],
            feespaidData: <FeesPaidData>[],
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData);
        state = FeesError(
          successMessage: '',
          errorMessage: error.message!,
          navFeesString: state.navFeesString,
          financeData: <FinanceData>[],
          feespaidData: <FeesPaidData>[],
        );
      }
    } else if (response.$1 != 200) {
      state = FeesError(
        successMessage: '',
        errorMessage: 'Error',
        navFeesString: state.navFeesString,
        financeData: <FinanceData>[],
        feespaidData: <FeesPaidData>[],
      );
    }
  }

  Future<void> getFeesPaidDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getFeePaidDetails', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableFees(
        successMessage: '',
        errorMessage: '',
        navFeesString: state.navFeesString,
        financeData: <FinanceData>[],
        feespaidData: state.feespaidData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final financeRes =
          details['getFeePaidDetailsResponse'] as Map<String, dynamic>;
      final returnData = financeRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      var feespaidData = state.feespaidData;
      log('decrypted>>>>>>>>$decryptedData');

      try {
        final fessPaidDataResponse = FeesPaidDetails.fromJson(decryptedData);
        feespaidData = fessPaidDataResponse.data!;
        state = state.copyWith(feespaidData: feespaidData);
        if (fessPaidDataResponse.status == 'Success') {
          state = FeesStateSuccessful(
            successMessage: fessPaidDataResponse.message!,
            errorMessage: '',
            navFeesString: state.navFeesString,
            financeData: state.financeData,
            feespaidData: state.feespaidData,
          );
        } else if (fessPaidDataResponse.status != 'Success') {
          state = FeesError(
            successMessage: '',
            errorMessage: fessPaidDataResponse.message!,
            navFeesString: state.navFeesString,
            financeData: <FinanceData>[],
            feespaidData: state.feespaidData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData);
        state = FeesError(
          successMessage: '',
          errorMessage: error.message!,
          navFeesString: state.navFeesString,
          financeData: <FinanceData>[],
          feespaidData: state.feespaidData,
        );
      }
    } else if (response.$1 != 200) {
      state = FeesError(
        successMessage: '',
        errorMessage: 'Error',
        navFeesString: state.navFeesString,
        financeData: <FinanceData>[],
        feespaidData: state.feespaidData,
      );
    }
  }

  void setFeesNavString(String text) {
    state = state.copyWith(
      navFeesString: text,
    );
  }
}

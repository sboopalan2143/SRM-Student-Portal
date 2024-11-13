import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/fees/model.dart/finance_response_hive_model.dart';
import 'package:sample/home/main_pages/fees/model.dart/get_fees_details_hive_model.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_state.dart';

class FeesProvider extends StateNotifier<FeesState> {
  FeesProvider() : super(FeesInitial());

  void disposeState() => state = FeesInitial();

  void _setLoading() => state = FeesStateLoading(
        successMessage: '',
        errorMessage: '',
        navFeesString: state.navFeesString,
        feesDetailsHiveData: <GetFeesHiveData>[],
        financeHiveData: <FinanceHiveData>[],
      );

  Future<void> getFinanceDetailsApi(EncryptionProvider encrypt) async {
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
        financeHiveData: <FinanceHiveData>[],
        feesDetailsHiveData: state.feesDetailsHiveData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final financeRes =
          details['getFinanceDetailsResponse'] as Map<String, dynamic>;
      final returnData = financeRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      if (decryptedData.mapData!['Status'] == 'Success') {
        // final listData = <FinanceData>[];
        final listData = decryptedData.mapData!['Data'] as List<dynamic>;

        if (listData.isNotEmpty) {
          // final financeData =
          //     FinanceResponseModel.fromJson(decryptedData.mapData!);
          // listData.addAll(financeDataResponse.data!);
          // state = state.copyWith(financeData: listData);

          final box = await Hive.openBox<FinanceHiveData>('financeDetailsList');

          if (box.isEmpty) {
            for (var i = 0; i < listData.length; i++) {
              final parseData = FinanceHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          } else {
            await box.clear();
            for (var i = 0; i < listData.length; i++) {
              final parseData = FinanceHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          }
          await box.close();
          state = FeesStateSuccessful(
            successMessage: '',
            errorMessage: '',
            navFeesString: state.navFeesString,
            feesDetailsHiveData: state.feesDetailsHiveData,
            financeHiveData: <FinanceHiveData>[],
          );
        } else {
          final error = ErrorModel.fromJson(decryptedData.mapData!);
          state = FeesError(
            successMessage: '',
            errorMessage: error.message!,
            navFeesString: state.navFeesString,
            financeHiveData: <FinanceHiveData>[],
            feesDetailsHiveData: state.feesDetailsHiveData,
          );
        }
      } else if (decryptedData.mapData!['Status'] != 'Success') {
        state = FeesError(
          successMessage: '',
          errorMessage:
              '''${decryptedData.mapData!['Status']}, ${decryptedData.mapData!['message']}''',
          navFeesString: state.navFeesString,
          financeHiveData: <FinanceHiveData>[],
          feesDetailsHiveData: state.feesDetailsHiveData,
        );
      }
    } else if (response.$1 != 200) {
      state = FeesError(
        successMessage: '',
        errorMessage: 'Error',
        navFeesString: state.navFeesString,
        financeHiveData: <FinanceHiveData>[],
        feesDetailsHiveData: state.feesDetailsHiveData,
      );
    }
  }

  Future<void> getHiveFinanceDetails(String search) async {
    try {
      _setLoading();
      final box = await Hive.openBox<FinanceHiveData>('financeDetailsList');
      final financeDetailsHive = <FinanceHiveData>[...box.values];

      state = state.copyWith(
        financeHiveData: financeDetailsHive,
      );
      await box.close();
    } catch (e) {
      await getHiveFinanceDetails(search);
    }
  }

  Future<void> getFeesDetailsApi(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response = await HttpService.sendSoapRequest('getFeeDetails', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableFees(
        successMessage: '',
        errorMessage: '',
        navFeesString: state.navFeesString,
        financeHiveData: state.financeHiveData,
        feesDetailsHiveData: state.feesDetailsHiveData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final financeRes =
          details['getFeeDetailsResponse'] as Map<String, dynamic>;
      final returnData = financeRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      // var feesDetailsHiveData = state.feesDetailsHiveData;
      if (decryptedData.mapData!['Status'] == 'Success') {
        final listData = decryptedData.mapData!['Data'] as List<dynamic>;

        if (listData.isNotEmpty) {
          // final feesDetailsHiveDataDataResponse =
          //     GetFeesDetailsModel.fromJson(decryptedData.mapData!);
          // feesDetailsHiveData = feesDetailsHiveDataDataResponse.data!;
          // state = state.copyWith(feesDetailsHiveData: feesDetailsHiveData);
          final box = await Hive.openBox<GetFeesHiveData>('feesDetails');
          if (box.isEmpty) {
            for (var i = 0; i < listData.length; i++) {
              final parseData = GetFeesHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );
              await box.add(parseData);
            }
          } else {
            await box.clear();
            for (var i = 0; i < listData.length; i++) {
              final parseData = GetFeesHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );
              await box.add(parseData);
            }
          }
          await box.close();

          state = FeesStateSuccessful(
            successMessage: decryptedData.mapData!['Status'] as String,
            errorMessage: '',
            navFeesString: state.navFeesString,
            financeHiveData: state.financeHiveData,
            feesDetailsHiveData: <GetFeesHiveData>[],
          );
        } else {
          final error = ErrorModel.fromJson(decryptedData.mapData!);
          state = FeesError(
            successMessage: '',
            errorMessage: error.message!,
            navFeesString: state.navFeesString,
            financeHiveData: state.financeHiveData,
            feesDetailsHiveData: <GetFeesHiveData>[],
          );
        }
      } else if (decryptedData.mapData!['Status'] != 'Success') {
        state = FeesError(
          successMessage: '',
          errorMessage:
              '''${decryptedData.mapData!['Status']}, ${decryptedData.mapData!['Message']}''',
          navFeesString: state.navFeesString,
          financeHiveData: state.financeHiveData,
          feesDetailsHiveData: <GetFeesHiveData>[],
        );
      }
    } else if (response.$1 != 200) {
      state = FeesError(
        successMessage: '',
        errorMessage: 'Error',
        navFeesString: state.navFeesString,
        financeHiveData: state.financeHiveData,
        feesDetailsHiveData: <GetFeesHiveData>[],
      );
    }
  }

  Future<void> getHiveFeesDetails(String search) async {
    try {
      _setLoading();
      final box = await Hive.openBox<GetFeesHiveData>('feesDetails');
      final feesDetailsHive = <GetFeesHiveData>[...box.values];

      state = state.copyWith(
        feesDetailsHiveData: feesDetailsHive,
      );
      await box.close();
    } catch (e) {
      await getHiveFeesDetails(search);
    }
  }

  void setFeesNavString(String text) {
    state = state.copyWith(
      navFeesString: text,
    );
  }
}

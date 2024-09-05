import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_category_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_subtype_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_type_model.dart';
import 'package:sample/home/main_pages/grievances/riverpod/grievance_state.dart';

class GrievanceProvider extends StateNotifier<GrievanceState> {
  GrievanceProvider() : super(GrievanceInitial());

  void disposeState() => state = GrievanceInitial();

  void _setLoading() => state = const GrievanceStateLoading(
        successMessage: '',
        errorMessage: '',
        grievanceCaregoryData: <GrievanceCategoryData>[],
        grievanceSubType: <GrievanceSubTypeData>[],
        grievanceType: <GrievanceData>[],
      );

  Future<void> getGrievanceCategoryDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getGrievanceCategory', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableGrievance(
        successMessage: '',
        errorMessage: '',
        grievanceCaregoryData: state.grievanceCaregoryData,
        grievanceSubType: state.grievanceSubType,
        grievanceType: state.grievanceType,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final grievanceCaregoryRes =
          details['getGrievanceCategoryResponse'] as Map<String, dynamic>;
      final returnData = grievanceCaregoryRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      var grievanceCaregoryData = state.grievanceCaregoryData;
      log('decrypted>>>>>>>>$decryptedData');

      try {
        final grievanceCaregoryDataResponse =
            GrievanceCategory.fromJson(decryptedData.mapData!);
        grievanceCaregoryData = grievanceCaregoryDataResponse.data!;
        state = state.copyWith(grievanceCaregoryData: grievanceCaregoryData);
        if (grievanceCaregoryDataResponse.status == 'Success') {
          state = GrievanceStateSuccessful(
            successMessage: grievanceCaregoryDataResponse.status!,
            errorMessage: '',
            grievanceCaregoryData: state.grievanceCaregoryData,
            grievanceSubType: state.grievanceSubType,
            grievanceType: state.grievanceType,
          );
        } else if (grievanceCaregoryDataResponse.status != 'Success') {
          state = GrievanceStateError(
            successMessage: '',
            errorMessage:
                '''${grievanceCaregoryDataResponse.status!}, ${grievanceCaregoryDataResponse.message!}''',
            grievanceCaregoryData: state.grievanceCaregoryData,
            grievanceSubType: state.grievanceSubType,
            grievanceType: state.grievanceType,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = GrievanceStateError(
          successMessage: '',
          errorMessage: error.message!,
          grievanceCaregoryData: state.grievanceCaregoryData,
          grievanceSubType: state.grievanceSubType,
          grievanceType: state.grievanceType,
        );
      }
    } else if (response.$1 != 200) {
      state = GrievanceStateError(
        successMessage: '',
        errorMessage: 'Error',
        grievanceCaregoryData: state.grievanceCaregoryData,
        grievanceSubType: state.grievanceSubType,
        grievanceType: state.grievanceType,
      );
    }
  }

  Future<void> getGrievanceSubTypeDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getGrievanceSubType', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableGrievance(
        successMessage: '',
        errorMessage: '',
        grievanceSubType: state.grievanceSubType,
        grievanceCaregoryData: state.grievanceCaregoryData,
        grievanceType: state.grievanceType,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final grievanceSubTypeRes =
          details['getGrievanceSubTypeResponse'] as Map<String, dynamic>;
      final returnData = grievanceSubTypeRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      var grievanceSubType = state.grievanceSubType;
      log('decrypted >>>>>>>>$decryptedData');

      try {
        final grievanceSubTypeCResponse =
            GrievanceSubTypeModel.fromJson(decryptedData.mapData!);
        grievanceSubType = grievanceSubTypeCResponse.data!;
        state = state.copyWith(grievanceSubType: grievanceSubType);
        if (grievanceSubTypeCResponse.status == 'Success') {
          state = GrievanceStateSuccessful(
            successMessage: grievanceSubTypeCResponse.status!,
            errorMessage: '',
            grievanceCaregoryData: state.grievanceCaregoryData,
            grievanceSubType: state.grievanceSubType,
            grievanceType: state.grievanceType,
          );
        } else if (grievanceSubTypeCResponse.status != 'Success') {
          state = GrievanceStateError(
            successMessage: '',
            errorMessage:
                '''${grievanceSubTypeCResponse.status!}, ${grievanceSubTypeCResponse.message!}''',
            grievanceCaregoryData: state.grievanceCaregoryData,
            grievanceSubType: state.grievanceSubType,
            grievanceType: state.grievanceType,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = GrievanceStateError(
          successMessage: '',
          errorMessage: error.message!,
          grievanceCaregoryData: state.grievanceCaregoryData,
          grievanceSubType: state.grievanceSubType,
          grievanceType: state.grievanceType,
        );
      }
    } else if (response.$1 != 200) {
      state = GrievanceStateError(
        successMessage: '',
        errorMessage: 'Error',
        grievanceCaregoryData: state.grievanceCaregoryData,
        grievanceSubType: state.grievanceSubType,
        grievanceType: state.grievanceType,
      );
    }
  }

  Future<void> getGrievanceTypeDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getGrievanceType', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableGrievance(
        successMessage: '',
        errorMessage: '',
        grievanceSubType: state.grievanceSubType,
        grievanceCaregoryData: state.grievanceCaregoryData,
        grievanceType: state.grievanceType,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final grievanceTypeRes =
          details['getGrievanceTypeResponse'] as Map<String, dynamic>;
      final returnData = grievanceTypeRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      var grievanceType = state.grievanceType;
      log('decrypted>>>>>>>>$decryptedData');

      try {
        final grievanceTypeCResponse =
            GrievanceTypeModel.fromJson(decryptedData.mapData!);
        grievanceType = grievanceTypeCResponse.data!;
        state = state.copyWith(grievanceType: grievanceType);
        if (grievanceTypeCResponse.status == 'Success') {
          state = GrievanceStateSuccessful(
            successMessage: grievanceTypeCResponse.status!,
            errorMessage: '',
            grievanceCaregoryData: state.grievanceCaregoryData,
            grievanceSubType: state.grievanceSubType,
            grievanceType: state.grievanceType,
          );
        } else if (grievanceTypeCResponse.status != 'Success') {
          state = GrievanceStateError(
            successMessage: '',
            errorMessage:
                '''${grievanceTypeCResponse.status!}, ${grievanceTypeCResponse.message!}''',
            grievanceCaregoryData: state.grievanceCaregoryData,
            grievanceSubType: state.grievanceSubType,
            grievanceType: state.grievanceType,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = GrievanceStateError(
          successMessage: '',
          errorMessage: error.message!,
          grievanceCaregoryData: state.grievanceCaregoryData,
          grievanceSubType: state.grievanceSubType,
          grievanceType: state.grievanceType,
        );
      }
    } else if (response.$1 != 200) {
      state = GrievanceStateError(
        successMessage: '',
        errorMessage: 'Error',
        grievanceCaregoryData: state.grievanceCaregoryData,
        grievanceSubType: state.grievanceSubType,
        grievanceType: state.grievanceType,
      );
    }
  }
}

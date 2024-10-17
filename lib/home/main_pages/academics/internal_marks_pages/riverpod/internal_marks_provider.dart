import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/academics/internal_marks_pages/model/internal_mark_hive_model.dart';
import 'package:sample/home/main_pages/academics/internal_marks_pages/model/internal_marks_model.dart';
import 'package:sample/home/main_pages/academics/internal_marks_pages/riverpod/internal_marks_state.dart';

class InternalMarksProvider extends StateNotifier<InternalMarksState> {
  InternalMarksProvider() : super(InternalMarksInitial());

  void disposeState() => state = InternalMarksInitial();

  void _setLoading() => state = InternalMarksState(
        successMessage: '',
        errorMessage: '',
        internalMarkData: <InternalMarkData>[],
        internalMarkHiveData: <InternalMarkHiveData>[],
      );

  Future<void> getInternalMarksDetails(
    EncryptionProvider encrypt,
  ) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getInternalMarkDetails', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableInternalMarks(
        successMessage: '',
        errorMessage: '',
        internalMarkData: state.internalMarkData,
        internalMarkHiveData: state.internalMarkHiveData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final internalMarksRes =
          details['getInternalMarkDetailsResponse'] as Map<String, dynamic>;
      final returnData = internalMarksRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      // var internalMarkData = state.internalMarkData;
      final internalMarkHiveData =
          decryptedData.mapData!['Data'] as List<dynamic>;
      log('decrypted>>>>>>>>$decryptedData');
      try {
        // final internalMarksDataResponse =
        //     GetInternalMarkDetails.fromJson(decryptedData.mapData!);
        // internalMarkData = internalMarksDataResponse.data!;
        // state = state.copyWith(internalMarkData: internalMarkData);

        for (var i = 0; i < internalMarkHiveData.length; i++) {
          final parseData = InternalMarkHiveData.fromJson(
              internalMarkHiveData[i] as Map<String, dynamic>);
          log('data>>>>${parseData.subjectcode}');
          final box = await Hive.openBox<InternalMarkHiveData>(
            'internakmarkdata',
          );
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
          state = InternalMarksStateSuccessful(
            successMessage: decryptedData.mapData!['Status']! as String,
            errorMessage: '',
            internalMarkData: state.internalMarkData,
            internalMarkHiveData: state.internalMarkHiveData,
          );
        } else if (decryptedData.mapData!['Status'] != 'Success') {
          state = InternalMarksStateError(
            successMessage: '',
            errorMessage:
                '''${decryptedData.mapData!['Status']!}, ${decryptedData.mapData!['Status']!}''',
            internalMarkData: state.internalMarkData,
            internalMarkHiveData: state.internalMarkHiveData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = InternalMarksStateError(
          successMessage: '',
          errorMessage: error.message!,
          internalMarkData: state.internalMarkData,
          internalMarkHiveData: state.internalMarkHiveData,
        );
      }
    } else if (response.$1 != 200) {
      state = InternalMarksStateError(
        successMessage: '',
        errorMessage: 'Error',
        internalMarkData: state.internalMarkData,
        internalMarkHiveData: state.internalMarkHiveData,
      );
    }
  }

  Future<void> getHiveinternalmark(String search) async {
    try {
      _setLoading();
      final box = await Hive.openBox<InternalMarkHiveData>(
        'internakmarkdata',
      );
      final internakmarkdata = <InternalMarkHiveData>[...box.values];
      log('profile length>>>${internakmarkdata[0].subjectcode}');

      state = InternalMarksStateSuccessful(
        successMessage: '',
        errorMessage: '',
        internalMarkData: state.internalMarkData,
        internalMarkHiveData: internakmarkdata,
      );
    } catch (e) {
      await getHiveinternalmark(search);
    }
  }
}

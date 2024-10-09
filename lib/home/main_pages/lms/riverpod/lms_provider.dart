import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_getSubject_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_gettitle_model.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';

class LmsProvider extends StateNotifier<LmsState> {
  LmsProvider() : super(LmsInitial());

  void disposeState() => state = LmsInitial();

  void _setLoading() => state = const LmsStateLoading(
        successMessage: '',
        errorMessage: '',
        lmsSubjectData: <LmsSubjectData>[],
        lmsTitleData: <LmsGetTitleData>[],
      );

  void clearstate() => state = const LmsStateclear(
        successMessage: '',
        errorMessage: '',
        lmsSubjectData: <LmsSubjectData>[],
        lmsTitleData: <LmsGetTitleData>[],
      );

  Future<void> getLmsSubgetDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response = await HttpService.sendSoapRequest('getSubject', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableLmsMember(
          successMessage: '',
          errorMessage: '',
          lmsSubjectData: state.lmsSubjectData,
          lmsTitleData: state.lmsTitleData);
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final libraryMemberRes =
          details['getSubjectResponse'] as Map<String, dynamic>;
      final returnData = libraryMemberRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      var lmsSubjectData = state.lmsSubjectData;
      log('decrypted>>>>>>>>$decryptedData');

      try {
        final lmsSubjectDataResponse =
            GetSubjectModel.fromJson(decryptedData.mapData!);
        lmsSubjectData = lmsSubjectDataResponse.data!;
        state = state.copyWith(lmsSubjectData: lmsSubjectData);
        if (lmsSubjectDataResponse.status == 'Success') {
          // state = LibraryTrancsactionStateSuccessful(
          //   successMessage: libraryTransactionDataResponse.status!,
          //   errorMessage: '',
          //   libraryTransactionData: state.libraryTransactionData,
          //   studentId: TextEditingController(),
          //   officeid: TextEditingController(),
          //   filter: TextEditingController(),
          // );
        } else if (lmsSubjectDataResponse.status != 'Success') {
          state = LmsStateError(
              successMessage: '',
              errorMessage:
                  '''${lmsSubjectDataResponse.status!}, ${lmsSubjectDataResponse.message!}''',
              lmsSubjectData: state.lmsSubjectData,
              lmsTitleData: state.lmsTitleData);
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = LmsStateError(
            successMessage: '',
            errorMessage: error.message!,
            lmsSubjectData: state.lmsSubjectData,
            lmsTitleData: state.lmsTitleData);
      }
    } else if (response.$1 != 200) {
      state = LmsStateError(
          successMessage: '',
          errorMessage: 'Error',
          lmsSubjectData: state.lmsSubjectData,
          lmsTitleData: state.lmsTitleData);
    }
  }

  Future<void> getLmsTitleDetails(
    EncryptionProvider encrypt,
    String subjectId,
  ) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><subjectid>$subjectId</subjectid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response = await HttpService.sendSoapRequest('getTitles', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableLmsMember(
        successMessage: '',
        errorMessage: '',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final lmsTitleRes = details['getTitlesResponse'] as Map<String, dynamic>;
      final returnData = lmsTitleRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      var lmsTitleData = state.lmsTitleData;
      log('decrypted>>>>>>>>$decryptedData');

      try {
        final lmsTitleDataResponse =
            GetTitleListModel.fromJson(decryptedData.mapData!);
        lmsTitleData = lmsTitleDataResponse.data!;
        state = state.copyWith(lmsTitleData: lmsTitleData);
        if (lmsTitleDataResponse.status == 'Success') {
          // state = LibraryTrancsactionStateSuccessful(
          //   successMessage: libraryTransactionDataResponse.status!,
          //   errorMessage: '',
          //   libraryTransactionData: state.libraryTransactionData,
          //   studentId: TextEditingController(),
          //   officeid: TextEditingController(),
          //   filter: TextEditingController(),
          // );
        } else if (lmsTitleDataResponse.status != 'Success') {
          state = LmsStateError(
            successMessage: '',
            errorMessage:
                '''${lmsTitleDataResponse.status!}, ${lmsTitleDataResponse.message!}''',
            lmsSubjectData: state.lmsSubjectData,
            lmsTitleData: state.lmsTitleData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = LmsStateError(
          successMessage: '',
          errorMessage: error.message!,
          lmsSubjectData: state.lmsSubjectData,
          lmsTitleData: state.lmsTitleData,
        );
      }
    } else if (response.$1 != 200) {
      state = LmsStateError(
        successMessage: '',
        errorMessage: 'Error',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
      );
    }
  }
}

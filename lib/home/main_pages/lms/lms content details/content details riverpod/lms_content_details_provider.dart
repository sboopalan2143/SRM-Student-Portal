import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/cgpa/model/cgpa_model.dart';
import 'package:sample/home/main_pages/cgpa/riverpod/cgpa_state.dart';
import 'package:sample/home/main_pages/lms/lms%20content%20details/content%20detail%20model/lms_content_details_model.dart';
import 'package:sample/home/main_pages/lms/lms%20content%20details/content%20details%20riverpod/lms_content_details_state.dart';

class LmsContentDetailsProvider extends StateNotifier<LmsContentDetailsState> {
  LmsContentDetailsProvider() : super(LmsContentDetailsInitial());

  void disposeState() => state = LmsContentDetailsInitial();

  void _setLoading() => state = const LmsContentdetailsLoading(
        successMessage: '',
        errorMessage: '',
        lmsContentData: <LmsContentDetailsData>[],
      );

  Future<void> getLmsContentDetails(
    EncryptionProvider encrypt,
    String subjectid,
  ) async {
    log('<subjectid>$subjectid</subjectid>');
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><subjectid>$subjectid</subjectid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response = await HttpService.sendSoapRequest('getLMSContentDetails', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableLmsContentDetails(
        successMessage: '',
        errorMessage: '',
        lmsContentData: state.lmsContentData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRes = details['getLMSContentDetailsResponse'] as Map<String, dynamic>;
      final returnData = hostelRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      var lmsContentData = state.lmsContentData;
      log('lmsContentData >>>>>>>>${decryptedData.mapData}');
//change model
      try {
        final lmsContentDataResponse = LmsContentDetailsModel.fromJson(decryptedData.mapData!);

        lmsContentData = lmsContentDataResponse.data!;
        state = state.copyWith(lmsContentData: lmsContentData);
        if (lmsContentDataResponse.status == 'Success') {
          state = LmsContentDetailsSuccessFull(
            successMessage: lmsContentDataResponse.status!,
            errorMessage: '',
            lmsContentData: state.lmsContentData,
          );
        } else if (lmsContentDataResponse.status != 'Success') {
          state = LmsContentDetailsError(
            successMessage: '',
            errorMessage: lmsContentDataResponse.status!,
            lmsContentData: state.lmsContentData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = LmsContentDetailsError(
          successMessage: '',
          errorMessage: error.message!,
          lmsContentData: state.lmsContentData,
        );
      }
    } else if (response.$1 != 200) {
      state = LmsContentDetailsError(
        successMessage: '',
        errorMessage: 'Error',
        lmsContentData: state.lmsContentData,
      );
    }
  }
}

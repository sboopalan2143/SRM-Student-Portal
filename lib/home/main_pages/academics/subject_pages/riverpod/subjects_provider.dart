import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/academics/subject_pages/model/subject_response_model.dart';
import 'package:sample/home/main_pages/academics/subject_pages/riverpod/subjects_state.dart';

class SubjectProvider extends StateNotifier<SubjectState> {
  SubjectProvider() : super(SubjectInitial());

  void disposeState() => state = SubjectInitial();

  void _setLoading() => state = const SubjectStateLoading(
        successMessage: '',
        errorMessage: '',
        subjectData: <dynamic>[],
      );

  List<dynamic> splitString(String dataToSplit) {
    final data = dataToSplit;
    final splitList = data.split('##');
    return splitList;
  }

  Future<void> getSubjectDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response = await HttpService.sendSoapRequest('getSubjects', data);
    if (response.$1 == 0) {
      log('test subject >> <studentid>${TokensManagement.studentId}</studentid><deviceid>21f84947bd6aa060</deviceid><accesstoken>TR</accesstoken><androidversion>TR</androidversion><model>TR</model><sdkversion>TR</sdkversion><appversion>TR</appversion>');
      state = const NoNetworkAvailableSubject(
        successMessage: '',
        errorMessage: '',
        subjectData: <dynamic>[],
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final subjectRes = details['getSubjectsResponse'] as Map<String, dynamic>;
      final returnData = subjectRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      log('decrypted>>>>>>>>$decryptedData');

      final listData = <dynamic>[];
      try {
        final subjectDataResponse =
            SubjectResponseModel.fromJson(decryptedData.mapData!);
        // subjectDetails = subjectDataResponse.data!;

        if (subjectDataResponse.status == 'Success') {
          log('singledata>>>>${subjectDataResponse.data![0].subjectdetails}');
          for (var i = 0; i < subjectDataResponse.data!.length; i++) {
            final finalData =
                splitString('${subjectDataResponse.data![i].subjectdetails}');
            listData.add(finalData);
          }
          log('data>>>>>>>>$listData');
          state = state.copyWith(subjectData: listData);

          state = SubjectStateSuccessful(
            successMessage: subjectDataResponse.status!,
            errorMessage: '',
            subjectData: state.subjectData,
          );
        } else if (subjectDataResponse.status != 'Success') {
          state = SubjectStateError(
            successMessage: '',
            errorMessage:
                '''${subjectDataResponse.status!}, ${subjectDataResponse.message!}''',
            subjectData: <dynamic>[],
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = SubjectStateError(
          successMessage: '',
          errorMessage: error.message!,
          subjectData: <dynamic>[],
        );
      }
    } else if (response.$1 != 200) {
      state = const SubjectStateError(
        successMessage: '',
        errorMessage: 'Error',
        subjectData: <dynamic>[],
      );
    }
  }
}

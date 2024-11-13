import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/academics/subject_pages/model/subject_responce_hive_model.dart';
import 'package:sample/home/main_pages/academics/subject_pages/riverpod/subjects_state.dart';

class SubjectProvider extends StateNotifier<SubjectState> {
  SubjectProvider() : super(SubjectInitial());

  void disposeState() => state = SubjectInitial();

  void _setLoading() => state = const SubjectStateLoading(
        successMessage: '',
        errorMessage: '',
        subjectHiveData: <SubjectHiveData>[],
      );

  // List<dynamic> splitString(String dataToSplit) {
  //   final data = dataToSplit;
  //   final splitList = data.split('##');
  //   return splitList;
  // }

  Future<void> getSubjectDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response = await HttpService.sendSoapRequest('getSubjects', data);
    if (response.$1 == 0) {
      state = const NoNetworkAvailableSubject(
        successMessage: '',
        errorMessage: '',
        subjectHiveData: <SubjectHiveData>[],
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final subjectRes = details['getSubjectsResponse'] as Map<String, dynamic>;
      final returnData = subjectRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      if (decryptedData.mapData!['Status'] == 'Success') {
        // final listData = <dynamic>[];
        final listData = decryptedData.mapData!['Data'] as List<dynamic>;

        if (listData.isNotEmpty) {
          // final subjectDataResponse =
          //       SubjectResponseModel.fromJson(decryptedData.mapData!);
          //   // subjectDetails = subjectDataResponse.data!;
          //   if (subjectDataResponse.status == 'Success') {
          //     log('singledata>>>>${subjectDataResponse.data![0].subjectdetails}');
          //     for (var i = 0; i < subjectDataResponse.data!.length; i++) {
          //       final finalData =
          //           splitString('${subjectDataResponse.data![i].subjectdetails}');
          //       listData.add(finalData);
          final box = await Hive.openBox<SubjectHiveData>('subjecthive');
          if (box.isEmpty) {
            for (var i = 0; i < listData.length; i++) {
              final parseData = SubjectHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          } else {
            await box.clear();
            for (var i = 0; i < listData.length; i++) {
              final parseData = SubjectHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          }

          await box.close();

          //  for (var i = 0; i < SubjectResponseModel..length; i++)
          state = SubjectStateSuccessful(
            successMessage: decryptedData.mapData!['Message'] as String,
            errorMessage: '',
            subjectHiveData: state.subjectHiveData,
          );
        } else if (decryptedData.mapData!['Status'] != 'Success') {
          state = SubjectStateError(
            successMessage: '',
            errorMessage:
                '''${decryptedData.mapData!['Status']}, ${decryptedData.mapData!['Status']}''',
            subjectHiveData: <SubjectHiveData>[],
          );
        }
      } else {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = SubjectStateError(
          successMessage: '',
          errorMessage: '$error',
          subjectHiveData: <SubjectHiveData>[],
        );
      }
    } else if (response.$1 != 200) {
      state = const SubjectStateError(
        successMessage: '',
        errorMessage: '',
        subjectHiveData: <SubjectHiveData>[],
      );
    }
  }

  Future<void> getHiveSubjectDetails(String search) async {
    try {
      _setLoading();
      final box = await Hive.openBox<SubjectHiveData>(
        'subjecthive',
      );
      final subjecthivedata = <SubjectHiveData>[...box.values];
      state = state.copyWith(
        subjectHiveData: subjecthivedata,
      );
    } catch (e) {
      await getHiveSubjectDetails(search);
    }
  }
}

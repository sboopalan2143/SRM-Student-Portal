import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/academics/subject_pages/model/subject_response_model.dart';
import 'package:sample/home/main_pages/academics/subject_pages/riverpod/subjects_state.dart';

import '../model/subject_responce_hive_model.dart';

class SubjectProvider extends StateNotifier<SubjectState> {
  SubjectProvider() : super(SubjectInitial());

  void disposeState() => state = SubjectInitial();

  void _setLoading() => state = const SubjectStateLoading(
        successMessage: '',
        errorMessage: '',
        subjectData: <dynamic>[],
        subjectHiveData: <SubjectHiveData>[],
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
        subjectHiveData: <SubjectHiveData>[],
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
        // final subjectDataResponse =
        //     SubjectResponseModel.fromJson(decryptedData.mapData!);
        // // subjectDetails = subjectDataResponse.data!;
        for (var i = 0; i < listData.length; i++) {
          final parseData =
              SubjectHiveData.fromJson(listData[i] as Map<String, dynamic>);
          log('data>>>>${parseData.subjectdetails}');
          final box = await Hive.openBox<SubjectHiveData>(
            'cumulativeattendance',
          );
          final index = box.values
              .toList()
              .indexWhere((e) => e.subjectdetails == parseData.subjectdetails);
          if (index != -1) {
            await box.putAt(index, parseData);
          } else {
            await box.add(parseData);
          }
        }

        if (decryptedData.mapData!['Status'] == 'Success') {
          // log('singledata>>>>${subjectDataResponse.data![0].subjectdetails}');
          // for (var i = 0; i < subjectDataResponse.data!.length; i++) {
          //   final finalData =
          //       splitString('${subjectDataResponse.data![i].subjectdetails}');
          //   listData.add(finalData);
          // }
          // log('data>>>>>>>>$listData');
          // state = state.copyWith(subjectData: listData);

          // state = SubjectStateSuccessful(
          //   successMessage: subjectDataResponse.status!,
          //   errorMessage: '',
          //   subjectData: state.subjectData,
          // );
          state = SubjectStateSuccessful(
            successMessage: decryptedData.mapData!['Message'] as String,
            errorMessage: '',
            subjectData: state.subjectData,
          );
        } else if (decryptedData.mapData!['Status'] != 'Success') {
          state = SubjectStateError(
            successMessage: '',
            errorMessage:
                '''${decryptedData.mapData!['Status']}, ${decryptedData.mapData!['Status']}''',
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

  Future<void> getHiveSubgetDetails(String search) async {
    try {
      _setLoading();
      final box = await Hive.openBox<SubjectHiveData>(
        'cumulativeattendance',
      );
      final profile = <SubjectHiveData>[...box.values];
      log('profile length>>>${profile[0].subjectdetails}');
      state = SubjectStateError(
        successMessage: '',
        errorMessage: error.message!,
        subjectData: <dynamic>[],
      );
    } catch (e) {
      await getHiveSubgetDetails(search);
    }
  }
}

import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/calendar/model/timetable_model.dart';
import 'package:sample/home/main_pages/calendar/riverpod/time_table_state.dart';
import 'package:sample/home/main_pages/cgpa/model/cgpa_model.dart';
import 'package:sample/home/main_pages/cgpa/riverpod/cgpa_state.dart';

class TimetableProvider extends StateNotifier<TimeTableState> {
  TimetableProvider() : super(TimetableInitial());

  void disposeState() => state = TimetableInitial();

  void _setLoading() => state = const TimetableLoading(
        successMessage: '',
        errorMessage: '',
        timeTableData: <TimeTableData>[],
      );

  Future<void> getTimeTableDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getTimeTableSubjectsList', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableTimetable(
        successMessage: '',
        errorMessage: '',
        timeTableData: state.timeTableData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRes =
          details['getTimeTableSubjectsListResponse'] as Map<String, dynamic>;
      final returnData = hostelRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      var timeTableData = state.timeTableData;
      log('timeTableData >>>>>>>>$timeTableData');
//change model
      try {
        final timeTableDataResponse =
            TimeTableSubjectListModel.fromJson(decryptedData.mapData!);

        timeTableData = timeTableDataResponse.data!;
        state = state.copyWith(timeTableData: timeTableData);
        if (timeTableDataResponse.status == 'Success') {
          state = TimetableSuccessFull(
            successMessage: timeTableDataResponse.status!,
            errorMessage: '',
            timeTableData: state.timeTableData,
          );
        } else if (timeTableDataResponse.status != 'Success') {
          state = TimetableError(
            successMessage: '',
            errorMessage: timeTableDataResponse.status!,
            timeTableData: state.timeTableData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = TimetableError(
          successMessage: '',
          errorMessage: error.message!,
          timeTableData: state.timeTableData,
        );
      }
    } else if (response.$1 != 200) {
      state = TimetableError(
        successMessage: '',
        errorMessage: 'Error',
        timeTableData: state.timeTableData,
      );
    }
  }
}

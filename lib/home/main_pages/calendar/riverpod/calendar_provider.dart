import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/home/main_pages/calendar/model/calendar_hive_model.dart';
import 'package:sample/home/main_pages/calendar/riverpod/calendar_state.dart';

class CalendarProvider extends StateNotifier<CalendarState> {
  CalendarProvider() : super(CalendarInitial());

  void disposeState() => state = CalendarInitial();

  void _setLoading() => state = const CalendarStateLoading(
        successMessage: '',
        errorMessage: '',
        calendarHiveData: <CalendarHiveModelData>[],
      );

  // Future<void> getCalendarDetails(EncryptionProvider encrypt) async {
  //   _setLoading();
  //   final data = encrypt.getEncryptedData(
  //     '<studentid>${TokensManagement.studentId}</studentid><officeid>${TokensManagement.officeId}</officeid>',
  //   );
  //   log(
  //     'calendar log >>>> <studentid>${TokensManagement.studentId}</studentid><officeid>${TokensManagement.officeId}</officeid>',
  //   );
  //   final response = await HttpService.sendSoapRequest(
  //     'getAcademyCalenderEntryDetails',
  //     data,
  //   );
  //   if (response.$1 == 0) {
  //     state = const NoNetworkAvailableCalendar(
  //       successMessage: '',
  //       errorMessage: '',
  //       calendarHiveData: <CalendarHiveModelData>[],
  //     );
  //   } else if (response.$1 == 200) {
  //     final details = response.$2['Body'] as Map<String, dynamic>;
  //     final financeRes = details['getAcademyCalenderEntryDetailsResponse']
  //         as Map<String, dynamic>;
  //     final returnData = financeRes['return'] as Map<String, dynamic>;
  //     final data = returnData['#text'];
  //     final decryptedData = encrypt.getDecryptedData('$data');
  //     log('decrypted >>>>>>>> ${decryptedData.mapData}');

  //     final calendarData = <CalendarData>[];
  //     // try {
  //     final calendarDataResponse =
  //         CalenderModelData.fromJson(decryptedData.mapData!);
  //     calendarData.addAll(calendarDataResponse.data!);
  //     state = state.copyWith(calendarData: calendarData);
  //     if (calendarDataResponse.status == 'Success') {
  //       state = CalendarStateSuccessful(
  //         successMessage: calendarDataResponse.status!,
  //         errorMessage: '',
  //         calendarData: state.calendarData,
  //       );
  //     } else if (calendarDataResponse.status != 'Success') {
  //       state = CalendarError(
  //         successMessage: '',
  //         errorMessage:
  //             '''${calendarDataResponse.status!}, ${calendarDataResponse.message!}''',
  //         calendarHiveData: <CalendarHiveModelData>[],
  //       );
  //     }
  //     // }
  //     //  catch (e) {
  //     //   final error = ErrorModel.fromJson(decryptedData.mapData!);
  //     //   state = CalendarError(
  //     //     successMessage: '',
  //     //     errorMessage: error.message!,
  //     //     calendarData: <CalendarData>[],
  //     //   );
  //     // }
  //   } else if (response.$1 != 200) {
  //     state = const CalendarError(
  //       successMessage: '',
  //       errorMessage: 'Error',
  //       calendarHiveData: <CalendarHiveModelData>[],
  //     );
  //   }
  // }

  Future<void> getCalendarDetails(
    EncryptionProvider encrypt,
  ) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><officeid>${TokensManagement.officeId}</officeid>',
    );
   
    final response = await HttpService.sendSoapRequest(
      'getAcademyCalenderEntryDetails',
      data,
    );
    if (response.$1 == 0) {
      state = const NoNetworkAvailableCalendar(
        successMessage: '',
        errorMessage: '',
        calendarHiveData: <CalendarHiveModelData>[],
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final financeRes = details['getAcademyCalenderEntryDetailsResponse']
          as Map<String, dynamic>;
      final returnData = financeRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      final calendarData = decryptedData.mapData!['Data'] as List<dynamic>;

      final box = await Hive.openBox<CalendarHiveModelData>('examDetails');
      if (box.isEmpty) {
        for (var i = 0; i < calendarData.length; i++) {
          final parseData = CalendarHiveModelData.fromJson(
            calendarData[i] as Map<String, dynamic>,
          );

          await box.add(parseData);
        }
      } else {
        await box.clear();
        for (var i = 0; i < calendarData.length; i++) {
          final parseData = CalendarHiveModelData.fromJson(
            calendarData[i] as Map<String, dynamic>,
          );

          await box.add(parseData);
        }
      }
      await box.close();
      if (decryptedData.mapData!['Status'] == 'Success') {
        state = CalendarSuccessFull(
          successMessage: decryptedData.mapData!['Message'] as String,
          errorMessage: '',
          calendarHiveData: <CalendarHiveModelData>[],
        );
      } else if (decryptedData.mapData!['Status'] != 'Success') {
        state = CalendarError(
          successMessage: '',
          errorMessage: decryptedData.mapData!['Message'] as String,
          calendarHiveData: <CalendarHiveModelData>[],
        );
      }
    } else if (response.$1 != 200) {
      state = const CalendarError(
        successMessage: '',
        errorMessage: 'Error',
        calendarHiveData: <CalendarHiveModelData>[],
      );
    }
  }

  Future<void> getHiveCalendar(String search) async {
    try {
      final box = await Hive.openBox<CalendarHiveModelData>('examDetails');
      final calendarDetailsHive = <CalendarHiveModelData>[...box.values];

      state = state.copyWith(
        calendarHiveData: calendarDetailsHive,
      );
      await box.close();
    } catch (e) {
      await getHiveCalendar(search);
    }
  }
}

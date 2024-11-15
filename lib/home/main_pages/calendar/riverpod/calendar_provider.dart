import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
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
        errorMessage: 'No Network. Connect to Internet',
        calendarHiveData: <CalendarHiveModelData>[],
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final financeRes = details['getAcademyCalenderEntryDetailsResponse']
          as Map<String, dynamic>;
      final returnData = financeRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      if (decryptedData.mapData!['Status'] == 'Success') {
        final listData = decryptedData.mapData!['Data'] as List<dynamic>;
        if (listData.isNotEmpty) {
          final box =
              await Hive.openBox<CalendarHiveModelData>('calendardetail');
          if (box.isEmpty) {
            for (var i = 0; i < listData.length; i++) {
              final parseData = CalendarHiveModelData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          } else {
            await box.clear();
            for (var i = 0; i < listData.length; i++) {
              final parseData = CalendarHiveModelData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          }
          await box.close();
        } else {
          final error = ErrorModel.fromJson(decryptedData.mapData!);
          state = CalendarError(
            successMessage: '',
            errorMessage: '$error',
            calendarHiveData: <CalendarHiveModelData>[],
          );
        }
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
      final box = await Hive.openBox<CalendarHiveModelData>('calendardetail');
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

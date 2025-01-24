import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/calendar/model/calendar_hive_model.dart';
import 'package:sample/home/main_pages/calendar/riverpod/calendar_provider.dart';

final calendarProvider =
    StateNotifierProvider<CalendarProvider, CalendarState>((ref) {
  return CalendarProvider();
});

class CalendarState {
  const CalendarState({
    required this.successMessage,
    required this.errorMessage,
    required this.calendarHiveData,
    required this.calendarCurrentDateData,
  });

  final String successMessage;
  final String errorMessage;
  final List<CalendarHiveModelData> calendarHiveData;
  final List<CalendarHiveModelData> calendarCurrentDateData;

  CalendarState copyWith({
    String? successMessage,
    String? errorMessage,
    List<CalendarHiveModelData>? calendarHiveData,
    List<CalendarHiveModelData>? calendarCurrentDateData,
  }) =>
      CalendarState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        calendarHiveData: calendarHiveData ?? this.calendarHiveData,
        calendarCurrentDateData:
            calendarCurrentDateData ?? this.calendarCurrentDateData,
      );
}

class CalendarInitial extends CalendarState {
  CalendarInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          calendarHiveData: <CalendarHiveModelData>[],
          calendarCurrentDateData: <CalendarHiveModelData>[],
        );
}

class CalendarStateLoading extends CalendarState {
  const CalendarStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.calendarHiveData,
    required super.calendarCurrentDateData,
  });
}

class CalendarSuccessFull extends CalendarState {
  const CalendarSuccessFull({
    required super.successMessage,
    required super.errorMessage,
    required super.calendarHiveData,
    required super.calendarCurrentDateData,
  });
}

class CalendarError extends CalendarState {
  const CalendarError({
    required super.successMessage,
    required super.errorMessage,
    required super.calendarHiveData,
    required super.calendarCurrentDateData,
  });
}

class CalendarStateSuccessful extends CalendarState {
  const CalendarStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.calendarHiveData,
    required super.calendarCurrentDateData,
  });
}

class NoNetworkAvailableCalendar extends CalendarState {
  const NoNetworkAvailableCalendar({
    required super.successMessage,
    required super.errorMessage,
    required super.calendarHiveData,
    required super.calendarCurrentDateData,
  });
}

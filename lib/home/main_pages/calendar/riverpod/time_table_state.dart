import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/calendar/model/timetable_model.dart';
import 'package:sample/home/main_pages/calendar/riverpod/time_table_provider.dart';
import 'package:sample/home/main_pages/cgpa/model/cgpa_model.dart';
import 'package:sample/home/main_pages/cgpa/riverpod/cgpa_provider.dart';

final timetableProvider =
    StateNotifierProvider<TimetableProvider, TimeTableState>((ref) {
  return TimetableProvider();
});

class TimeTableState {
  const TimeTableState({
    required this.successMessage,
    required this.errorMessage,
    required this.timeTableData,
  });

  final String successMessage;
  final String errorMessage;
  final List<TimeTableData> timeTableData;

  TimeTableState copyWith({
    String? successMessage,
    String? errorMessage,
    String? navNotificationString,
    List<TimeTableData>? timeTableData,
  }) =>
      TimeTableState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        timeTableData: timeTableData ?? this.timeTableData,
      );
}

class TimetableInitial extends TimeTableState {
  TimetableInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          timeTableData: <TimeTableData>[],
        );
}

class TimetableLoading extends TimeTableState {
  const TimetableLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.timeTableData,
  });
}

class TimetableSuccessFull extends TimeTableState {
  const TimetableSuccessFull({
    required super.successMessage,
    required super.errorMessage,
    required super.timeTableData,
  });
}

class TimetableError extends TimeTableState {
  const TimetableError({
    required super.successMessage,
    required super.errorMessage,
    required super.timeTableData,
  });
}

class NoNetworkAvailableTimetable extends TimeTableState {
  const NoNetworkAvailableTimetable({
    required super.successMessage,
    required super.errorMessage,
    required super.timeTableData,
  });
}

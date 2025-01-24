import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/model/attendance_hive.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/riverpod/attendance_provider.dart';
import 'package:sample/home/main_pages/academics/overall_attendance_page/model/overall_attendance_model.dart';
import 'package:sample/home/main_pages/academics/overall_attendance_page/riverpod/overall_attendanfe_provider.dart';

final overallattendanceProvider =
    StateNotifierProvider<OverallAttendanceProvider, OverallAttendanceState>(
        (ref) {
  return OverallAttendanceProvider();
});

class OverallAttendanceState {
  const OverallAttendanceState({
    required this.successMessage,
    required this.errorMessage,
    required this.OverallattendanceData,
  });

  final String successMessage;
  final String errorMessage;

  final List<SubjectOverallAttendanceData> OverallattendanceData;

  OverallAttendanceState copyWith({
    String? successMessage,
    String? errorMessage,
    List<SubjectOverallAttendanceData>? OverallattendanceData,
  }) =>
      OverallAttendanceState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        OverallattendanceData:
            OverallattendanceData ?? this.OverallattendanceData,
      );
}

class OverallAttendanceInitial extends OverallAttendanceState {
  OverallAttendanceInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          OverallattendanceData: <SubjectOverallAttendanceData>[],
        );
}

class OverallAttendanceStateLoading extends OverallAttendanceState {
  OverallAttendanceStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.OverallattendanceData,
  });
}

class OverallAttendanceStateError extends OverallAttendanceState {
  const OverallAttendanceStateError({
    required super.successMessage,
    required super.errorMessage,
    required super.OverallattendanceData,
  });
}

class OverallAttendanceStateSuccessful extends OverallAttendanceState {
  const OverallAttendanceStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.OverallattendanceData,
  });
}

class NoNetworkAvailableOverallAttendance extends OverallAttendanceState {
  const NoNetworkAvailableOverallAttendance({
    required super.successMessage,
    required super.errorMessage,
    required super.OverallattendanceData,
  });
}

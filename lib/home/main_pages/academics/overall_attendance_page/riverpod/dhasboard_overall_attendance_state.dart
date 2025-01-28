import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/model/attendance_hive.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/riverpod/attendance_provider.dart';
import 'package:sample/home/main_pages/academics/overall_attendance_page/model/dhasboard_overall_attendance_model.dart';
import 'package:sample/home/main_pages/academics/overall_attendance_page/model/overall_attendance_model.dart';
import 'package:sample/home/main_pages/academics/overall_attendance_page/riverpod/dhasboard_overall_attendance_provider.dart';
import 'package:sample/home/main_pages/academics/overall_attendance_page/riverpod/overall_attendanfe_provider.dart';

final DhasboardoverallattendanceProvider = StateNotifierProvider<
    DhasboardOverallAttendanceProvider, DhasboardOverallAttendanceState>((ref) {
  return DhasboardOverallAttendanceProvider();
});

class DhasboardOverallAttendanceState {
  const DhasboardOverallAttendanceState({
    required this.successMessage,
    required this.errorMessage,
    required this.DhasboardOverallattendanceData,
  });

  final String successMessage;
  final String errorMessage;

  final List<DhasboardOverallAttendanceData> DhasboardOverallattendanceData;

  DhasboardOverallAttendanceState copyWith({
    String? successMessage,
    String? errorMessage,
    List<DhasboardOverallAttendanceData>? DhasboardOverallattendanceData,
  }) =>
      DhasboardOverallAttendanceState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        DhasboardOverallattendanceData: DhasboardOverallattendanceData ??
            this.DhasboardOverallattendanceData,
      );
}

class DhasboardOverallAttendanceInitial
    extends DhasboardOverallAttendanceState {
  DhasboardOverallAttendanceInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          DhasboardOverallattendanceData: <DhasboardOverallAttendanceData>[],
        );
}

class DhasboardOverallAttendanceStateLoading
    extends DhasboardOverallAttendanceState {
  DhasboardOverallAttendanceStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.DhasboardOverallattendanceData,
  });
}

class DhasboardOverallAttendanceStateError
    extends DhasboardOverallAttendanceState {
  const DhasboardOverallAttendanceStateError({
    required super.successMessage,
    required super.errorMessage,
    required super.DhasboardOverallattendanceData,
  });
}

class DhasboardOverallAttendanceStateSuccessful
    extends DhasboardOverallAttendanceState {
  const DhasboardOverallAttendanceStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.DhasboardOverallattendanceData,
  });
}

class NoNetworkAvailableDhasboardOverallAttendance
    extends DhasboardOverallAttendanceState {
  const NoNetworkAvailableDhasboardOverallAttendance({
    required super.successMessage,
    required super.errorMessage,
    required super.DhasboardOverallattendanceData,
  });
}

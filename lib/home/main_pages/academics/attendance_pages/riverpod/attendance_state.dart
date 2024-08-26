import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/riverpod/attendance_provider.dart';

final attendanceProvider =
    StateNotifierProvider<AttendanceProvider, AttendanceState>((ref) {
  return AttendanceProvider();
});

class AttendanceState {
  const AttendanceState({
    required this.successMessage,
    required this.errorMessage,
    // required this.attendanceData,
  });

  final String successMessage;
  final String errorMessage;
  // final List<AttendanceData> attendanceData;

  AttendanceState copyWith({
    String? successMessage,
    String? errorMessage,
    // List<AttendanceData>? attendanceData,
  }) =>
      AttendanceState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        // attendanceData: attendanceData ?? this.attendanceData,
      );
}

class AttendanceInitial extends AttendanceState {
  AttendanceInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          // attendanceData: <AttendanceData>[],
        );
}

class AttendanceStateLoading extends AttendanceState {
  const AttendanceStateLoading({
    required super.successMessage,
    required super.errorMessage,
    // required super.attendanceData,
  });
}

class AttendanceStateError extends AttendanceState {
  const AttendanceStateError({
    required super.successMessage,
    required super.errorMessage,
    // required super.attendanceData,
  });
}

class AttendanceStateSuccessful extends AttendanceState {
  const AttendanceStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    // required super.attendanceData,
  });
}

class NoNetworkAvailableAttendance extends AttendanceState {
  const NoNetworkAvailableAttendance({
    required super.successMessage,
    required super.errorMessage,
    // required super.attendanceData,
  });
}

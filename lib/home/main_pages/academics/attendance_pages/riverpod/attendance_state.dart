import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/model/attendance_hive.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/model/attendance_response_model.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/riverpod/attendance_provider.dart';

final attendanceProvider =
    StateNotifierProvider<AttendanceProvider, AttendanceState>((ref) {
  return AttendanceProvider();
});

class AttendanceState {
  const AttendanceState({
    required this.successMessage,
    required this.errorMessage,
    required this.attendanceData,
    required this.attendancehiveData,
  });

  final String successMessage;
  final String errorMessage;
  final List<SubjectAttendanceData> attendanceData;
  final List<AttendanceHiveData> attendancehiveData;

  AttendanceState copyWith({
    String? successMessage,
    String? errorMessage,
    List<SubjectAttendanceData>? attendanceData,
    List<AttendanceHiveData>? attendancehiveData,
  }) =>
      AttendanceState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        attendanceData: attendanceData ?? this.attendanceData,
        attendancehiveData: attendancehiveData ?? this.attendancehiveData,
      );
}

class AttendanceInitial extends AttendanceState {
  AttendanceInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          attendanceData: <SubjectAttendanceData>[],
          attendancehiveData: <AttendanceHiveData>[],
        );
}

class AttendanceStateLoading extends AttendanceState {
   AttendanceStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.attendanceData,
    required super.attendancehiveData,
  });
}

class AttendanceStateError extends AttendanceState {
  const AttendanceStateError({
    required super.successMessage,
    required super.errorMessage,
    required super.attendanceData,
    required super.attendancehiveData,
  });
}

class AttendanceStateSuccessful extends AttendanceState {
  const AttendanceStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.attendanceData,
    required super.attendancehiveData,
  });
}

class NoNetworkAvailableAttendance extends AttendanceState {
  const NoNetworkAvailableAttendance({
    required super.successMessage,
    required super.errorMessage,
    required super.attendanceData,
    required super.attendancehiveData,
  });
}

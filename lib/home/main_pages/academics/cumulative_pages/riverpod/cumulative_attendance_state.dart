import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/model/cummulative_attendance_hive.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/riverpod/cumulative_attendance_provider.dart';

final cummulativeAttendanceProvider = StateNotifierProvider<
    CummulativeAttendanceProvider, CummulativeAttendanceState>((ref) {
  return CummulativeAttendanceProvider();
});

class CummulativeAttendanceState {
  CummulativeAttendanceState({
    required this.successMessage,
    required this.errorMessage,
    required this.cummulativeHiveAttendanceData,
  });

  final String successMessage;
  final String errorMessage;

  final List<CumulativeAttendanceHiveData> cummulativeHiveAttendanceData;

  CummulativeAttendanceState copyWith({
    String? successMessage,
    String? errorMessage,
    List<CumulativeAttendanceHiveData>? cummulativeHiveAttendanceData,
  }) =>
      CummulativeAttendanceState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        cummulativeHiveAttendanceData:
            cummulativeHiveAttendanceData ?? this.cummulativeHiveAttendanceData,
      );
}

class CummulativeAttendanceInitial extends CummulativeAttendanceState {
  CummulativeAttendanceInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          cummulativeHiveAttendanceData: <CumulativeAttendanceHiveData>[],
        );
}

class CummulativeAttendanceStateLoading extends CummulativeAttendanceState {
  CummulativeAttendanceStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.cummulativeHiveAttendanceData,
  });
}

class CummulativeAttendanceStateError extends CummulativeAttendanceState {
  CummulativeAttendanceStateError({
    required super.successMessage,
    required super.errorMessage,
    required super.cummulativeHiveAttendanceData,
  });
}

class CummulativeAttendanceStateSuccessful extends CummulativeAttendanceState {
  CummulativeAttendanceStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.cummulativeHiveAttendanceData,
  });
}

class NoNetworkAvailableCummulativeAttendance
    extends CummulativeAttendanceState {
  NoNetworkAvailableCummulativeAttendance({
    required super.successMessage,
    required super.errorMessage,
    required super.cummulativeHiveAttendanceData,
  });
}

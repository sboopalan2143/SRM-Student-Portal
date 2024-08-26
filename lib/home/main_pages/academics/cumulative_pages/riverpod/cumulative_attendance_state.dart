import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/riverpod/cumulative_attendance_provider.dart';

final cummulativeAttendanceProvider = StateNotifierProvider<
    CummulativeAttendanceProvider, CummulativeAttendanceState>((ref) {
  return CummulativeAttendanceProvider();
});

class CummulativeAttendanceState {
  const CummulativeAttendanceState({
    required this.successMessage,
    required this.errorMessage,
    // required this.cummulativeAttendanceData,
  });

  final String successMessage;
  final String errorMessage;
  // final List<cummulativeAttendanceData> cummulativeAttendanceData;

  CummulativeAttendanceState copyWith({
    String? successMessage,
    String? errorMessage,
    // List<cummulativeAttendanceData>? cummulativeAttendanceData,
  }) =>
      CummulativeAttendanceState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        // cummulativeAttendanceData: cummulativeAttendanceData
        // ?? this.cummulativeAttendanceData,
      );
}

class CummulativeAttendanceInitial extends CummulativeAttendanceState {
  CummulativeAttendanceInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          // cummulativeAttendanceData: <cummulativeAttendanceData>[],
        );
}

class CummulativeAttendanceStateLoading extends CummulativeAttendanceState {
  const CummulativeAttendanceStateLoading({
    required super.successMessage,
    required super.errorMessage,
    // required super.cummulativeAttendanceData,
  });
}

class CummulativeAttendanceStateError extends CummulativeAttendanceState {
  const CummulativeAttendanceStateError({
    required super.successMessage,
    required super.errorMessage,
    // required super.cummulativeAttendanceData,
  });
}

class CummulativeAttendanceStateSuccessful extends CummulativeAttendanceState {
  const CummulativeAttendanceStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    // required super.cummulativeAttendanceData,
  });
}

class NoNetworkAvailableCummulativeAttendance
    extends CummulativeAttendanceState {
  const NoNetworkAvailableCummulativeAttendance({
    required super.successMessage,
    required super.errorMessage,
    // required super.cummulativeAttendanceData,
  });
}

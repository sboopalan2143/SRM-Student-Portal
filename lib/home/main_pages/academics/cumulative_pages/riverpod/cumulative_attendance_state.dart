import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/model/cumulative_attendance_model.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/riverpod/cumulative_attendance_provider.dart';

final cummulativeAttendanceProvider = StateNotifierProvider<
    CummulativeAttendanceProvider, CummulativeAttendanceState>((ref) {
  return CummulativeAttendanceProvider();
});

class CummulativeAttendanceState {
  CummulativeAttendanceState({
    required this.successMessage,
    required this.errorMessage,
    required this.cummulativeAttendanceData,
  });

  final String successMessage;
  final String errorMessage;
  final List<CumulativeAttendanceData> cummulativeAttendanceData;

  CummulativeAttendanceState copyWith({
    String? successMessage,
    String? errorMessage,
    List<CumulativeAttendanceData>? cummulativeAttendanceData,
  }) =>
      CummulativeAttendanceState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        cummulativeAttendanceData:
            cummulativeAttendanceData ?? this.cummulativeAttendanceData,
      );
}

class CummulativeAttendanceInitial extends CummulativeAttendanceState {
  CummulativeAttendanceInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          cummulativeAttendanceData: <CumulativeAttendanceData>[],
        );
}

class CummulativeAttendanceStateLoading extends CummulativeAttendanceState {
  CummulativeAttendanceStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.cummulativeAttendanceData,
  });
}

class CummulativeAttendanceStateError extends CummulativeAttendanceState {
  CummulativeAttendanceStateError({
    required super.successMessage,
    required super.errorMessage,
    required super.cummulativeAttendanceData,
  });
}

class CummulativeAttendanceStateSuccessful extends CummulativeAttendanceState {
  CummulativeAttendanceStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.cummulativeAttendanceData,
  });
}

class NoNetworkAvailableCummulativeAttendance
    extends CummulativeAttendanceState {
  NoNetworkAvailableCummulativeAttendance({
    required super.successMessage,
    required super.errorMessage,
    required super.cummulativeAttendanceData,
  });
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/academics/internal_marks_pages/riverpod/internal_marks_provider.dart';

final internalMarksProvider =
    StateNotifierProvider<InternalMarksProvider, InternalMarksState>((ref) {
  return InternalMarksProvider();
});

class InternalMarksState {
  const InternalMarksState({
    required this.successMessage,
    required this.errorMessage,
    // required this.cummulativeAttendanceData,
  });

  final String successMessage;
  final String errorMessage;
  // final List<cummulativeAttendanceData> cummulativeAttendanceData;

  InternalMarksState copyWith({
    String? successMessage,
    String? errorMessage,
    // List<cummulativeAttendanceData>? cummulativeAttendanceData,
  }) =>
      InternalMarksState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        // cummulativeAttendanceData: cummulativeAttendanceData
        // ?? this.cummulativeAttendanceData,
      );
}

class InternalMarksInitial extends InternalMarksState {
  InternalMarksInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          // cummulativeAttendanceData: <cummulativeAttendanceData>[],
        );
}

class InternalMarksStateLoading extends InternalMarksState {
  const InternalMarksStateLoading({
    required super.successMessage,
    required super.errorMessage,
    // required super.cummulativeAttendanceData,
  });
}

class InternalMarksStateError extends InternalMarksState {
  const InternalMarksStateError({
    required super.successMessage,
    required super.errorMessage,
    // required super.cummulativeAttendanceData,
  });
}

class InternalMarksStateSuccessful extends InternalMarksState {
  const InternalMarksStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    // required super.cummulativeAttendanceData,
  });
}

class NoNetworkAvailableInternalMarks extends InternalMarksState {
  const NoNetworkAvailableInternalMarks({
    required super.successMessage,
    required super.errorMessage,
    // required super.cummulativeAttendanceData,
  });
}

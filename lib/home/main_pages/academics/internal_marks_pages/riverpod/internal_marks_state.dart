import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/academics/internal_marks_pages/model/internal_mark_hive_model.dart';
import 'package:sample/home/main_pages/academics/internal_marks_pages/riverpod/internal_marks_provider.dart';

final internalMarksProvider =
    StateNotifierProvider<InternalMarksProvider, InternalMarksState>((ref) {
  return InternalMarksProvider();
});

class InternalMarksState {
  InternalMarksState({
    required this.successMessage,
    required this.errorMessage,
    required this.internalMarkHiveData,
  });

  final String successMessage;
  final String errorMessage;

  final List<InternalMarkHiveData> internalMarkHiveData;

  InternalMarksState copyWith({
    String? successMessage,
    String? errorMessage,
    List<InternalMarkHiveData>? internalMarkHiveData,
  }) =>
      InternalMarksState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        internalMarkHiveData: internalMarkHiveData ?? this.internalMarkHiveData,
      );
}

class InternalMarksInitial extends InternalMarksState {
  InternalMarksInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          internalMarkHiveData: <InternalMarkHiveData>[],
        );
}

class InternalMarksStateLoading extends InternalMarksState {
  InternalMarksStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.internalMarkHiveData,
  });
}

class InternalMarksStateError extends InternalMarksState {
  InternalMarksStateError({
    required super.successMessage,
    required super.errorMessage,
    required super.internalMarkHiveData,
  });
}

class InternalMarksStateSuccessful extends InternalMarksState {
  InternalMarksStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.internalMarkHiveData,
  });
}

class NoNetworkAvailableInternalMarks extends InternalMarksState {
  NoNetworkAvailableInternalMarks({
    required super.successMessage,
    required super.errorMessage,
    required super.internalMarkHiveData,
  });
}

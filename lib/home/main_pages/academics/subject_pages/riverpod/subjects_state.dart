import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/academics/subject_pages/riverpod/subjects_provider.dart';

final subjectProvider =
    StateNotifierProvider<SubjectProvider, SubjectState>((ref) {
  return SubjectProvider();
});

class SubjectState {
  const SubjectState({
    required this.successMessage,
    required this.errorMessage,
    required this.subjectData,
  });

  final String successMessage;
  final String errorMessage;
  final List<dynamic> subjectData;

  SubjectState copyWith({
    String? successMessage,
    String? errorMessage,
    List<dynamic>? subjectData,
  }) =>
      SubjectState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        subjectData: subjectData ?? this.subjectData,
      );
}

class SubjectInitial extends SubjectState {
  SubjectInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          subjectData: <dynamic>[],
        );
}

class SubjectStateLoading extends SubjectState {
  const SubjectStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.subjectData,
  });
}

class SubjectStateError extends SubjectState {
  const SubjectStateError({
    required super.successMessage,
    required super.errorMessage,
    required super.subjectData,
  });
}

class SubjectStateSuccessful extends SubjectState {
  const SubjectStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.subjectData,
  });
}

class NoNetworkAvailableSubject extends SubjectState {
  const NoNetworkAvailableSubject({
    required super.successMessage,
    required super.errorMessage,
    required super.subjectData,
  });
}

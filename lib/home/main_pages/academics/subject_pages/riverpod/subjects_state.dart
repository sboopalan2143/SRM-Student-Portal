import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/academics/subject_pages/model/subject_responce_hive_model.dart';
import 'package:sample/home/main_pages/academics/subject_pages/riverpod/subjects_provider.dart';

final subjectProvider =
    StateNotifierProvider<SubjectProvider, SubjectState>((ref) {
  return SubjectProvider();
});

class SubjectState {
  const SubjectState({
    required this.successMessage,
    required this.errorMessage,
    required this.subjectHiveData,
  });

  final String successMessage;
  final String errorMessage;

  final List<SubjectHiveData> subjectHiveData;

  SubjectState copyWith({
    String? successMessage,
    String? errorMessage,
    List<SubjectHiveData>? subjectHiveData,
  }) =>
      SubjectState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        subjectHiveData: subjectHiveData ?? this.subjectHiveData,
      );
}

class SubjectInitial extends SubjectState {
  SubjectInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          subjectHiveData: <SubjectHiveData>[],
        );
}

class SubjectStateLoading extends SubjectState {
  const SubjectStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.subjectHiveData,
  });
}

class SubjectStateError extends SubjectState {
  const SubjectStateError({
    required super.successMessage,
    required super.errorMessage,
    required super.subjectHiveData,
  });
}

class SubjectStateSuccessful extends SubjectState {
  const SubjectStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.subjectHiveData,
  });
}

class NoNetworkAvailableSubject extends SubjectState {
  const NoNetworkAvailableSubject({
    required super.successMessage,
    required super.errorMessage,
    required super.subjectHiveData,
  });
}

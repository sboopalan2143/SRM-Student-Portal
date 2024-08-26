import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/model/exam_details_model.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/riverpod/exam_details_provider.dart';

final examDetailsProvider =
    StateNotifierProvider<ExamDetailsProvider, ExamDetailsState>((ref) {
  return ExamDetailsProvider();
});

class ExamDetailsState {
  const ExamDetailsState({
    required this.successMessage,
    required this.errorMessage,
    required this.examDetailsData,
  });

  final String successMessage;
  final String errorMessage;
  final List<ExamDetailsData> examDetailsData;

  ExamDetailsState copyWith({
    String? successMessage,
    String? errorMessage,
    List<ExamDetailsData>? examDetailsData,
  }) =>
      ExamDetailsState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        examDetailsData: examDetailsData ?? this.examDetailsData,
      );
}

class ExamDetailsInitial extends ExamDetailsState {
  ExamDetailsInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          examDetailsData: <ExamDetailsData>[],
        );
}

class ExamDetailsStateLoading extends ExamDetailsState {
  const ExamDetailsStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.examDetailsData,
  });
}

class ExamDetailsSuccessFull extends ExamDetailsState {
  const ExamDetailsSuccessFull({
    required super.successMessage,
    required super.errorMessage,
    required super.examDetailsData,
  });
}

class ExamDetailsError extends ExamDetailsState {
  const ExamDetailsError({
    required super.successMessage,
    required super.errorMessage,
    required super.examDetailsData,
  });
}

class ExamDetailsStateSuccessful extends ExamDetailsState {
  const ExamDetailsStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.examDetailsData,
  });
}

class NoNetworkAvailableExamDetails extends ExamDetailsState {
  const NoNetworkAvailableExamDetails({
    required super.successMessage,
    required super.errorMessage,
    required super.examDetailsData,
  });
}

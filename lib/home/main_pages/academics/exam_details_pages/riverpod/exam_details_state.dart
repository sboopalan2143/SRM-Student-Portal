import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/riverpod/exam_details_provider.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_provider.dart';
import 'package:sample/home/main_pages/academics/hourwise_attendence/riverpod/hourwise_attendence_provider.dart';

final examDetailsProvider =
    StateNotifierProvider<ExamDetailsProvider, examDetailsState>((ref) {
  return ExamDetailsProvider();
});

class examDetailsState {
  const examDetailsState({
    required this.successMessage,
    required this.errorMessage,
  });

  final String successMessage;
  final String errorMessage;

  examDetailsState copyWith({
    String? successMessage,
    String? errorMessage,
  }) =>
      examDetailsState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}

class examDetailsInitial extends examDetailsState {
  examDetailsInitial()
      : super(
          successMessage: '',
          errorMessage: '',
        );
}

class examDetailsStateLoading extends examDetailsState {
  const examDetailsStateLoading({
    required super.successMessage,
    required super.errorMessage,
  });
}

class examDetailsSuccessFull extends examDetailsState {
  const examDetailsSuccessFull({
    required super.successMessage,
    required super.errorMessage,
  });
}

class examDetailsError extends examDetailsState {
  const examDetailsError({
    required super.successMessage,
    required super.errorMessage,
  });
}

class examDetailsStateSuccessful extends examDetailsState {
  const examDetailsStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
  });
}

class NoNetworkAvailableexamDetails extends examDetailsState {
  const NoNetworkAvailableexamDetails({
    required super.successMessage,
    required super.errorMessage,
  });
}

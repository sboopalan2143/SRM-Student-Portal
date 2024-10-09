import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/lms/model/lms_getSubject_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_gettitle_model.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_provider.dart';

final lmsProvider = StateNotifierProvider<LmsProvider, LmsState>((ref) {
  return LmsProvider();
});

class LmsState {
  const LmsState({
    required this.successMessage,
    required this.errorMessage,
    required this.lmsSubjectData,
    required this.lmsTitleData,
  });

  final String successMessage;
  final String errorMessage;
  final List<LmsSubjectData> lmsSubjectData;
  final List<LmsGetTitleData> lmsTitleData;

  LmsState copyWith({
    String? successMessage,
    String? errorMessage,
    List<LmsSubjectData>? lmsSubjectData,
    List<LmsGetTitleData>? lmsTitleData,
  }) =>
      LmsState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        lmsSubjectData: lmsSubjectData ?? this.lmsSubjectData,
        lmsTitleData: lmsTitleData ?? this.lmsTitleData,
      );
}

class LmsInitial extends LmsState {
  LmsInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          lmsSubjectData: <LmsSubjectData>[],
          lmsTitleData: <LmsGetTitleData>[],
        );
}

class LmsStateLoading extends LmsState {
  const LmsStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.lmsSubjectData,
    required super.lmsTitleData,
  });
}

class LmsStateError extends LmsState {
  const LmsStateError({
    required super.successMessage,
    required super.errorMessage,
    required super.lmsSubjectData,
    required super.lmsTitleData,
  });
}

class LmsStateSuccessful extends LmsState {
  const LmsStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.lmsSubjectData,
    required super.lmsTitleData,
  });
}

class LmsStateclear extends LmsState {
  const LmsStateclear({
    required super.successMessage,
    required super.errorMessage,
    required super.lmsSubjectData,
    required super.lmsTitleData,
  });
}

class NoNetworkAvailableLmsMember extends LmsState {
  const NoNetworkAvailableLmsMember({
    required super.successMessage,
    required super.errorMessage,
    required super.lmsSubjectData,
    required super.lmsTitleData,
  });
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/lms/model/lms_classworkdetails_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_getAttachmentDetails_model.dart';
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
    required this.classWorkDetailsData,
    required this.lmsAttachmentDetailsData,
  });

  final String successMessage;
  final String errorMessage;
  final List<LmsSubjectData> lmsSubjectData;
  final List<LmsGetTitleData> lmsTitleData;
  final List<ClassWorkDetailsData> classWorkDetailsData;
  final List<GetAttachmentDetailsData> lmsAttachmentDetailsData;

  LmsState copyWith({
    String? successMessage,
    String? errorMessage,
    List<LmsSubjectData>? lmsSubjectData,
    List<LmsGetTitleData>? lmsTitleData,
    List<ClassWorkDetailsData>? classWorkDetailsData,
    List<GetAttachmentDetailsData>? lmsAttachmentDetailsData,
  }) =>
      LmsState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        lmsSubjectData: lmsSubjectData ?? this.lmsSubjectData,
        lmsTitleData: lmsTitleData ?? this.lmsTitleData,
        classWorkDetailsData: classWorkDetailsData ?? this.classWorkDetailsData,
        lmsAttachmentDetailsData:
            lmsAttachmentDetailsData ?? this.lmsAttachmentDetailsData,
      );
}

class LmsInitial extends LmsState {
  LmsInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          lmsSubjectData: <LmsSubjectData>[],
          lmsTitleData: <LmsGetTitleData>[],
          classWorkDetailsData: <ClassWorkDetailsData>[],
          lmsAttachmentDetailsData: <GetAttachmentDetailsData>[],
        );
}

class LmsStateLoading extends LmsState {
  const LmsStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.lmsSubjectData,
    required super.lmsTitleData,
    required super.classWorkDetailsData,
    required super.lmsAttachmentDetailsData,
  });
}

class LmsStateError extends LmsState {
  const LmsStateError({
    required super.successMessage,
    required super.errorMessage,
    required super.lmsSubjectData,
    required super.lmsTitleData,
    required super.classWorkDetailsData,
    required super.lmsAttachmentDetailsData,
  });
}

class LmsStateSuccessful extends LmsState {
  const LmsStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.lmsSubjectData,
    required super.lmsTitleData,
    required super.classWorkDetailsData,
    required super.lmsAttachmentDetailsData,
  });
}

class LmsStateclear extends LmsState {
  const LmsStateclear({
    required super.successMessage,
    required super.errorMessage,
    required super.lmsSubjectData,
    required super.lmsTitleData,
    required super.classWorkDetailsData,
    required super.lmsAttachmentDetailsData,
  });
}

class NoNetworkAvailableLmsMember extends LmsState {
  const NoNetworkAvailableLmsMember({
    required super.successMessage,
    required super.errorMessage,
    required super.lmsSubjectData,
    required super.lmsTitleData,
    required super.classWorkDetailsData,
    required super.lmsAttachmentDetailsData,
  });
}

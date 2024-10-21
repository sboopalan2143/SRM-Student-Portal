import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/lms/model/lms_classworkdetails_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_getAttachmentDetails_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_getSubject_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_get_comment_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_gettitle_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_replay_faculty_comment_model.dart';
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
    required this.comment,
    required this.lmsgetcommentData,
    required this.lmsgetfacultycommentData,
  });

  final String successMessage;
  final String errorMessage;
  final List<LmsSubjectData> lmsSubjectData;
  final List<LmsGetTitleData> lmsTitleData;
  final List<ClassWorkDetailsData> classWorkDetailsData;
  final List<GetAttachmentDetailsData> lmsAttachmentDetailsData;
  final TextEditingController comment;
  final List<GetCommentData> lmsgetcommentData;
  final List<ReplayFacultyCommentData> lmsgetfacultycommentData;

  LmsState copyWith({
    String? successMessage,
    String? errorMessage,
    List<LmsSubjectData>? lmsSubjectData,
    List<LmsGetTitleData>? lmsTitleData,
    List<ClassWorkDetailsData>? classWorkDetailsData,
    List<GetAttachmentDetailsData>? lmsAttachmentDetailsData,
    TextEditingController? comment,
    List<GetCommentData>? lmsgetcommentData,
    List<ReplayFacultyCommentData>? lmsgetfacultycommentData,
  }) =>
      LmsState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        lmsSubjectData: lmsSubjectData ?? this.lmsSubjectData,
        lmsTitleData: lmsTitleData ?? this.lmsTitleData,
        classWorkDetailsData: classWorkDetailsData ?? this.classWorkDetailsData,
        lmsAttachmentDetailsData:
            lmsAttachmentDetailsData ?? this.lmsAttachmentDetailsData,
        comment: comment ?? this.comment,
        lmsgetcommentData: lmsgetcommentData ?? this.lmsgetcommentData,
        lmsgetfacultycommentData:
            lmsgetfacultycommentData ?? this.lmsgetfacultycommentData,
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
          comment: TextEditingController(),
          lmsgetcommentData: <GetCommentData>[],
          lmsgetfacultycommentData: <ReplayFacultyCommentData>[],
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
    required super.comment,
    required super.lmsgetcommentData,
    required super.lmsgetfacultycommentData,
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
    required super.comment,
    required super.lmsgetcommentData,
    required super.lmsgetfacultycommentData,
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
    required super.comment,
    required super.lmsgetcommentData,
    required super.lmsgetfacultycommentData,
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
    required super.comment,
    required super.lmsgetcommentData,
    required super.lmsgetfacultycommentData,
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
    required super.comment,
    required super.lmsgetcommentData,
    required super.lmsgetfacultycommentData,
  });
}

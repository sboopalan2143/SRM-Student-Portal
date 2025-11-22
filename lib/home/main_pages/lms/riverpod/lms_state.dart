import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/lms/model/l%E2%95%A0%C3%BAms_faculty_get_comment_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_classworkdetails_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_getAttachmentDetails_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_getStudentAttachment_Details.dart';
import 'package:sample/home/main_pages/lms/model/lms_getSubject_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_get_comment_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_gettitle_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_replay_faculty_comment_model.dart';
import 'package:sample/home/main_pages/lms/model/mcq_get_question_and_answer_model.dart';
import 'package:sample/home/main_pages/lms/model/mcq_get_view_list_model.dart';
import 'package:sample/home/main_pages/lms/model/mcq_shedule-model.dart';
import 'package:sample/home/main_pages/lms/model/mcq_submited_answer_model.dart';
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
    required this.lmsStudentAttachmentDetailsData,
    required this.comment,
    required this.lmsgetcommentData,
    required this.lmsReplayfacultycommentData,
    required this.lmsfacultygetcommentData,
    required this.imagepath,
    required this.remarks,
    required this.action,
    required this.mcqSheduleData,
    required this.mcqQuestionAndAnswerData,
    required this.answerdesc,
    required this.mcqSubmitedData,
    required this.mcqgetAnswerDetails,
  });

  final String successMessage;
  final String errorMessage;
  final List<LmsSubjectData> lmsSubjectData;
  final List<LmsGetTitleData> lmsTitleData;
  final List<ClassWorkDetailsData> classWorkDetailsData;
  final List<GetAttachmentDetailsData> lmsAttachmentDetailsData;
  final List<GetStudentAttachmentDetailsData> lmsStudentAttachmentDetailsData;
  final TextEditingController comment;
  final List<GetCommentData> lmsgetcommentData;
  final List<ReplayFacultyCommentData> lmsReplayfacultycommentData;
  final List<FacultyGetCommentData> lmsfacultygetcommentData;
  final TextEditingController imagepath;
  final TextEditingController remarks;
  final TextEditingController action;
  final List<McqSheduleData> mcqSheduleData;
  final List<McqGetQuestionAndAnswerData> mcqQuestionAndAnswerData;
  final TextEditingController answerdesc;
  final McqSubmitedData mcqSubmitedData;
  final List<MCQGetViewModelData> mcqgetAnswerDetails;

  LmsState copyWith({
    String? successMessage,
    String? errorMessage,
    List<LmsSubjectData>? lmsSubjectData,
    List<LmsGetTitleData>? lmsTitleData,
    List<ClassWorkDetailsData>? classWorkDetailsData,
    List<GetAttachmentDetailsData>? lmsAttachmentDetailsData,
    List<GetStudentAttachmentDetailsData>? lmsStudentAttachmentDetailsData,
    TextEditingController? comment,
    List<GetCommentData>? lmsgetcommentData,
    List<ReplayFacultyCommentData>? lmsReplayfacultycommentData,
    List<FacultyGetCommentData>? lmsfacultygetcommentData,
    TextEditingController? imagepath,
    TextEditingController? remarks,
    TextEditingController? action,
    List<McqSheduleData>? mcqSheduleData,
    List<McqGetQuestionAndAnswerData>? mcqQuestionAndAnswerData,
    TextEditingController? answerdesc,
    McqSubmitedData? mcqSubmitedData,
    List<MCQGetViewModelData>? mcqgetAnswerDetails,
  }) =>
      LmsState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        lmsSubjectData: lmsSubjectData ?? this.lmsSubjectData,
        lmsTitleData: lmsTitleData ?? this.lmsTitleData,
        classWorkDetailsData: classWorkDetailsData ?? this.classWorkDetailsData,
        lmsAttachmentDetailsData:
            lmsAttachmentDetailsData ?? this.lmsAttachmentDetailsData,
        lmsStudentAttachmentDetailsData: lmsStudentAttachmentDetailsData ??
            this.lmsStudentAttachmentDetailsData,
        comment: comment ?? this.comment,
        lmsgetcommentData: lmsgetcommentData ?? this.lmsgetcommentData,
        lmsReplayfacultycommentData:
            lmsReplayfacultycommentData ?? this.lmsReplayfacultycommentData,
        lmsfacultygetcommentData:
            lmsfacultygetcommentData ?? this.lmsfacultygetcommentData,
        imagepath: imagepath ?? this.imagepath,
        remarks: remarks ?? this.remarks,
        action: action ?? this.action,
        mcqSheduleData: mcqSheduleData ?? this.mcqSheduleData,
        mcqQuestionAndAnswerData:
            mcqQuestionAndAnswerData ?? this.mcqQuestionAndAnswerData,
        answerdesc: answerdesc ?? this.answerdesc,
        mcqSubmitedData: mcqSubmitedData ?? this.mcqSubmitedData,
        mcqgetAnswerDetails: mcqgetAnswerDetails ?? this.mcqgetAnswerDetails,
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
          lmsStudentAttachmentDetailsData: <GetStudentAttachmentDetailsData>[],
          comment: TextEditingController(),
          lmsgetcommentData: <GetCommentData>[],
          lmsReplayfacultycommentData: <ReplayFacultyCommentData>[],
          lmsfacultygetcommentData: <FacultyGetCommentData>[],
          imagepath: TextEditingController(),
          remarks: TextEditingController(),
          action: TextEditingController(),
          mcqSheduleData: <McqSheduleData>[],
          mcqQuestionAndAnswerData: <McqGetQuestionAndAnswerData>[],
          answerdesc: TextEditingController(),
          mcqSubmitedData: McqSubmitedData.empty,
          mcqgetAnswerDetails: <MCQGetViewModelData>[],
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
    required super.lmsStudentAttachmentDetailsData,
    required super.comment,
    required super.lmsgetcommentData,
    required super.lmsReplayfacultycommentData,
    required super.lmsfacultygetcommentData,
    required super.imagepath,
    required super.remarks,
    required super.action,
    required super.mcqSheduleData,
    required super.mcqQuestionAndAnswerData,
    required super.answerdesc,
    required super.mcqSubmitedData,
    required super.mcqgetAnswerDetails,
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
    required super.lmsStudentAttachmentDetailsData,
    required super.comment,
    required super.lmsgetcommentData,
    required super.lmsReplayfacultycommentData,
    required super.lmsfacultygetcommentData,
    required super.imagepath,
    required super.remarks,
    required super.action,
    required super.mcqSheduleData,
    required super.mcqQuestionAndAnswerData,
    required super.answerdesc,
    required super.mcqSubmitedData,
    required super.mcqgetAnswerDetails,
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
    required super.lmsStudentAttachmentDetailsData,
    required super.comment,
    required super.lmsgetcommentData,
    required super.lmsReplayfacultycommentData,
    required super.lmsfacultygetcommentData,
    required super.imagepath,
    required super.remarks,
    required super.action,
    required super.mcqSheduleData,
    required super.mcqQuestionAndAnswerData,
    required super.answerdesc,
    required super.mcqSubmitedData,
    required super.mcqgetAnswerDetails,
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
    required super.lmsStudentAttachmentDetailsData,
    required super.comment,
    required super.lmsgetcommentData,
    required super.lmsReplayfacultycommentData,
    required super.lmsfacultygetcommentData,
    required super.imagepath,
    required super.remarks,
    required super.action,
    required super.mcqSheduleData,
    required super.mcqQuestionAndAnswerData,
    required super.answerdesc,
    required super.mcqSubmitedData,
    required super.mcqgetAnswerDetails,
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
    required super.lmsStudentAttachmentDetailsData,
    required super.comment,
    required super.lmsgetcommentData,
    required super.lmsReplayfacultycommentData,
    required super.lmsfacultygetcommentData,
    required super.imagepath,
    required super.remarks,
    required super.action,
    required super.mcqSheduleData,
    required super.mcqQuestionAndAnswerData,
    required super.answerdesc,
    required super.mcqSubmitedData,
    required super.mcqgetAnswerDetails,
  });
}

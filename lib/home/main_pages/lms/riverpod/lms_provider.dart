import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/lms/model/%E1%B8%B7ms_faculty_get_comment_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_classworkdetails_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_getAttachmentDetails_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_getSubject_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_get_comment_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_gettitle_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_replay_faculty_comment_model.dart';
import 'package:sample/home/main_pages/lms/model/mcq_get_question_and_answer_model.dart';
import 'package:sample/home/main_pages/lms/model/mcq_shedule-model.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';

class LmsProvider extends StateNotifier<LmsState> {
  LmsProvider() : super(LmsInitial());

  void disposeState() => state = LmsInitial();

  void _setLoading() => state = LmsStateLoading(
        successMessage: '',
        errorMessage: '',
        lmsSubjectData: <LmsSubjectData>[],
        lmsTitleData: <LmsGetTitleData>[],
        classWorkDetailsData: <ClassWorkDetailsData>[],
        lmsAttachmentDetailsData: <GetAttachmentDetailsData>[],
        comment: TextEditingController(),
        lmsgetcommentData: <GetCommentData>[],
        lmsReplayfacultycommentData: <ReplayFacultyCommentData>[],
        lmsfacultygetcommentData: <FacultyGetCommentData>[],
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: <McqSheduleData>[],
        mcqQuestionAndAnswerData: <McqGetQuestionAndAnswerData>[],
      );

  void clearstate() => state = LmsStateclear(
        successMessage: '',
        errorMessage: '',
        lmsSubjectData: const <LmsSubjectData>[],
        lmsTitleData: const <LmsGetTitleData>[],
        classWorkDetailsData: const <ClassWorkDetailsData>[],
        lmsAttachmentDetailsData: const <GetAttachmentDetailsData>[],
        comment: TextEditingController(),
        lmsgetcommentData: <GetCommentData>[],
        lmsReplayfacultycommentData: <ReplayFacultyCommentData>[],
        lmsfacultygetcommentData: <FacultyGetCommentData>[],
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: <McqSheduleData>[],
        mcqQuestionAndAnswerData: <McqGetQuestionAndAnswerData>[],
      );

  Future<void> getLmsSubgetDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response = await HttpService.sendSoapRequest('getSubject', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableLmsMember(
        successMessage: '',
        errorMessage: '',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
        classWorkDetailsData: state.classWorkDetailsData,
        lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
        comment: TextEditingController(),
        lmsgetcommentData: state.lmsgetcommentData,
        lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
        lmsfacultygetcommentData: state.lmsfacultygetcommentData,
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: state.mcqSheduleData,
        mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final libraryMemberRes =
          details['getSubjectResponse'] as Map<String, dynamic>;
      final returnData = libraryMemberRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      var lmsSubjectData = state.lmsSubjectData;
      log('decrypted>>>>>>>>$decryptedData');

      try {
        final lmsSubjectDataResponse =
            GetSubjectModel.fromJson(decryptedData.mapData!);
        lmsSubjectData = lmsSubjectDataResponse.data!;
        state = state.copyWith(lmsSubjectData: lmsSubjectData);
        if (lmsSubjectDataResponse.status == 'Success') {
          // state = LibraryTrancsactionStateSuccessful(
          //   successMessage: libraryTransactionDataResponse.status!,
          //   errorMessage: '',
          //   libraryTransactionData: state.libraryTransactionData,
          //   studentId: TextEditingController(),
          //   officeid: TextEditingController(),
          //   filter: TextEditingController(),
          // );
        } else if (lmsSubjectDataResponse.status != 'Success') {
          state = LmsStateError(
            successMessage: '',
            errorMessage:
                '''${lmsSubjectDataResponse.status!}, ${lmsSubjectDataResponse.message!}''',
            lmsSubjectData: state.lmsSubjectData,
            lmsTitleData: state.lmsTitleData,
            classWorkDetailsData: state.classWorkDetailsData,
            lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
            comment: TextEditingController(),
            lmsgetcommentData: state.lmsgetcommentData,
            lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
            lmsfacultygetcommentData: state.lmsfacultygetcommentData,
            imagepath: TextEditingController(),
            remarks: TextEditingController(),
            action: TextEditingController(),
            mcqSheduleData: state.mcqSheduleData,
            mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = LmsStateError(
          successMessage: '',
          errorMessage: error.message!,
          lmsSubjectData: state.lmsSubjectData,
          lmsTitleData: state.lmsTitleData,
          classWorkDetailsData: state.classWorkDetailsData,
          lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
          comment: TextEditingController(),
          lmsgetcommentData: state.lmsgetcommentData,
          lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
          lmsfacultygetcommentData: state.lmsfacultygetcommentData,
          imagepath: TextEditingController(),
          remarks: TextEditingController(),
          action: TextEditingController(),
          mcqSheduleData: state.mcqSheduleData,
          mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
        );
      }
    } else if (response.$1 != 200) {
      state = LmsStateError(
        successMessage: '',
        errorMessage: 'Error',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
        classWorkDetailsData: state.classWorkDetailsData,
        lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
        comment: TextEditingController(),
        lmsgetcommentData: state.lmsgetcommentData,
        lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
        lmsfacultygetcommentData: state.lmsfacultygetcommentData,
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: state.mcqSheduleData,
        mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
      );
    }
  }

  Future<void> getLmsTitleDetails(
    EncryptionProvider encrypt,
    String subjectId,
  ) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><subjectid>$subjectId</subjectid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response = await HttpService.sendSoapRequest('getTitles', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableLmsMember(
        successMessage: '',
        errorMessage: '',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
        classWorkDetailsData: state.classWorkDetailsData,
        lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
        comment: TextEditingController(),
        lmsgetcommentData: state.lmsgetcommentData,
        lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
        lmsfacultygetcommentData: state.lmsfacultygetcommentData,
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: state.mcqSheduleData,
        mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final lmsTitleRes = details['getTitlesResponse'] as Map<String, dynamic>;
      final returnData = lmsTitleRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      var lmsTitleData = state.lmsTitleData;
      log('decrypted>>>>>>>>$decryptedData');

      try {
        final lmsTitleDataResponse =
            GetTitleListModel.fromJson(decryptedData.mapData!);
        lmsTitleData = lmsTitleDataResponse.data!;
        state = state.copyWith(lmsTitleData: lmsTitleData);
        if (lmsTitleDataResponse.status == 'Success') {
          // state = LibraryTrancsactionStateSuccessful(
          //   successMessage: libraryTransactionDataResponse.status!,
          //   errorMessage: '',
          //   libraryTransactionData: state.libraryTransactionData,
          //   studentId: TextEditingController(),
          //   officeid: TextEditingController(),
          //   filter: TextEditingController(),
          // );
        } else if (lmsTitleDataResponse.status != 'Success') {
          state = LmsStateError(
            successMessage: '',
            errorMessage:
                '''${lmsTitleDataResponse.status!}, ${lmsTitleDataResponse.message!}''',
            lmsSubjectData: state.lmsSubjectData,
            lmsTitleData: state.lmsTitleData,
            classWorkDetailsData: state.classWorkDetailsData,
            lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
            comment: TextEditingController(),
            lmsgetcommentData: state.lmsgetcommentData,
            lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
            lmsfacultygetcommentData: state.lmsfacultygetcommentData,
            imagepath: TextEditingController(),
            remarks: TextEditingController(),
            action: TextEditingController(),
            mcqSheduleData: state.mcqSheduleData,
            mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = LmsStateError(
          successMessage: '',
          errorMessage: error.message!,
          lmsSubjectData: state.lmsSubjectData,
          lmsTitleData: state.lmsTitleData,
          classWorkDetailsData: state.classWorkDetailsData,
          lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
          comment: TextEditingController(),
          lmsgetcommentData: state.lmsgetcommentData,
          lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
          lmsfacultygetcommentData: state.lmsfacultygetcommentData,
          imagepath: TextEditingController(),
          remarks: TextEditingController(),
          action: TextEditingController(),
          mcqSheduleData: state.mcqSheduleData,
          mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
        );
      }
    } else if (response.$1 != 200) {
      state = LmsStateError(
        successMessage: '',
        errorMessage: 'Error',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
        classWorkDetailsData: state.classWorkDetailsData,
        lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
        comment: TextEditingController(),
        lmsgetcommentData: state.lmsgetcommentData,
        lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
        lmsfacultygetcommentData: state.lmsfacultygetcommentData,
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: state.mcqSheduleData,
        mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
      );
    }
  }

  Future<void> getLmsClassWorkDetails(
    EncryptionProvider encrypt,
    String classworkid,
  ) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><classworkid>$classworkid</classworkid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getClassWorkDetails', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableLmsMember(
        successMessage: '',
        errorMessage: '',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
        classWorkDetailsData: state.classWorkDetailsData,
        lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
        comment: TextEditingController(),
        lmsgetcommentData: state.lmsgetcommentData,
        lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
        lmsfacultygetcommentData: state.lmsfacultygetcommentData,
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: state.mcqSheduleData,
        mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final lmsTitleRes =
          details['getClassWorkDetailsResponse'] as Map<String, dynamic>;
      final returnData = lmsTitleRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      var classWorkDetailsData = state.classWorkDetailsData;
      log('decrypted>>>>>>>>$decryptedData');

      try {
        final classWorkDetailsDataResponse =
            GetClassWorkDetailsModel.fromJson(decryptedData.mapData!);
        classWorkDetailsData = classWorkDetailsDataResponse.data!;
        state = state.copyWith(classWorkDetailsData: classWorkDetailsData);
        if (classWorkDetailsDataResponse.status == 'Success') {
          // state = LibraryTrancsactionStateSuccessful(
          //   successMessage: libraryTransactionDataResponse.status!,
          //   errorMessage: '',
          //   libraryTransactionData: state.libraryTransactionData,
          //   studentId: TextEditingController(),
          //   officeid: TextEditingController(),
          //   filter: TextEditingController(),
          // );
        } else if (classWorkDetailsDataResponse.status != 'Success') {
          state = LmsStateError(
            successMessage: '',
            errorMessage:
                '''${classWorkDetailsDataResponse.status!}, ${classWorkDetailsDataResponse.message!}''',
            lmsSubjectData: state.lmsSubjectData,
            lmsTitleData: state.lmsTitleData,
            classWorkDetailsData: state.classWorkDetailsData,
            lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
            comment: TextEditingController(),
            lmsgetcommentData: state.lmsgetcommentData,
            lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
            lmsfacultygetcommentData: state.lmsfacultygetcommentData,
            imagepath: TextEditingController(),
            remarks: TextEditingController(),
            action: TextEditingController(),
            mcqSheduleData: state.mcqSheduleData,
            mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = LmsStateError(
          successMessage: '',
          errorMessage: error.message!,
          lmsSubjectData: state.lmsSubjectData,
          lmsTitleData: state.lmsTitleData,
          classWorkDetailsData: state.classWorkDetailsData,
          lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
          comment: TextEditingController(),
          lmsgetcommentData: state.lmsgetcommentData,
          lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
          lmsfacultygetcommentData: state.lmsfacultygetcommentData,
          imagepath: TextEditingController(),
          remarks: TextEditingController(),
          action: TextEditingController(),
          mcqSheduleData: state.mcqSheduleData,
          mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
        );
      }
    } else if (response.$1 != 200) {
      state = LmsStateError(
        successMessage: '',
        errorMessage: 'Error',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
        classWorkDetailsData: state.classWorkDetailsData,
        lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
        comment: TextEditingController(),
        lmsgetcommentData: state.lmsgetcommentData,
        lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
        lmsfacultygetcommentData: state.lmsfacultygetcommentData,
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: state.mcqSheduleData,
        mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
      );
    }
  }

  Future<void> getLmsAttachmentDetails(
    EncryptionProvider encrypt,
    String classworkid,
  ) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><classworkid>$classworkid</classworkid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getAttachmentDetails', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableLmsMember(
        successMessage: '',
        errorMessage: '',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
        classWorkDetailsData: state.classWorkDetailsData,
        lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
        comment: TextEditingController(),
        lmsgetcommentData: state.lmsgetcommentData,
        lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
        lmsfacultygetcommentData: state.lmsfacultygetcommentData,
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: state.mcqSheduleData,
        mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final lmsTitleRes =
          details['getAttachmentDetailsResponse'] as Map<String, dynamic>;
      final returnData = lmsTitleRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      var lmsAttachmentDetailsData = state.lmsAttachmentDetailsData;
      // log('Attachment data >>>>>>>>$data');
      log('decrypted att data >>>>>>>>${decryptedData.mapData}');

      try {
        final lmsAttachmentDetailsDataResponse =
            GetAttachmentDetailsModel.fromJson(decryptedData.mapData!);
        lmsAttachmentDetailsData = lmsAttachmentDetailsDataResponse.data!;
        log('attachment Details>>>>>${lmsAttachmentDetailsData[0].imageBytes}');
        state =
            state.copyWith(lmsAttachmentDetailsData: lmsAttachmentDetailsData);
        if (lmsAttachmentDetailsDataResponse.status == 'Success') {
          // state = LibraryTrancsactionStateSuccessful(
          //   successMessage: libraryTransactionDataResponse.status!,
          //   errorMessage: '',
          //   libraryTransactionData: state.libraryTransactionData,
          //   studentId: TextEditingController(),
          //   officeid: TextEditingController(),
          //   filter: TextEditingController(),
          // );
        } else if (lmsAttachmentDetailsDataResponse.status != 'Success') {
          state = LmsStateError(
            successMessage: '',
            errorMessage:
                '''${lmsAttachmentDetailsDataResponse.status!}, ${lmsAttachmentDetailsDataResponse.message!}''',
            lmsSubjectData: state.lmsSubjectData,
            lmsTitleData: state.lmsTitleData,
            classWorkDetailsData: state.classWorkDetailsData,
            lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
            comment: TextEditingController(),
            lmsgetcommentData: state.lmsgetcommentData,
            lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
            lmsfacultygetcommentData: state.lmsfacultygetcommentData,
            imagepath: TextEditingController(),
            remarks: TextEditingController(),
            action: TextEditingController(),
            mcqSheduleData: state.mcqSheduleData,
            mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = LmsStateError(
          successMessage: '',
          errorMessage: error.message!,
          lmsSubjectData: state.lmsSubjectData,
          lmsTitleData: state.lmsTitleData,
          classWorkDetailsData: state.classWorkDetailsData,
          lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
          comment: TextEditingController(),
          lmsgetcommentData: state.lmsgetcommentData,
          lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
          lmsfacultygetcommentData: state.lmsfacultygetcommentData,
          imagepath: TextEditingController(),
          remarks: TextEditingController(),
          action: TextEditingController(),
          mcqSheduleData: state.mcqSheduleData,
          mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
        );
      }
    } else if (response.$1 != 200) {
      state = LmsStateError(
        successMessage: '',
        errorMessage: 'Error',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
        classWorkDetailsData: state.classWorkDetailsData,
        lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
        comment: TextEditingController(),
        lmsgetcommentData: state.lmsgetcommentData,
        lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
        lmsfacultygetcommentData: state.lmsfacultygetcommentData,
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: state.mcqSheduleData,
        mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
      );
    }
  }

  Future<void> saveCommentfield(
    EncryptionProvider encrypt,
    String classworkid,
  ) async {
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><classworkid>$classworkid</classworkid><cmttypeid>2</cmttypeid><comment>${state.comment}</comment>',
    );
    final response = await HttpService.sendSoapRequest('SaveComment', data);

    if (response.$1 == 0) {
      state = NoNetworkAvailableLmsMember(
        successMessage: '',
        errorMessage: '',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
        classWorkDetailsData: state.classWorkDetailsData,
        lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
        comment: TextEditingController(),
        lmsgetcommentData: state.lmsgetcommentData,
        lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
        lmsfacultygetcommentData: state.lmsfacultygetcommentData,
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: state.mcqSheduleData,
        mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final commentRes = details['SaveCommentResponse'] as Map<String, dynamic>;
      final returnData = commentRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      log('save comments >>${decryptedData.mapData}');

      state = LmsStateError(
        successMessage: '',
        errorMessage: '',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
        classWorkDetailsData: state.classWorkDetailsData,
        lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
        comment: TextEditingController(),
        lmsgetcommentData: state.lmsgetcommentData,
        lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
        lmsfacultygetcommentData: state.lmsfacultygetcommentData,
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: state.mcqSheduleData,
        mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
      );
    } else if (response.$1 != 200) {
      state = LmsStateSuccessful(
        successMessage: '',
        errorMessage: '',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
        classWorkDetailsData: state.classWorkDetailsData,
        lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
        comment: TextEditingController(),
        lmsgetcommentData: state.lmsgetcommentData,
        lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
        lmsfacultygetcommentData: state.lmsfacultygetcommentData,
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: state.mcqSheduleData,
        mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
      );
    }
  }

  Future<void> getLmscommentDetails(
    EncryptionProvider encrypt,
    String classworkid,
  ) async {
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><classworkid>$classworkid</classworkid><cmdtypeid>2</cmdtypeid>',
    );
    final response = await HttpService.sendSoapRequest('getComments', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableLmsMember(
        successMessage: '',
        errorMessage: '',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
        classWorkDetailsData: state.classWorkDetailsData,
        lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
        comment: TextEditingController(),
        lmsgetcommentData: state.lmsgetcommentData,
        lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
        lmsfacultygetcommentData: state.lmsfacultygetcommentData,
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: state.mcqSheduleData,
        mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final lmsTitleRes =
          details['getCommentsResponse'] as Map<String, dynamic>;
      final returnData = lmsTitleRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      var lmsgetcommentData = state.lmsgetcommentData;
      log('decrypted>>>>>>>>$decryptedData');

      try {
        final lmsCommentDetailsDataResponse =
            GetCommentModel.fromJson(decryptedData.mapData!);
        lmsgetcommentData = lmsCommentDetailsDataResponse.data!;
        state = state.copyWith(lmsgetcommentData: lmsgetcommentData);
        if (lmsCommentDetailsDataResponse.status == 'Success') {
          // state = LibraryTrancsactionStateSuccessful(
          //   successMessage: libraryTransactionDataResponse.status!,
          //   errorMessage: '',
          //   libraryTransactionData: state.libraryTransactionData,
          //   studentId: TextEditingController(),
          //   officeid: TextEditingController(),
          //   filter: TextEditingController(),
          // );
        } else if (lmsCommentDetailsDataResponse.status != 'Success') {
          state = LmsStateError(
            successMessage: '',
            errorMessage:
                '''${lmsCommentDetailsDataResponse.status!}, ${lmsCommentDetailsDataResponse.message!}''',
            lmsSubjectData: state.lmsSubjectData,
            lmsTitleData: state.lmsTitleData,
            classWorkDetailsData: state.classWorkDetailsData,
            lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
            comment: TextEditingController(),
            lmsgetcommentData: state.lmsgetcommentData,
            lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
            lmsfacultygetcommentData: state.lmsfacultygetcommentData,
            imagepath: TextEditingController(),
            remarks: TextEditingController(),
            action: TextEditingController(),
            mcqSheduleData: state.mcqSheduleData,
            mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = LmsStateError(
          successMessage: '',
          errorMessage: error.message!,
          lmsSubjectData: state.lmsSubjectData,
          lmsTitleData: state.lmsTitleData,
          classWorkDetailsData: state.classWorkDetailsData,
          lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
          comment: TextEditingController(),
          lmsgetcommentData: state.lmsgetcommentData,
          lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
          lmsfacultygetcommentData: state.lmsfacultygetcommentData,
          imagepath: TextEditingController(),
          remarks: TextEditingController(),
          action: TextEditingController(),
          mcqSheduleData: state.mcqSheduleData,
          mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
        );
      }
    } else if (response.$1 != 200) {
      state = LmsStateError(
        successMessage: '',
        errorMessage: 'Error',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
        classWorkDetailsData: state.classWorkDetailsData,
        lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
        comment: TextEditingController(),
        lmsgetcommentData: state.lmsgetcommentData,
        lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
        lmsfacultygetcommentData: state.lmsfacultygetcommentData,
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: state.mcqSheduleData,
        mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
      );
    }
  }

  Future<void> getLmsFacultycommentDetails(
    EncryptionProvider encrypt,
    String classworkid,
  ) async {
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><classworkid>$classworkid</classworkid><cmdtypeid>2</cmdtypeid>',
    );
    final response = await HttpService.sendSoapRequest('getComments', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableLmsMember(
        successMessage: '',
        errorMessage: '',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
        classWorkDetailsData: state.classWorkDetailsData,
        lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
        comment: TextEditingController(),
        lmsgetcommentData: state.lmsgetcommentData,
        lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
        lmsfacultygetcommentData: state.lmsfacultygetcommentData,
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: state.mcqSheduleData,
        mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final lmsTitleRes =
          details['getCommentsResponse'] as Map<String, dynamic>;
      final returnData = lmsTitleRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      var lmsfacultygetcommentData = state.lmsfacultygetcommentData;
      log('decrypted>>>>>>>>$decryptedData');

      try {
        final lmsFacultyCommentDetailsDataResponse =
            FacultyGetCommentModel.fromJson(decryptedData.mapData!);
        lmsfacultygetcommentData = lmsFacultyCommentDetailsDataResponse.data!;
        state =
            state.copyWith(lmsfacultygetcommentData: lmsfacultygetcommentData);
        if (lmsFacultyCommentDetailsDataResponse.status == 'Success') {
          // state = LibraryTrancsactionStateSuccessful(
          //   successMessage: libraryTransactionDataResponse.status!,
          //   errorMessage: '',
          //   libraryTransactionData: state.libraryTransactionData,
          //   studentId: TextEditingController(),
          //   officeid: TextEditingController(),
          //   filter: TextEditingController(),
          // );
        } else if (lmsFacultyCommentDetailsDataResponse.status != 'Success') {
          state = LmsStateError(
            successMessage: '',
            errorMessage:
                '''${lmsFacultyCommentDetailsDataResponse.status!}, ${lmsFacultyCommentDetailsDataResponse.message!}''',
            lmsSubjectData: state.lmsSubjectData,
            lmsTitleData: state.lmsTitleData,
            classWorkDetailsData: state.classWorkDetailsData,
            lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
            comment: TextEditingController(),
            lmsgetcommentData: state.lmsgetcommentData,
            lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
            lmsfacultygetcommentData: state.lmsfacultygetcommentData,
            imagepath: TextEditingController(),
            remarks: TextEditingController(),
            action: TextEditingController(),
            mcqSheduleData: state.mcqSheduleData,
            mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = LmsStateError(
          successMessage: '',
          errorMessage: error.message!,
          lmsSubjectData: state.lmsSubjectData,
          lmsTitleData: state.lmsTitleData,
          classWorkDetailsData: state.classWorkDetailsData,
          lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
          comment: TextEditingController(),
          lmsgetcommentData: state.lmsgetcommentData,
          lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
          lmsfacultygetcommentData: state.lmsfacultygetcommentData,
          imagepath: TextEditingController(),
          remarks: TextEditingController(),
          action: TextEditingController(),
          mcqSheduleData: state.mcqSheduleData,
          mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
        );
      }
    } else if (response.$1 != 200) {
      state = LmsStateError(
        successMessage: '',
        errorMessage: 'Error',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
        classWorkDetailsData: state.classWorkDetailsData,
        lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
        comment: TextEditingController(),
        lmsgetcommentData: state.lmsgetcommentData,
        lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
        lmsfacultygetcommentData: state.lmsfacultygetcommentData,
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: state.mcqSheduleData,
        mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
      );
    }
  }

  Future<void> getLmsReplayFacultycommentDetails(
    EncryptionProvider encrypt,
    String studentClsCmtId,
  ) async {
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><StudentClsCmtId>$studentClsCmtId</StudentClsCmtId>',
    );
    log('<studentid>${TokensManagement.studentId}</studentid><StudentClsCmtId>$studentClsCmtId</StudentClsCmtId>');

    final response =
        await HttpService.sendSoapRequest('getReplyComments', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableLmsMember(
        successMessage: '',
        errorMessage: '',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
        classWorkDetailsData: state.classWorkDetailsData,
        lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
        comment: TextEditingController(),
        lmsgetcommentData: state.lmsgetcommentData,
        lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
        lmsfacultygetcommentData: state.lmsfacultygetcommentData,
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: state.mcqSheduleData,
        mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final lmsTitleRes =
          details['getReplyCommentsResponse'] as Map<String, dynamic>;
      final returnData = lmsTitleRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      var lmsReplayfacultycommentData = state.lmsReplayfacultycommentData;
      log('reply provider data >>>>>>>>$data');

      try {
        final lmsfacultCommentDetailsDataResponse =
            ReplayFacultyComment.fromJson(decryptedData.mapData!);
        lmsReplayfacultycommentData = lmsfacultCommentDetailsDataResponse.data!;
        state = state.copyWith(
            lmsReplayfacultycommentData: lmsReplayfacultycommentData);
        if (lmsfacultCommentDetailsDataResponse.status == 'Success') {
          // state = LibraryTrancsactionStateSuccessful(
          //   successMessage: libraryTransactionDataResponse.status!,
          //   errorMessage: '',
          //   libraryTransactionData: state.libraryTransactionData,
          //   studentId: TextEditingController(),
          //   officeid: TextEditingController(),
          //   filter: TextEditingController(),
          // );
        } else if (lmsfacultCommentDetailsDataResponse.status != 'Success') {
          state = LmsStateError(
            successMessage: '',
            errorMessage:
                '''${lmsfacultCommentDetailsDataResponse.status!}, ${lmsfacultCommentDetailsDataResponse.message!}''',
            lmsSubjectData: state.lmsSubjectData,
            lmsTitleData: state.lmsTitleData,
            classWorkDetailsData: state.classWorkDetailsData,
            lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
            comment: TextEditingController(),
            lmsgetcommentData: state.lmsgetcommentData,
            lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
            lmsfacultygetcommentData: state.lmsfacultygetcommentData,
            imagepath: TextEditingController(),
            remarks: TextEditingController(),
            action: TextEditingController(),
            mcqSheduleData: state.mcqSheduleData,
            mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = LmsStateError(
          successMessage: '',
          errorMessage: error.message!,
          lmsSubjectData: state.lmsSubjectData,
          lmsTitleData: state.lmsTitleData,
          classWorkDetailsData: state.classWorkDetailsData,
          lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
          comment: TextEditingController(),
          lmsgetcommentData: state.lmsgetcommentData,
          lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
          lmsfacultygetcommentData: state.lmsfacultygetcommentData,
          imagepath: TextEditingController(),
          remarks: TextEditingController(),
          action: TextEditingController(),
          mcqSheduleData: state.mcqSheduleData,
          mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
        );
      }
    } else if (response.$1 != 200) {
      state = LmsStateError(
        successMessage: '',
        errorMessage: 'Error',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
        classWorkDetailsData: state.classWorkDetailsData,
        lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
        comment: TextEditingController(),
        lmsgetcommentData: state.lmsgetcommentData,
        lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
        lmsfacultygetcommentData: state.lmsfacultygetcommentData,
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: state.mcqSheduleData,
        mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
      );
    }
  }

  Future<void> saveClassWorkReplay(
    EncryptionProvider encrypt,
    String classworkid,
    String imageattachmentid,
    String classworkreplyid,
    String fieldrequirements,
    Uint8List imagepath,
  ) async {
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><imageattachmentid>$imageattachmentid</imageattachmentid><classworkid>$classworkid</classworkid><classworkreplyid>$classworkreplyid</classworkreplyid><remarks>${state.remarks.text}</remarks><fieldrequirements>$fieldrequirements</fieldrequirements><action>${state.action.text}</action><imageattachments>$imagepath</imageattachments>',
    );
    final response =
        await HttpService.sendSoapRequest('SaveClassWorkReply', data);
    log('<studentid>${TokensManagement.studentId}</studentid><imageattachmentid>$imageattachmentid</imageattachmentid><classworkid>$classworkid</classworkid><classworkreplyid>$classworkreplyid</classworkreplyid><remarks>${state.remarks.text}</remarks><fieldrequirements>$fieldrequirements</fieldrequirements><action>${state.action.text}</action><imageattachments>$imagepath</imageattachments>');

    if (response.$1 == 0) {
      state = NoNetworkAvailableLmsMember(
        successMessage: '',
        errorMessage: '',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
        classWorkDetailsData: state.classWorkDetailsData,
        lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
        comment: TextEditingController(),
        lmsgetcommentData: state.lmsgetcommentData,
        lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
        lmsfacultygetcommentData: state.lmsfacultygetcommentData,
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: state.mcqSheduleData,
        mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final commentRes =
          details['SaveClassWorkReplyResponse'] as Map<String, dynamic>;
      final returnData = commentRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      log('save work Replay >>${decryptedData.mapData}');
      log('save data Replay >>$data');

      state = LmsStateError(
        successMessage: '',
        errorMessage: '',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
        classWorkDetailsData: state.classWorkDetailsData,
        lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
        comment: TextEditingController(),
        lmsgetcommentData: state.lmsgetcommentData,
        lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
        lmsfacultygetcommentData: state.lmsfacultygetcommentData,
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: state.mcqSheduleData,
        mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
      );
    } else if (response.$1 != 200) {
      state = LmsStateSuccessful(
        successMessage: '',
        errorMessage: '',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
        classWorkDetailsData: state.classWorkDetailsData,
        lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
        comment: TextEditingController(),
        lmsgetcommentData: state.lmsgetcommentData,
        lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
        lmsfacultygetcommentData: state.lmsfacultygetcommentData,
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: state.mcqSheduleData,
        mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
      );
    }
  }

  Future<void> getLmsMcqSheduleDetails(
    EncryptionProvider encrypt,
    String mcqscheduleid,
  ) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><mcqscheduleid>$mcqscheduleid</mcqscheduleid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getMCQExamScheduleDetails', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableLmsMember(
        successMessage: '',
        errorMessage: '',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
        classWorkDetailsData: state.classWorkDetailsData,
        lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
        comment: TextEditingController(),
        lmsgetcommentData: state.lmsgetcommentData,
        lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
        lmsfacultygetcommentData: state.lmsfacultygetcommentData,
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: state.mcqSheduleData,
        mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final lmsmcqsheduleRes =
          details['getMCQExamScheduleDetailsResponse'] as Map<String, dynamic>;
      final returnData = lmsmcqsheduleRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      var mcqSheduleData = state.mcqSheduleData;
      log('decrypted>>>>>>>>$decryptedData');
      log('mcq shedule data >>>>>>>>$data');

      try {
        final mcqsheduleDataResponse =
            McqSheduleModel.fromJson(decryptedData.mapData!);
        mcqSheduleData = mcqsheduleDataResponse.data!;
        state = state.copyWith(mcqSheduleData: mcqSheduleData);
        if (mcqsheduleDataResponse.status == 'Success') {
          // state = LibraryTrancsactionStateSuccessful(
          //   successMessage: libraryTransactionDataResponse.status!,
          //   errorMessage: '',
          //   libraryTransactionData: state.libraryTransactionData,
          //   studentId: TextEditingController(),
          //   officeid: TextEditingController(),
          //   filter: TextEditingController(),
          // );
        } else if (mcqsheduleDataResponse.status != 'Success') {
          state = LmsStateError(
            successMessage: '',
            errorMessage:
                '''${mcqsheduleDataResponse.status!}, ${mcqsheduleDataResponse.message!}''',
            lmsSubjectData: state.lmsSubjectData,
            lmsTitleData: state.lmsTitleData,
            classWorkDetailsData: state.classWorkDetailsData,
            lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
            comment: TextEditingController(),
            lmsgetcommentData: state.lmsgetcommentData,
            lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
            lmsfacultygetcommentData: state.lmsfacultygetcommentData,
            imagepath: TextEditingController(),
            remarks: TextEditingController(),
            action: TextEditingController(),
            mcqSheduleData: state.mcqSheduleData,
            mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = LmsStateError(
          successMessage: '',
          errorMessage: error.message!,
          lmsSubjectData: state.lmsSubjectData,
          lmsTitleData: state.lmsTitleData,
          classWorkDetailsData: state.classWorkDetailsData,
          lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
          comment: TextEditingController(),
          lmsgetcommentData: state.lmsgetcommentData,
          lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
          lmsfacultygetcommentData: state.lmsfacultygetcommentData,
          imagepath: TextEditingController(),
          remarks: TextEditingController(),
          action: TextEditingController(),
          mcqSheduleData: state.mcqSheduleData,
          mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
        );
      }
    } else if (response.$1 != 200) {
      state = LmsStateError(
        successMessage: '',
        errorMessage: 'Error',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
        classWorkDetailsData: state.classWorkDetailsData,
        lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
        comment: TextEditingController(),
        lmsgetcommentData: state.lmsgetcommentData,
        lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
        lmsfacultygetcommentData: state.lmsfacultygetcommentData,
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: state.mcqSheduleData,
        mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
      );
    }
  }

  Future<void> getLmsMcqQuestionandAnswerDetails(
    EncryptionProvider encrypt,
    String mcqtemplateid,
    String mcqscheduleid,
    String subjectid,
    String noofquestions,
  ) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><mcqtemplateid>$mcqtemplateid</mcqtemplateid><mcqscheduleid>$mcqscheduleid</mcqscheduleid><subjectid>$subjectid</subjectid><noofquestions>$noofquestions</noofquestions>',
    );
    log(
      '<studentid>${TokensManagement.studentId}</studentid><mcqtemplateid>$mcqtemplateid</mcqtemplateid><mcqscheduleid>$mcqscheduleid</mcqscheduleid><subjectid>$subjectid</subjectid><noofquestions>$noofquestions</noofquestions>',
    );
    final response =
        await HttpService.sendSoapRequest('getQuestionsandAnswers', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableLmsMember(
        successMessage: '',
        errorMessage: '',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
        classWorkDetailsData: state.classWorkDetailsData,
        lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
        comment: TextEditingController(),
        lmsgetcommentData: state.lmsgetcommentData,
        lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
        lmsfacultygetcommentData: state.lmsfacultygetcommentData,
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: state.mcqSheduleData,
        mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final lmsmcqsheduleRes =
          details['getQuestionsandAnswersResponse'] as Map<String, dynamic>;
      final returnData = lmsmcqsheduleRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      var mcqQuestionAndAnswerData = state.mcqQuestionAndAnswerData;
      log('decrypted>>>>>>>>$decryptedData');
      log('mcq Question & Answer data >>>>>>>>$data');

      try {
        final mcqQuestionandAnswerDataResponse =
            McqQuestionandAnswerModel.fromJson(decryptedData.mapData!);
        mcqQuestionAndAnswerData = mcqQuestionandAnswerDataResponse.data!;
        state =
            state.copyWith(mcqQuestionAndAnswerData: mcqQuestionAndAnswerData);
        if (mcqQuestionandAnswerDataResponse.status == 'Success') {
          // state = LibraryTrancsactionStateSuccessful(
          //   successMessage: libraryTransactionDataResponse.status!,
          //   errorMessage: '',
          //   libraryTransactionData: state.libraryTransactionData,
          //   studentId: TextEditingController(),
          //   officeid: TextEditingController(),
          //   filter: TextEditingController(),
          // );
        } else if (mcqQuestionandAnswerDataResponse.status != 'Success') {
          state = LmsStateError(
            successMessage: '',
            errorMessage:
                '''${mcqQuestionandAnswerDataResponse.status!}, ${mcqQuestionandAnswerDataResponse.message!}''',
            lmsSubjectData: state.lmsSubjectData,
            lmsTitleData: state.lmsTitleData,
            classWorkDetailsData: state.classWorkDetailsData,
            lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
            comment: TextEditingController(),
            lmsgetcommentData: state.lmsgetcommentData,
            lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
            lmsfacultygetcommentData: state.lmsfacultygetcommentData,
            imagepath: TextEditingController(),
            remarks: TextEditingController(),
            action: TextEditingController(),
            mcqSheduleData: state.mcqSheduleData,
            mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = LmsStateError(
          successMessage: '',
          errorMessage: error.message!,
          lmsSubjectData: state.lmsSubjectData,
          lmsTitleData: state.lmsTitleData,
          classWorkDetailsData: state.classWorkDetailsData,
          lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
          comment: TextEditingController(),
          lmsgetcommentData: state.lmsgetcommentData,
          lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
          lmsfacultygetcommentData: state.lmsfacultygetcommentData,
          imagepath: TextEditingController(),
          remarks: TextEditingController(),
          action: TextEditingController(),
          mcqSheduleData: state.mcqSheduleData,
          mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
        );
      }
    } else if (response.$1 != 200) {
      state = LmsStateError(
        successMessage: '',
        errorMessage: 'Error',
        lmsSubjectData: state.lmsSubjectData,
        lmsTitleData: state.lmsTitleData,
        classWorkDetailsData: state.classWorkDetailsData,
        lmsAttachmentDetailsData: state.lmsAttachmentDetailsData,
        comment: TextEditingController(),
        lmsgetcommentData: state.lmsgetcommentData,
        lmsReplayfacultycommentData: state.lmsReplayfacultycommentData,
        lmsfacultygetcommentData: state.lmsfacultygetcommentData,
        imagepath: TextEditingController(),
        remarks: TextEditingController(),
        action: TextEditingController(),
        mcqSheduleData: state.mcqSheduleData,
        mcqQuestionAndAnswerData: state.mcqQuestionAndAnswerData,
      );
    }
  }
}

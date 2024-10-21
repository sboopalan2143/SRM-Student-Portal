import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_classworkdetails_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_getAttachmentDetails_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_getSubject_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_get_comment_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_gettitle_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_replay_faculty_comment_model.dart';
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
        lmsgetfacultycommentData: <ReplayFacultyCommentData>[],
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
        lmsgetfacultycommentData: <ReplayFacultyCommentData>[],
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
        lmsgetfacultycommentData: state.lmsgetfacultycommentData,
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
            lmsgetfacultycommentData: state.lmsgetfacultycommentData,
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
          lmsgetfacultycommentData: state.lmsgetfacultycommentData,
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
        lmsgetfacultycommentData: state.lmsgetfacultycommentData,
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
        lmsgetfacultycommentData: state.lmsgetfacultycommentData,
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
            lmsgetfacultycommentData: state.lmsgetfacultycommentData,
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
          lmsgetfacultycommentData: state.lmsgetfacultycommentData,
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
        lmsgetfacultycommentData: state.lmsgetfacultycommentData,
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
        lmsgetfacultycommentData: state.lmsgetfacultycommentData,
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
            lmsgetfacultycommentData: state.lmsgetfacultycommentData,
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
          lmsgetfacultycommentData: state.lmsgetfacultycommentData,
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
        lmsgetfacultycommentData: state.lmsgetfacultycommentData,
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
        lmsgetfacultycommentData: state.lmsgetfacultycommentData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final lmsTitleRes =
          details['getAttachmentDetailsResponse'] as Map<String, dynamic>;
      final returnData = lmsTitleRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      var lmsAttachmentDetailsData = state.lmsAttachmentDetailsData;
      log('decrypted>>>>>>>>$decryptedData');

      try {
        final lmsAttachmentDetailsDataResponse =
            GetAttachmentDetailsModel.fromJson(decryptedData.mapData!);
        lmsAttachmentDetailsData = lmsAttachmentDetailsDataResponse.data!;
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
            lmsgetfacultycommentData: state.lmsgetfacultycommentData,
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
          lmsgetfacultycommentData: state.lmsgetfacultycommentData,
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
        lmsgetfacultycommentData: state.lmsgetfacultycommentData,
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
        lmsgetfacultycommentData: state.lmsgetfacultycommentData,
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
        lmsgetfacultycommentData: state.lmsgetfacultycommentData,
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
        lmsgetfacultycommentData: state.lmsgetfacultycommentData,
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
        lmsgetfacultycommentData: state.lmsgetfacultycommentData,
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
            lmsgetfacultycommentData: state.lmsgetfacultycommentData,
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
          lmsgetfacultycommentData: state.lmsgetfacultycommentData,
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
        lmsgetfacultycommentData: state.lmsgetfacultycommentData,
      );
    }
  }

  Future<void> getLmsFacultycommentDetails(
    EncryptionProvider encrypt,
    String studentClsCmtId,
  ) async {
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><StudentClsCmtId>$studentClsCmtId</StudentClsCmtId>',
    );
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
        lmsgetfacultycommentData: state.lmsgetfacultycommentData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final lmsTitleRes =
          details['getReplyCommentsResponse'] as Map<String, dynamic>;
      final returnData = lmsTitleRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      var lmsgetfacultycommentData = state.lmsgetfacultycommentData;
      log('decrypted>>>>>>>>$decryptedData');

      try {
        final lmsfacultCommentDetailsDataResponse =
            ReplayFacultyComment.fromJson(decryptedData.mapData!);
        lmsgetfacultycommentData = lmsfacultCommentDetailsDataResponse.data!;
        state =
            state.copyWith(lmsgetfacultycommentData: lmsgetfacultycommentData);
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
            lmsgetfacultycommentData: state.lmsgetfacultycommentData,
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
          lmsgetfacultycommentData: state.lmsgetfacultycommentData,
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
        lmsgetfacultycommentData: state.lmsgetfacultycommentData,
      );
    }
  }
}

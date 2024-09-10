import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_state.dart';
import 'package:sample/home/main_pages/library/model/library_member_response_model.dart';

class HostelProvider extends StateNotifier<HostelState> {
  HostelProvider() : super(HostelInitial());

  void disposeState() => state = HostelInitial();

  void _setLoading() => state = HostelStateLoading(
        successMessage: '',
        errorMessage: '',
        hospitalData: <dynamic>[],
        academicYearId: TextEditingController(),
        roomTypeId: TextEditingController(),
        hostelId: TextEditingController(),
        controllerId: TextEditingController(),
        officeId: TextEditingController(),
      );

  Future<void> getHostelDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>21f84947bd6aa060</deviceid><accesstoken>TR</accesstoken><androidversion>TR</androidversion><model>TR</model><sdkversion>TR</sdkversion><appversion>TR</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getHostelDetails', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableHostel(
        successMessage: '',
        errorMessage: '',
        hospitalData: <dynamic>[],
        academicYearId: TextEditingController(),
        roomTypeId: TextEditingController(),
        hostelId: TextEditingController(),
        controllerId: TextEditingController(),
        officeId: TextEditingController(),
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRes =
          details['getHostelDetailsResponse'] as Map<String, dynamic>;
      final returnData = hostelRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      log('decrypted>>>>>>>>$decryptedData');
//change model
      try {
        final hostelDataResponse =
            LibraryMemberResponseModel.fromJson(decryptedData.mapData!);
        // hostelDetails = hostelDataResponse.data![0];
        // state = state.copyWith(libraryMemberData: libraryMemberDetails);
        if (hostelDataResponse.status == 'Success') {
          state = HostelStateSuccessful(
            successMessage: hostelDataResponse.status!,
            errorMessage: '',
            hospitalData: <dynamic>[],
            academicYearId: TextEditingController(),
            roomTypeId: TextEditingController(),
            hostelId: TextEditingController(),
            controllerId: TextEditingController(),
            officeId: TextEditingController(),
          );
        } else if (hostelDataResponse.status != 'Success') {
          state = HostelStateError(
            successMessage: '',
            errorMessage: hostelDataResponse.status!,
            hospitalData: <dynamic>[],
            academicYearId: TextEditingController(),
            roomTypeId: TextEditingController(),
            hostelId: TextEditingController(),
            controllerId: TextEditingController(),
            officeId: TextEditingController(),
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = HostelStateError(
          successMessage: '',
          errorMessage: error.message!,
          hospitalData: <dynamic>[],
          academicYearId: TextEditingController(),
          roomTypeId: TextEditingController(),
          hostelId: TextEditingController(),
          controllerId: TextEditingController(),
          officeId: TextEditingController(),
        );
      }
    } else if (response.$1 != 200) {
      state = HostelStateError(
        successMessage: '',
        errorMessage: 'Error',
        hospitalData: <dynamic>[],
        academicYearId: TextEditingController(),
        roomTypeId: TextEditingController(),
        hostelId: TextEditingController(),
        controllerId: TextEditingController(),
        officeId: TextEditingController(),
      );
    }
  }

  Future<void> hostelRegister(EncryptionProvider encrypt) async {
    log(
      'body>>>>>>>>><studentid>${TokensManagement.studentId}</studentid><academicyearid>${state.academicYearId.text}</academicyearid><roomtypeid>${state.roomTypeId.text}</roomtypeid><hostelid>${state.hostelId.text}</hostelid><controllerid>${state.controllerId.text}</controllerid><officeid>${state.officeId.text}</officeid><semesterid>${TokensManagement.semesterId}</semesterid>',
    );
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><academicyearid>${state.academicYearId.text}</academicyearid><roomtypeid>${state.roomTypeId.text}</roomtypeid><hostelid>${state.hostelId.text}</hostelid><controllerid>${state.controllerId.text}</controllerid><officeid>${state.officeId.text}</officeid><semesterid>${TokensManagement.semesterId}</semesterid>',
    );
    final response = await HttpService.sendSoapRequest('getRegister', data);

    if (response.$1 == 0) {
      state = NoNetworkAvailableHostel(
        successMessage: '',
        errorMessage: '',
        hospitalData: <dynamic>[],
        academicYearId: TextEditingController(),
        roomTypeId: TextEditingController(),
        hostelId: TextEditingController(),
        controllerId: TextEditingController(),
        officeId: TextEditingController(),
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRegisterRes =
          details['getRegisterResponse'] as Map<String, dynamic>;
      final returnData = hostelRegisterRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      log('data>>>>>$data');
      final decryptedData = encrypt.getDecryptedData('$data');
      log('status>>>>>>>>${decryptedData.mapData!['Status']}');
      if (decryptedData.mapData!['Status'] == 'Success') {
        state = HostelStateSuccessful(
          successMessage: '${decryptedData.mapData!['Status']}',
          errorMessage: '',
          hospitalData: <dynamic>[],
          academicYearId: TextEditingController(),
          roomTypeId: TextEditingController(),
          hostelId: TextEditingController(),
          controllerId: TextEditingController(),
          officeId: TextEditingController(),
        );
      } else {
        state = HostelStateError(
          successMessage: '',
          errorMessage: '${decryptedData.mapData!['Status']}',
          hospitalData: state.hospitalData,
          academicYearId: state.academicYearId,
          roomTypeId: state.roomTypeId,
          hostelId: state.hostelId,
          controllerId: state.controllerId,
          officeId: state.officeId,
        );
      }
    } else if (response.$1 != 200) {
      state = HostelStateError(
        successMessage: '',
        errorMessage: 'Error',
        hospitalData: state.hospitalData,
        academicYearId: state.academicYearId,
        roomTypeId: state.roomTypeId,
        hostelId: state.hostelId,
        controllerId: state.controllerId,
        officeId: state.officeId,
      );
    }
  }

  Future<void> gethostel(EncryptionProvider encrypt) async {
    log(
      'body>>>>>>>>><studentid>${TokensManagement.studentId}</studentid><academicyearid>${state.academicYearId.text}</academicyearid><roomtypeid>${state.roomTypeId.text}</roomtypeid><hostelid>${state.hostelId.text}</hostelid><controllerid>${state.controllerId.text}</controllerid><officeid>${state.officeId.text}</officeid><semesterid>${TokensManagement.semesterId}</semesterid>',
    );
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><semesterid>${TokensManagement.semesterId}</semesterid>',
    );
    final response = await HttpService.sendSoapRequest('getHostel', data);

    if (response.$1 == 0) {
      state = NoNetworkAvailableHostel(
        successMessage: '',
        errorMessage: '',
        hospitalData: <dynamic>[],
        academicYearId: TextEditingController(),
        roomTypeId: TextEditingController(),
        hostelId: TextEditingController(),
        controllerId: TextEditingController(),
        officeId: TextEditingController(),
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRes = details['getHostelResponse'] as Map<String, dynamic>;
      final returnData = hostelRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      log('data>>>>>$data');
      final decryptedData = encrypt.getDecryptedData('$data');
      log('status>>>>>>>>${decryptedData.mapData!['Status']}');
      if (decryptedData.mapData!['Status'] == 'Success') {
        state = HostelStateSuccessful(
          successMessage: '${decryptedData.mapData!['Status']}',
          errorMessage: '',
          hospitalData: <dynamic>[],
          academicYearId: TextEditingController(),
          roomTypeId: TextEditingController(),
          hostelId: TextEditingController(),
          controllerId: TextEditingController(),
          officeId: TextEditingController(),
        );
      } else {
        state = HostelStateError(
          successMessage: '',
          errorMessage: '${decryptedData.mapData!['Status']}',
          hospitalData: state.hospitalData,
          academicYearId: state.academicYearId,
          roomTypeId: state.roomTypeId,
          hostelId: state.hostelId,
          controllerId: state.controllerId,
          officeId: state.officeId,
        );
      }
    } else if (response.$1 != 200) {
      state = HostelStateError(
        successMessage: '',
        errorMessage: 'Error',
        hospitalData: state.hospitalData,
        academicYearId: state.academicYearId,
        roomTypeId: state.roomTypeId,
        hostelId: state.hostelId,
        controllerId: state.controllerId,
        officeId: state.officeId,
      );
    }
  }

  Future<void> getRoomType(EncryptionProvider encrypt) async {
    log(
      'body>>>>>>>>><studentid>${TokensManagement.studentId}</studentid><academicyearid>${state.academicYearId.text}</academicyearid><roomtypeid>${state.roomTypeId.text}</roomtypeid><hostelid>${state.hostelId.text}</hostelid><controllerid>${state.controllerId.text}</controllerid><officeid>${state.officeId.text}</officeid><semesterid>${TokensManagement.semesterId}</semesterid>',
    );
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><semesterid>${TokensManagement.semesterId}</semesterid><hostelid>${state.hostelId.text}</hostelid>',
    );
    final response = await HttpService.sendSoapRequest('getRoomType', data);

    if (response.$1 == 0) {
      state = NoNetworkAvailableHostel(
        successMessage: '',
        errorMessage: '',
        hospitalData: <dynamic>[],
        academicYearId: TextEditingController(),
        roomTypeId: TextEditingController(),
        hostelId: TextEditingController(),
        controllerId: TextEditingController(),
        officeId: TextEditingController(),
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRes = details['getRoomTypeResponse'] as Map<String, dynamic>;
      final returnData = hostelRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      log('data>>>>>$data');
      final decryptedData = encrypt.getDecryptedData('$data');
      log('status>>>>>>>>${decryptedData.mapData!['Status']}');
      if (decryptedData.mapData!['Status'] == 'Success') {
        state = HostelStateSuccessful(
          successMessage: '${decryptedData.mapData!['Status']}',
          errorMessage: '',
          hospitalData: <dynamic>[],
          academicYearId: TextEditingController(),
          roomTypeId: TextEditingController(),
          hostelId: TextEditingController(),
          controllerId: TextEditingController(),
          officeId: TextEditingController(),
        );
      } else {
        state = HostelStateError(
          successMessage: '',
          errorMessage: '${decryptedData.mapData!['Status']}',
          hospitalData: state.hospitalData,
          academicYearId: state.academicYearId,
          roomTypeId: state.roomTypeId,
          hostelId: state.hostelId,
          controllerId: state.controllerId,
          officeId: state.officeId,
        );
      }
    } else if (response.$1 != 200) {
      state = HostelStateError(
        successMessage: '',
        errorMessage: 'Error',
        hospitalData: state.hospitalData,
        academicYearId: state.academicYearId,
        roomTypeId: state.roomTypeId,
        hostelId: state.hostelId,
        controllerId: state.controllerId,
        officeId: state.officeId,
      );
    }
  }
}

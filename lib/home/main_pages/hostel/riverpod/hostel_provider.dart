import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_details_model.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_after_register_model.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_before_register_model.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_model.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_leave_application_model.dart';
import 'package:sample/home/main_pages/hostel/model/room_type_model.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_state.dart';

class HostelProvider extends StateNotifier<HostelState> {
  HostelProvider() : super(HostelInitial());

  void disposeState() => state = HostelInitial();

  void _setLoading() => state = HostelStateLoading(
        successMessage: '',
        errorMessage: '',
        hostelData: <HostelData>[],
        selectedHostelData: HostelData.empty,
        roomTypeData: <RoomTypeData>[],
        selectedRoomTypeData: RoomTypeData.empty,
        hostelRegisterDetails: HostelRegisterData.empty,
        hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
        gethostelData: <GetHostelData>[],
        fromDate: TextEditingController(),
        toDate: TextEditingController(),
        leaveReason: TextEditingController(),
        hostelLeaveData: <HostelLeaveData>[],
      );

  Future<void> getHostelDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getHostelDetails', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableHostel(
        successMessage: '',
        errorMessage: '',
        hostelData: <HostelData>[],
        selectedHostelData: HostelData.empty,
        roomTypeData: <RoomTypeData>[],
        selectedRoomTypeData: RoomTypeData.empty,
        hostelRegisterDetails: HostelRegisterData.empty,
        hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
        gethostelData: <GetHostelData>[],
        fromDate: TextEditingController(),
        toDate: TextEditingController(),
        leaveReason: TextEditingController(),
        hostelLeaveData: <HostelLeaveData>[],
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final gethostelRes =
          details['getHostelDetailsResponse'] as Map<String, dynamic>;
      final returnData = gethostelRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      var gethostelData = <GetHostelData>[];
      log('decrypted>>>>>>>>$decryptedData');

      try {
        final gethosteldetailsResponse =
            GetHostelDetailsModel.fromJson(decryptedData.mapData!);
        gethostelData = gethosteldetailsResponse.data!;
        state = state.copyWith(gethostelData: gethostelData);
        if (gethosteldetailsResponse.status == 'Success') {
          state = HostelStateSuccessful(
            successMessage: '${decryptedData.mapData!['Status']}',
            errorMessage: '',
            hostelData: state.hostelData,
            selectedHostelData: HostelData.empty,
            roomTypeData: <RoomTypeData>[],
            selectedRoomTypeData: RoomTypeData.empty,
            hostelRegisterDetails: state.hostelRegisterDetails,
            hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
            gethostelData: state.gethostelData,
            fromDate: TextEditingController(),
            toDate: TextEditingController(),
            leaveReason: TextEditingController(),
            hostelLeaveData: <HostelLeaveData>[],
          );
        } else if (gethosteldetailsResponse.status != 'Success') {
          state = HostelStateError(
            successMessage: '',
            errorMessage: gethosteldetailsResponse.status!,
            hostelData: <HostelData>[],
            selectedHostelData: HostelData.empty,
            roomTypeData: <RoomTypeData>[],
            selectedRoomTypeData: RoomTypeData.empty,
            hostelRegisterDetails: HostelRegisterData.empty,
            hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
            gethostelData: <GetHostelData>[],
            fromDate: TextEditingController(),
            toDate: TextEditingController(),
            leaveReason: TextEditingController(),
            hostelLeaveData: <HostelLeaveData>[],
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = HostelStateError(
          successMessage: '',
          errorMessage: error.message!,
          hostelData: <HostelData>[],
          selectedHostelData: HostelData.empty,
          roomTypeData: <RoomTypeData>[],
          selectedRoomTypeData: RoomTypeData.empty,
          hostelRegisterDetails: HostelRegisterData.empty,
          hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
          gethostelData: <GetHostelData>[],
          fromDate: TextEditingController(),
          toDate: TextEditingController(),
          leaveReason: TextEditingController(),
          hostelLeaveData: <HostelLeaveData>[],
        );
      }
    } else if (response.$1 != 200) {
      state = HostelStateError(
        successMessage: '',
        errorMessage: 'Error',
        hostelData: <HostelData>[],
        selectedHostelData: HostelData.empty,
        roomTypeData: <RoomTypeData>[],
        selectedRoomTypeData: RoomTypeData.empty,
        hostelRegisterDetails: HostelRegisterData.empty,
        hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
        gethostelData: <GetHostelData>[],
        fromDate: TextEditingController(),
        toDate: TextEditingController(),
        leaveReason: TextEditingController(),
        hostelLeaveData: <HostelLeaveData>[],
      );
    }
  }

  Future<void> hostelRegister(EncryptionProvider encrypt) async {
    log(
      'body>>>>>>>>><studentid>${TokensManagement.studentId}</studentid><academicyearid>${state.hostelRegisterDetails!.academicyearid}</academicyearid><roomtypeid>${state.selectedRoomTypeData.roomtypeid}</roomtypeid><hostelid>${state.selectedHostelData.hostelid}</hostelid><controllerid>${state.hostelRegisterDetails!.controllerid}</controllerid><officeid>${TokensManagement.officeId}</officeid><semesterid>${TokensManagement.semesterId}</semesterid>',
    );
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><academicyearid>${state.hostelRegisterDetails!.academicyearid}</academicyearid><roomtypeid>${state.selectedRoomTypeData.roomtypeid}</roomtypeid><hostelid>${state.selectedHostelData.hostelid}</hostelid><controllerid>${state.hostelRegisterDetails!.controllerid}</controllerid><officeid>${TokensManagement.officeId}</officeid><semesterid>${TokensManagement.semesterId}</semesterid>',
    );
    final response = await HttpService.sendSoapRequest('getRegister', data);

    if (response.$1 == 0) {
      state = NoNetworkAvailableHostel(
        successMessage: '',
        errorMessage: 'No Internet',
        hostelData: state.hostelData,
        selectedHostelData: state.selectedHostelData,
        roomTypeData: state.roomTypeData,
        selectedRoomTypeData: state.selectedRoomTypeData,
        hostelRegisterDetails: state.hostelRegisterDetails,
        hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
        gethostelData: state.gethostelData,
        fromDate: TextEditingController(),
        toDate: TextEditingController(),
        leaveReason: TextEditingController(),
        hostelLeaveData: <HostelLeaveData>[],
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
          hostelData: state.hostelData,
          selectedHostelData: HostelData.empty,
          roomTypeData: <RoomTypeData>[],
          selectedRoomTypeData: RoomTypeData.empty,
          hostelRegisterDetails: state.hostelRegisterDetails,
          hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
          gethostelData: state.gethostelData,
          fromDate: TextEditingController(),
          toDate: TextEditingController(),
          leaveReason: TextEditingController(),
          hostelLeaveData: <HostelLeaveData>[],
        );
      } else {
        state = HostelStateError(
          successMessage: '',
          errorMessage: '${decryptedData.mapData!['Status']}',
          hostelData: state.hostelData,
          selectedHostelData: state.selectedHostelData,
          roomTypeData: state.roomTypeData,
          selectedRoomTypeData: state.selectedRoomTypeData,
          hostelRegisterDetails: state.hostelRegisterDetails,
          hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
          gethostelData: state.gethostelData,
          fromDate: TextEditingController(),
          toDate: TextEditingController(),
          leaveReason: TextEditingController(),
          hostelLeaveData: <HostelLeaveData>[],
        );
      }
    } else if (response.$1 != 200) {
      state = HostelStateError(
        successMessage: '',
        errorMessage: 'Error',
        hostelData: state.hostelData,
        selectedHostelData: state.selectedHostelData,
        roomTypeData: state.roomTypeData,
        selectedRoomTypeData: state.selectedRoomTypeData,
        hostelRegisterDetails: state.hostelRegisterDetails,
        hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
        gethostelData: state.gethostelData,
        fromDate: TextEditingController(),
        toDate: TextEditingController(),
        leaveReason: TextEditingController(),
        hostelLeaveData: <HostelLeaveData>[],
      );
    }
  }

  void setHostelValue(HostelData data, EncryptionProvider encrypt) {
    state = state.copyWith(selectedHostelData: data);
    getRoomType(
      encrypt,
      state.selectedHostelData.hostelid!,
    );
  }

  void setRoomTypeValue(RoomTypeData data) {
    state = state.copyWith(selectedRoomTypeData: data);
  }

  Future<void> gethostel(EncryptionProvider encrypt) async {
    _setLoading();
    log('enters hostel api');
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><semesterid>${TokensManagement.semesterId}</semesterid>',
    );
    final response = await HttpService.sendSoapRequest('getHostel', data);

    if (response.$1 == 0) {
      state = NoNetworkAvailableHostel(
        successMessage: '',
        errorMessage: 'No Internet',
        hostelData: <HostelData>[],
        selectedHostelData: HostelData.empty,
        roomTypeData: <RoomTypeData>[],
        selectedRoomTypeData: RoomTypeData.empty,
        hostelRegisterDetails: state.hostelRegisterDetails,
        hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
        gethostelData: <GetHostelData>[],
        fromDate: TextEditingController(),
        toDate: TextEditingController(),
        leaveReason: TextEditingController(),
        hostelLeaveData: <HostelLeaveData>[],
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRes = details['getHostelResponse'] as Map<String, dynamic>;
      final returnData = hostelRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];

      final decryptedData = encrypt.getDecryptedData('$data');
      var hostelData = <HostelData>[];
      try {
        final hostelDataResponse = HostelModel.fromJson(decryptedData.mapData!);
        hostelData = hostelDataResponse.data!;
        state = state.copyWith(hostelData: hostelData);

        if (decryptedData.mapData!['Status'] == 'Success') {
        } else {
          state = HostelStateError(
            successMessage: '',
            errorMessage: '${decryptedData.mapData!['Status']}',
            hostelData: state.hostelData,
            selectedHostelData: HostelData.empty,
            roomTypeData: <RoomTypeData>[],
            selectedRoomTypeData: RoomTypeData.empty,
            hostelRegisterDetails: state.hostelRegisterDetails,
            hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
            gethostelData: state.gethostelData,
            fromDate: TextEditingController(),
            toDate: TextEditingController(),
            leaveReason: TextEditingController(),
            hostelLeaveData: <HostelLeaveData>[],
          );
        }
      } catch (e) {
        log('enters here');
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = HostelStateError(
          successMessage: '',
          errorMessage: error.message!,
          hostelData: state.hostelData,
          selectedHostelData: HostelData.empty,
          roomTypeData: <RoomTypeData>[],
          selectedRoomTypeData: RoomTypeData.empty,
          hostelRegisterDetails: state.hostelRegisterDetails,
          hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
          gethostelData: state.gethostelData,
          fromDate: TextEditingController(),
          toDate: TextEditingController(),
          leaveReason: TextEditingController(),
          hostelLeaveData: <HostelLeaveData>[],
        );
      }
    } else if (response.$1 != 200) {
      state = HostelStateError(
        successMessage: '',
        errorMessage: 'Error',
        hostelData: state.hostelData,
        selectedHostelData: HostelData.empty,
        roomTypeData: <RoomTypeData>[],
        selectedRoomTypeData: RoomTypeData.empty,
        hostelRegisterDetails: state.hostelRegisterDetails,
        hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
        gethostelData: state.gethostelData,
        fromDate: TextEditingController(),
        toDate: TextEditingController(),
        leaveReason: TextEditingController(),
        hostelLeaveData: <HostelLeaveData>[],
      );
    }
  }

  Future<void> getRoomType(EncryptionProvider encrypt, String hostelId) async {
    log('hostelid >>>$hostelId');
    log('Room type data>>>>>>>>>>><studentid>${TokensManagement.studentId}</studentid><semesterid>${TokensManagement.semesterId}</semesterid><hostelid>$hostelId</hostelid>');
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><semesterid>${TokensManagement.semesterId}</semesterid><hostelid>$hostelId</hostelid>',
    );
    final response = await HttpService.sendSoapRequest('getRoomType', data);

    if (response.$1 == 0) {
      state = NoNetworkAvailableHostel(
        successMessage: '',
        errorMessage: 'No Internet',
        hostelData: state.hostelData,
        selectedHostelData: state.selectedHostelData,
        roomTypeData: <RoomTypeData>[],
        selectedRoomTypeData: RoomTypeData.empty,
        hostelRegisterDetails: state.hostelRegisterDetails,
        hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
        gethostelData: state.gethostelData,
        fromDate: TextEditingController(),
        toDate: TextEditingController(),
        leaveReason: TextEditingController(),
        hostelLeaveData: <HostelLeaveData>[],
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRes = details['getRoomTypeResponse'] as Map<String, dynamic>;
      final returnData = hostelRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      var roomType = <RoomTypeData>[];
      try {
        final roomTypeDataResponse =
            RoomTypeModel.fromJson(decryptedData.mapData!);
        roomType = roomTypeDataResponse.data!;
        state = state.copyWith(roomTypeData: roomType);
        if (decryptedData.mapData!['Status'] == 'Success') {
        } else {
          state = HostelStateError(
            successMessage: '',
            errorMessage: '${decryptedData.mapData!['Status']}',
            hostelData: state.hostelData,
            selectedHostelData: state.selectedHostelData,
            roomTypeData: <RoomTypeData>[],
            selectedRoomTypeData: RoomTypeData.empty,
            hostelRegisterDetails: state.hostelRegisterDetails,
            hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
            gethostelData: state.gethostelData,
            fromDate: TextEditingController(),
            toDate: TextEditingController(),
            leaveReason: TextEditingController(),
            hostelLeaveData: <HostelLeaveData>[],
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = HostelStateError(
          successMessage: '',
          errorMessage: error.message!,
          hostelData: state.hostelData,
          selectedHostelData: HostelData.empty,
          roomTypeData: <RoomTypeData>[],
          selectedRoomTypeData: RoomTypeData.empty,
          hostelRegisterDetails: state.hostelRegisterDetails,
          hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
          gethostelData: state.gethostelData,
          fromDate: TextEditingController(),
          toDate: TextEditingController(),
          leaveReason: TextEditingController(),
          hostelLeaveData: <HostelLeaveData>[],
        );
      }
    } else if (response.$1 != 200) {
      state = HostelStateError(
        successMessage: '',
        errorMessage: 'Error',
        hostelData: state.hostelData,
        selectedHostelData: state.selectedHostelData,
        roomTypeData: <RoomTypeData>[],
        selectedRoomTypeData: RoomTypeData.empty,
        hostelRegisterDetails: state.hostelRegisterDetails,
        hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
        gethostelData: state.gethostelData,
        fromDate: TextEditingController(),
        toDate: TextEditingController(),
        leaveReason: TextEditingController(),
        hostelLeaveData: <HostelLeaveData>[],
      );
    }
  }

  Future<void> getHostelRegisterDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><semesterid>${TokensManagement.semesterId}</semesterid>',
    );
    log('hostel>>>>><studentid>${TokensManagement.studentId}</studentid><semesterid>${TokensManagement.semesterId}</semesterid>');
    final response =
        await HttpService.sendSoapRequest('getHostelRegister', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableHostel(
        successMessage: '',
        errorMessage: '',
        hostelData: state.hostelData,
        selectedHostelData: HostelData.empty,
        roomTypeData: <RoomTypeData>[],
        selectedRoomTypeData: RoomTypeData.empty,
        hostelRegisterDetails: HostelRegisterData.empty,
        hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
        gethostelData: <GetHostelData>[],
        fromDate: TextEditingController(),
        toDate: TextEditingController(),
        leaveReason: TextEditingController(),
        hostelLeaveData: <HostelLeaveData>[],
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRes =
          details['getHostelRegisterResponse'] as Map<String, dynamic>;
      final returnData = hostelRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      log('hostelRegister>>>>>>>>${decryptedData.mapData}');

      var hostelRegisterDetails = HostelRegisterData.empty;
      var hostelAfterRegisterDetails = HostelAfterRegisterData.empty;

      if (decryptedData.mapData!['Status'] == 'Success') {
        if (decryptedData.mapData!['Data'][0]['status'] == 0) {
          log('enters status==0');
          final hostelRegisterResponse =
              HostelRegisterModel.fromJson(decryptedData.mapData!);

          hostelRegisterDetails = hostelRegisterResponse.data![0];
          state = state.copyWith(hostelRegisterDetails: hostelRegisterDetails);
        } else {
          log('enters status==1');
          final hostelAfterRegisterResponse =
              HostelAfterRegisterModel.fromJson(decryptedData.mapData!);

          hostelAfterRegisterDetails = hostelAfterRegisterResponse.data![0];
          state = state.copyWith(
            hostelAfterRegisterDetails: hostelAfterRegisterDetails,
          );
        }
      } else if (decryptedData.mapData!['Status'] != 'Success') {
        log('enters here !success');
        state = HostelStateError(
          successMessage: '',
          errorMessage: decryptedData.mapData!['Status'] as String,
          hostelData: state.hostelData,
          selectedHostelData: HostelData.empty,
          roomTypeData: <RoomTypeData>[],
          selectedRoomTypeData: RoomTypeData.empty,
          hostelRegisterDetails: HostelRegisterData.empty,
          hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
          gethostelData: <GetHostelData>[],
          fromDate: TextEditingController(),
          toDate: TextEditingController(),
          leaveReason: TextEditingController(),
          hostelLeaveData: <HostelLeaveData>[],
        );
      }
    } else if (response.$1 != 200) {
      state = HostelStateError(
        successMessage: '',
        errorMessage: 'Error',
        hostelData: state.hostelData,
        selectedHostelData: HostelData.empty,
        roomTypeData: <RoomTypeData>[],
        selectedRoomTypeData: RoomTypeData.empty,
        hostelRegisterDetails: HostelRegisterData.empty,
        hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
        gethostelData: <GetHostelData>[],
        fromDate: TextEditingController(),
        toDate: TextEditingController(),
        leaveReason: TextEditingController(),
        hostelLeaveData: <HostelLeaveData>[],
      );
    }
  }

  void setValue() {
    state = state.copyWith();
  }

  Future<void> studentLeaveSubmit(EncryptionProvider encrypt) async {
    log(
      'body>>>>>>>>><studentid>${TokensManagement.studentId}</studentid><fromdate>${state.fromDate.text}</fromdate><todate>${state.toDate.text}</todate><reason>${state.leaveReason.text}</reason>',
    );
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><fromdate>${state.fromDate.text}</fromdate><todate>${state.toDate.text}</todate><reason>${state.leaveReason.text}</reason>',
    );
    log('encrypted data>>>>$data');
    final response =
        await HttpService.sendSoapRequest('getStudentLeaveSave', data);
    log('student leave response>>>>>>$response');
    if (response.$1 == 0) {
      state = NoNetworkAvailableHostel(
        successMessage: '',
        errorMessage: 'No Internet',
        hostelData: <HostelData>[],
        selectedHostelData: HostelData.empty,
        roomTypeData: <RoomTypeData>[],
        selectedRoomTypeData: RoomTypeData.empty,
        hostelRegisterDetails: HostelRegisterData.empty,
        hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
        fromDate: state.fromDate,
        toDate: state.toDate,
        leaveReason: state.leaveReason,
        hostelLeaveData: <HostelLeaveData>[],
        gethostelData: <GetHostelData>[],
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRegisterRes =
          details['getStudentLeaveSaveResponse'] as Map<String, dynamic>;
      final returnData = hostelRegisterRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      log('data>>>>>$data');
      final decryptedData = encrypt.getDecryptedData('$data');
      log('decrypted data>>>>${decryptedData.stringData}');
      try {
        if (decryptedData.mapData!['status'] == 'Success') {
          state = HostelStateSuccessful(
            successMessage: '${decryptedData.mapData!['Message']}',
            errorMessage: '',
            hostelData: <HostelData>[],
            selectedHostelData: HostelData.empty,
            roomTypeData: <RoomTypeData>[],
            selectedRoomTypeData: RoomTypeData.empty,
            hostelRegisterDetails: HostelRegisterData.empty,
            hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
            fromDate: TextEditingController(),
            toDate: TextEditingController(),
            leaveReason: TextEditingController(),
            hostelLeaveData: <HostelLeaveData>[],
            gethostelData: <GetHostelData>[],
          );
        } else {
          state = HostelStateError(
            successMessage: '',
            errorMessage: '${decryptedData.mapData!['Message']}',
            hostelData: <HostelData>[],
            selectedHostelData: HostelData.empty,
            roomTypeData: <RoomTypeData>[],
            selectedRoomTypeData: RoomTypeData.empty,
            hostelRegisterDetails: HostelRegisterData.empty,
            hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
            fromDate: state.fromDate,
            toDate: state.toDate,
            leaveReason: state.leaveReason,
            hostelLeaveData: <HostelLeaveData>[],
            gethostelData: <GetHostelData>[],
          );
        }
      } catch (e) {
        final jsonString = '${decryptedData.stringData}';
        var jsonObject = <String, dynamic>{};
        try {
          jsonObject = jsonDecode(jsonString) as Map<String, dynamic>;
        } catch (e) {
          state = HostelStateError(
            successMessage: '',
            errorMessage: '$e',
            hostelData: <HostelData>[],
            selectedHostelData: HostelData.empty,
            roomTypeData: <RoomTypeData>[],
            selectedRoomTypeData: RoomTypeData.empty,
            hostelRegisterDetails: HostelRegisterData.empty,
            hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
            fromDate: state.fromDate,
            toDate: state.toDate,
            leaveReason: state.leaveReason,
            hostelLeaveData: <HostelLeaveData>[],
            gethostelData: <GetHostelData>[],
          );
        }
        log('message>>>>>${jsonObject['Message']}');
        state = HostelStateError(
          successMessage: '',
          errorMessage: jsonObject['Message'] as String,
          hostelData: <HostelData>[],
          selectedHostelData: HostelData.empty,
          roomTypeData: <RoomTypeData>[],
          selectedRoomTypeData: RoomTypeData.empty,
          hostelRegisterDetails: HostelRegisterData.empty,
          hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
          fromDate: state.fromDate,
          toDate: state.toDate,
          leaveReason: state.leaveReason,
          hostelLeaveData: <HostelLeaveData>[],
          gethostelData: <GetHostelData>[],
        );
      }
    } else if (response.$1 != 200) {
      state = HostelStateError(
        successMessage: '',
        errorMessage: 'Error',
        hostelData: <HostelData>[],
        selectedHostelData: HostelData.empty,
        roomTypeData: <RoomTypeData>[],
        selectedRoomTypeData: RoomTypeData.empty,
        hostelRegisterDetails: HostelRegisterData.empty,
        hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
        fromDate: state.fromDate,
        toDate: state.toDate,
        leaveReason: state.leaveReason,
        hostelLeaveData: <HostelLeaveData>[],
        gethostelData: <GetHostelData>[],
      );
    }
  }

  Future<void> getHostelLeaveStatus(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response = await HttpService.sendSoapRequest(
      'getHostelLeaveApplicationDetails',
      data,
    );
    if (response.$1 == 0) {
      state = NoNetworkAvailableHostel(
        successMessage: '',
        errorMessage: '',
        hostelData: <HostelData>[],
        selectedHostelData: HostelData.empty,
        roomTypeData: <RoomTypeData>[],
        selectedRoomTypeData: RoomTypeData.empty,
        hostelRegisterDetails: HostelRegisterData.empty,
        hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
        fromDate: TextEditingController(),
        toDate: TextEditingController(),
        leaveReason: TextEditingController(),
        hostelLeaveData: <HostelLeaveData>[],
        gethostelData: <GetHostelData>[],
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRes = details['getHostelLeaveApplicationDetailsResponse']
          as Map<String, dynamic>;
      final returnData = hostelRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      log('decrypted leave status>>>>>>>>${decryptedData.mapData}');
      var hostelLeaveData = <HostelLeaveData>[];

//change model
      try {
        final hostelLeaveResponse =
            HostelLeaveApplicationModel.fromJson(decryptedData.mapData!);
        hostelLeaveData = hostelLeaveResponse.data!;
        state = state.copyWith(hostelLeaveData: hostelLeaveData);
        if (hostelLeaveResponse.status == 'Success') {
        } else if (hostelLeaveResponse.status != 'Success') {
          state = HostelStateError(
              successMessage: '',
              errorMessage: hostelLeaveResponse.message!,
              hostelData: <HostelData>[],
              selectedHostelData: HostelData.empty,
              roomTypeData: <RoomTypeData>[],
              selectedRoomTypeData: RoomTypeData.empty,
              hostelRegisterDetails: HostelRegisterData.empty,
              hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
              fromDate: TextEditingController(),
              toDate: TextEditingController(),
              leaveReason: TextEditingController(),
              hostelLeaveData: <HostelLeaveData>[],
              gethostelData: <GetHostelData>[],);
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = HostelStateError(
            successMessage: '',
            errorMessage: error.message!,
            hostelData: <HostelData>[],
            selectedHostelData: HostelData.empty,
            roomTypeData: <RoomTypeData>[],
            selectedRoomTypeData: RoomTypeData.empty,
            hostelRegisterDetails: HostelRegisterData.empty,
            hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
            fromDate: TextEditingController(),
            toDate: TextEditingController(),
            leaveReason: TextEditingController(),
            hostelLeaveData: <HostelLeaveData>[],
            gethostelData: <GetHostelData>[],);
      }
    } else if (response.$1 != 200) {
      state = HostelStateError(
          successMessage: '',
          errorMessage: 'Error',
          hostelData: <HostelData>[],
          selectedHostelData: HostelData.empty,
          roomTypeData: <RoomTypeData>[],
          selectedRoomTypeData: RoomTypeData.empty,
          hostelRegisterDetails: HostelRegisterData.empty,
          hostelAfterRegisterDetails: HostelAfterRegisterData.empty,
          fromDate: TextEditingController(),
          toDate: TextEditingController(),
          leaveReason: TextEditingController(),
          hostelLeaveData: <HostelLeaveData>[],
          gethostelData: <GetHostelData>[],);
    }
  }
}

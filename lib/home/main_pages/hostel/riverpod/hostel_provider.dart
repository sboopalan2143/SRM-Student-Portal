import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_after_register_hive_model.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_before_register_hive_model.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_before_register_model.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_details_hive_model.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_hive_model.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_leave_application_hive_model.dart';
import 'package:sample/home/main_pages/hostel/model/room_type_hive_model.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_state.dart';

class HostelProvider extends StateNotifier<HostelState> {
  HostelProvider() : super(HostelInitial());

  void disposeState() => state = HostelInitial();

  void _setLoading() => state = HostelStateLoading(
        successMessage: '',
        errorMessage: '',
        hostelData: <HostelHiveData>[],
        selectedHostelData: HostelHiveData.empty,
        roomTypeData: <RoomTypeHiveData>[],
        selectedRoomTypeData: RoomTypeHiveData.empty,
        hostelRegisterDetails: HostelRegisterData.empty,
        hostelAfterRegisterDetails: HostelAfterRegisterHiveData.empty,
        gethostelData: <GetHostelHiveData>[],
        fromDate: TextEditingController(),
        toDate: TextEditingController(),
        leaveReason: TextEditingController(),
        hostelLeaveData: <HostelLeaveHiveData>[],
      );

//not required
  Future<void> getHostelDetails(EncryptionProvider encrypt) async {
    _setLoading();
    log(
      'data >>>>>>> <studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response = await HttpService.sendSoapRequest('getHostelDetails', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableHostel(
        successMessage: '',
        errorMessage: 'No Network. Connect to Internet',
        hostelData: state.hostelData,
        selectedHostelData: state.selectedHostelData,
        roomTypeData: state.roomTypeData,
        selectedRoomTypeData: state.selectedRoomTypeData,
        hostelRegisterDetails: state.hostelRegisterDetails,
        hostelAfterRegisterDetails: state.hostelAfterRegisterDetails,
        gethostelData: <GetHostelHiveData>[],
        fromDate: TextEditingController(),
        toDate: TextEditingController(),
        leaveReason: TextEditingController(),
        hostelLeaveData: state.hostelLeaveData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final gethostelRes = details['getHostelDetailsResponse'] as Map<String, dynamic>;
      final returnData = gethostelRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      // var gethostelData = <GetHostelHiveData>[];
      final listData = decryptedData.mapData!['Data'] as String;
      final box = await Hive.openBox<GetHostelHiveData>('hostelData');
      log('hostel details>>>>${decryptedData.mapData}');
      if (box.isEmpty) {
        for (var i = 0; i < listData.length; i++) {
          final parseData = GetHostelHiveData.fromJson(
            listData[i] as Map<String, dynamic>,
          );

          await box.add(parseData);
        }
      } else {
        await box.clear();
        for (var i = 0; i < listData.length; i++) {
          final parseData = GetHostelHiveData.fromJson(
            listData[i] as Map<String, dynamic>,
          );

          await box.add(parseData);
        }
      }
      await box.close();
      // try {
      // final gethosteldetailsResponse =
      //     GetHostelDetailsModel.fromJson(decryptedData.mapData!);
      // gethostelData = gethosteldetailsResponse.data!;
      // state = state.copyWith(gethostelData: gethostelData);
      if (decryptedData.mapData!['Status'] == 'Success') {
        state = HostelStateSuccessful(
          successMessage: '${decryptedData.mapData!['Status']}',
          errorMessage: '',
          hostelData: state.hostelData,
          selectedHostelData: state.selectedHostelData,
          roomTypeData: state.roomTypeData,
          selectedRoomTypeData: state.selectedRoomTypeData,
          hostelRegisterDetails: state.hostelRegisterDetails,
          hostelAfterRegisterDetails: state.hostelAfterRegisterDetails,
          gethostelData: <GetHostelHiveData>[],
          fromDate: TextEditingController(),
          toDate: TextEditingController(),
          leaveReason: TextEditingController(),
          hostelLeaveData: state.hostelLeaveData,
        );
      } else if (decryptedData.mapData!['Status'] != 'Success') {
        state = HostelStateError(
          successMessage: '',
          errorMessage: decryptedData.mapData!['Message'] as String,
          hostelData: state.hostelData,
          selectedHostelData: state.selectedHostelData,
          roomTypeData: state.roomTypeData,
          selectedRoomTypeData: state.selectedRoomTypeData,
          hostelRegisterDetails: state.hostelRegisterDetails,
          hostelAfterRegisterDetails: state.hostelAfterRegisterDetails,
          gethostelData: <GetHostelHiveData>[],
          fromDate: TextEditingController(),
          toDate: TextEditingController(),
          leaveReason: TextEditingController(),
          hostelLeaveData: state.hostelLeaveData,
        );
      }
      // } catch (e) {
      //   final error = ErrorModel.fromJson(decryptedData.mapData!);
      //   state = HostelStateError(
      //     successMessage: '',
      //     errorMessage: error.message!,
      //     hostelData: <HostelData>[],
      //     selectedHostelData: HostelData.empty,
      //     roomTypeData: <RoomTypeData>[],
      //     selectedRoomTypeData: RoomTypeData.empty,
      //     hostelRegisterDetails: HostelRegisterData.empty,
      //     hostelAfterRegisterDetails: HostelAfterRegisterHiveData.empty,
      //     gethostelData: <GetHostelData>[],
      //     fromDate: TextEditingController(),
      //     toDate: TextEditingController(),
      //     leaveReason: TextEditingController(),
      //     hostelLeaveData: <HostelLeaveData>[],
      //   );
      // }
    } else if (response.$1 != 200) {
      state = HostelStateError(
        successMessage: '',
        errorMessage: 'Error',
        hostelData: state.hostelData,
        selectedHostelData: state.selectedHostelData,
        roomTypeData: state.roomTypeData,
        selectedRoomTypeData: state.selectedRoomTypeData,
        hostelRegisterDetails: state.hostelRegisterDetails,
        hostelAfterRegisterDetails: state.hostelAfterRegisterDetails,
        gethostelData: <GetHostelHiveData>[],
        fromDate: TextEditingController(),
        toDate: TextEditingController(),
        leaveReason: TextEditingController(),
        hostelLeaveData: state.hostelLeaveData,
      );
    }
  }

  Future<void> getHostelHiveDetails(String search) async {
    log('Enters here hostel data');
    try {
      _setLoading();
      final box = await Hive.openBox<GetHostelHiveData>(
        'hostelData',
      );
      final hostelHiveData = <GetHostelHiveData>[
        ...box.values,
      ];

      state = state.copyWith(gethostelData: hostelHiveData);
      log('hostel data>>>${state.gethostelData.length}');
      await box.close();
    } catch (e) {
      await getHostelHiveDetails(search);
    }
  }

  Future<void> hostelRegister(EncryptionProvider encrypt) async {
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><academicyearid>${state.hostelRegisterDetails!.academicyearid}</academicyearid><roomtypeid>${state.selectedRoomTypeData.roomtypeid}</roomtypeid><hostelid>${state.selectedHostelData.hostelid}</hostelid><controllerid>${state.hostelRegisterDetails.controllerid}</controllerid><officeid>${TokensManagement.officeId}</officeid><semesterid>${TokensManagement.semesterId}</semesterid>',
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
        hostelAfterRegisterDetails: state.hostelAfterRegisterDetails,
        gethostelData: state.gethostelData,
        fromDate: TextEditingController(),
        toDate: TextEditingController(),
        leaveReason: TextEditingController(),
        hostelLeaveData: state.hostelLeaveData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRegisterRes = details['getRegisterResponse'] as Map<String, dynamic>;
      final returnData = hostelRegisterRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];

      final decryptedData = encrypt.getDecryptedData('$data');

      log('roomtype details>>>>${decryptedData.mapData}');

      if (decryptedData.mapData!['Status'] == 'Success') {
        state = HostelStateSuccessful(
          successMessage: '${decryptedData.mapData!['Status']}',
          errorMessage: '',
          hostelData: state.hostelData,
          selectedHostelData: state.selectedHostelData,
          roomTypeData: state.roomTypeData,
          selectedRoomTypeData: state.selectedRoomTypeData,
          hostelRegisterDetails: state.hostelRegisterDetails,
          hostelAfterRegisterDetails: state.hostelAfterRegisterDetails,
          gethostelData: state.gethostelData,
          fromDate: TextEditingController(),
          toDate: TextEditingController(),
          leaveReason: TextEditingController(),
          hostelLeaveData: state.hostelLeaveData,
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
          hostelAfterRegisterDetails: state.hostelAfterRegisterDetails,
          gethostelData: state.gethostelData,
          fromDate: TextEditingController(),
          toDate: TextEditingController(),
          leaveReason: TextEditingController(),
          hostelLeaveData: state.hostelLeaveData,
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
        hostelAfterRegisterDetails: state.hostelAfterRegisterDetails,
        gethostelData: state.gethostelData,
        fromDate: TextEditingController(),
        toDate: TextEditingController(),
        leaveReason: TextEditingController(),
        hostelLeaveData: state.hostelLeaveData,
      );
    }
  }

  void setHostelValue(HostelHiveData data, EncryptionProvider encrypt) {
    state = state.copyWith(selectedHostelData: data);
    getRoomType(
      encrypt,
      state.selectedHostelData.hostelid!,
    );
  }

  void setRoomTypeValue(RoomTypeHiveData data) {
    state = state.copyWith(selectedRoomTypeData: data);
  }

  Future<void> gethostel(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><semesterid>${TokensManagement.semesterId}</semesterid>',
    );
    final response = await HttpService.sendSoapRequest('getHostel', data);

    if (response.$1 == 0) {
      state = NoNetworkAvailableHostel(
        successMessage: '',
        errorMessage: 'No Internet',
        hostelData: <HostelHiveData>[],
        selectedHostelData: HostelHiveData.empty,
        roomTypeData: state.roomTypeData,
        selectedRoomTypeData: state.selectedRoomTypeData,
        hostelRegisterDetails: state.hostelRegisterDetails,
        hostelAfterRegisterDetails: state.hostelAfterRegisterDetails,
        gethostelData: state.gethostelData,
        fromDate: TextEditingController(),
        toDate: TextEditingController(),
        leaveReason: TextEditingController(),
        hostelLeaveData: state.hostelLeaveData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRes = details['getHostelResponse'] as Map<String, dynamic>;
      final returnData = hostelRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];

      final decryptedData = encrypt.getDecryptedData('$data');

      log('hostel mapdata>>>${decryptedData.mapData}');
      log('hostel stringdata>>>${decryptedData.stringData}');
      // var hostelData = <HostelData>[];
      // try {
      //   final hostelDataResponse = HostelModel.fromJson(decryptedData.mapData!);
      //   hostelData = hostelDataResponse.data!;
      //   state = state.copyWith(hostelData: hostelData);
      final listData = decryptedData.mapData!['Data'] as List<dynamic>;
      final box = await Hive.openBox<HostelHiveData>(
        'hostel',
      );
      if (box.isEmpty) {
        for (var i = 0; i < listData.length; i++) {
          final parseData = HostelHiveData.fromJson(
            listData[i] as Map<String, dynamic>,
          );

          await box.add(parseData);
        }
      } else {
        await box.clear();

        for (var i = 0; i < listData.length; i++) {
          final parseData = HostelHiveData.fromJson(
            listData[i] as Map<String, dynamic>,
          );

          await box.add(parseData);
        }
      }
      await box.close();

      if (decryptedData.mapData!['Status'] == 'Success') {
      } else {
        state = HostelStateError(
          successMessage: '',
          errorMessage: '${decryptedData.mapData!['Status']}',
          hostelData: <HostelHiveData>[],
          selectedHostelData: HostelHiveData.empty,
          roomTypeData: state.roomTypeData,
          selectedRoomTypeData: state.selectedRoomTypeData,
          hostelRegisterDetails: state.hostelRegisterDetails,
          hostelAfterRegisterDetails: state.hostelAfterRegisterDetails,
          gethostelData: state.gethostelData,
          fromDate: TextEditingController(),
          toDate: TextEditingController(),
          leaveReason: TextEditingController(),
          hostelLeaveData: state.hostelLeaveData,
        );
      }
      // } catch (e) {
      //   final error = ErrorModel.fromJson(decryptedData.mapData!);
      //   state = HostelStateError(
      //     successMessage: '',
      //     errorMessage: error.message!,
      //     hostelData: state.hostelData,
      //     selectedHostelData: HostelData.empty,
      //     roomTypeData: <RoomTypeData>[],
      //     selectedRoomTypeData: RoomTypeData.empty,
      //     hostelRegisterDetails: state.hostelRegisterDetails,
      //     hostelAfterRegisterDetails: HostelAfterRegisterHiveData.empty,
      //     gethostelData: state.gethostelData,
      //     fromDate: TextEditingController(),
      //     toDate: TextEditingController(),
      //     leaveReason: TextEditingController(),
      //     hostelLeaveData: <HostelLeaveData>[],
      //   );
      // }
    } else if (response.$1 != 200) {
      state = HostelStateError(
        successMessage: '',
        errorMessage: 'Error',
        hostelData: <HostelHiveData>[],
        selectedHostelData: HostelHiveData.empty,
        roomTypeData: state.roomTypeData,
        selectedRoomTypeData: state.selectedRoomTypeData,
        hostelRegisterDetails: state.hostelRegisterDetails,
        hostelAfterRegisterDetails: state.hostelAfterRegisterDetails,
        gethostelData: state.gethostelData,
        fromDate: TextEditingController(),
        toDate: TextEditingController(),
        leaveReason: TextEditingController(),
        hostelLeaveData: state.hostelLeaveData,
      );
    }
  }

  Future<void> getHostelNameHiveData(String search) async {
    try {
      _setLoading();
      final box = await Hive.openBox<HostelHiveData>(
        'hostel',
      );
      final hostelHive = <HostelHiveData>[
        ...box.values,
      ];

      state = state.copyWith(hostelData: hostelHive);
      await box.close();
    } catch (e) {
      await getHostelNameHiveData(search);
    }
  }

  Future<void> getRoomType(EncryptionProvider encrypt, String hostelId) async {
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
        roomTypeData: <RoomTypeHiveData>[],
        selectedRoomTypeData: RoomTypeHiveData.empty,
        hostelRegisterDetails: state.hostelRegisterDetails,
        hostelAfterRegisterDetails: state.hostelAfterRegisterDetails,
        gethostelData: state.gethostelData,
        fromDate: TextEditingController(),
        toDate: TextEditingController(),
        leaveReason: TextEditingController(),
        hostelLeaveData: state.hostelLeaveData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRes = details['getRoomTypeResponse'] as Map<String, dynamic>;
      final returnData = hostelRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      // var roomType = <RoomTypeData>[];
      // try {
      //   final roomTypeDataResponse =
      //       RoomTypeModel.fromJson(decryptedData.mapData!);
      //   roomType = roomTypeDataResponse.data!;
      //   state = state.copyWith(roomTypeData: roomType);
      final listData = decryptedData.mapData!['Data'] as List<dynamic>;
      final box = await Hive.openBox<RoomTypeHiveData>(
        'roomTypeData',
      );
      if (box.isEmpty) {
        for (var i = 0; i < listData.length; i++) {
          final parseData = RoomTypeHiveData.fromJson(
            listData[i] as Map<String, dynamic>,
          );

          await box.add(parseData);
        }
      } else {
        await box.clear();
        for (var i = 0; i < listData.length; i++) {
          final parseData = RoomTypeHiveData.fromJson(
            listData[i] as Map<String, dynamic>,
          );

          await box.add(parseData);
        }
      }
      await box.close();
      if (decryptedData.mapData!['Status'] == 'Success') {
      } else {
        state = HostelStateError(
          successMessage: '',
          errorMessage: '${decryptedData.mapData!['Status']}',
          hostelData: state.hostelData,
          selectedHostelData: state.selectedHostelData,
          roomTypeData: <RoomTypeHiveData>[],
          selectedRoomTypeData: RoomTypeHiveData.empty,
          hostelRegisterDetails: state.hostelRegisterDetails,
          hostelAfterRegisterDetails: state.hostelAfterRegisterDetails,
          gethostelData: state.gethostelData,
          fromDate: TextEditingController(),
          toDate: TextEditingController(),
          leaveReason: TextEditingController(),
          hostelLeaveData: state.hostelLeaveData,
        );
      }
      // } catch (e) {
      //   final error = ErrorModel.fromJson(decryptedData.mapData!);
      //   state = HostelStateError(
      //     successMessage: '',
      //     errorMessage: error.message!,
      //     hostelData: state.hostelData,
      //     selectedHostelData: state.selectedHostelData,
      //     roomTypeData: <RoomTypeData>[],
      //     selectedRoomTypeData: RoomTypeData.empty,
      //     hostelRegisterDetails: state.hostelRegisterDetails,
      //     hostelAfterRegisterDetails: HostelAfterRegisterHiveData.empty,
      //     gethostelData: state.gethostelData,
      //     fromDate: TextEditingController(),
      //     toDate: TextEditingController(),
      //     leaveReason: TextEditingController(),
      //     hostelLeaveData: <HostelLeaveData>[],
      //   );
      // }
    } else if (response.$1 != 200) {
      state = HostelStateError(
        successMessage: '',
        errorMessage: 'Error',
        hostelData: state.hostelData,
        selectedHostelData: state.selectedHostelData,
        roomTypeData: <RoomTypeHiveData>[],
        selectedRoomTypeData: RoomTypeHiveData.empty,
        hostelRegisterDetails: state.hostelRegisterDetails,
        hostelAfterRegisterDetails: state.hostelAfterRegisterDetails,
        gethostelData: state.gethostelData,
        fromDate: TextEditingController(),
        toDate: TextEditingController(),
        leaveReason: TextEditingController(),
        hostelLeaveData: state.hostelLeaveData,
      );
    }
  }

  Future<void> getRoomTypeHiveData(String search) async {
    try {
      _setLoading();
      final box = await Hive.openBox<RoomTypeHiveData>(
        'roomTypeData',
      );
      final roomTypeHiveData = <RoomTypeHiveData>[
        ...box.values,
      ];

      state = state.copyWith(roomTypeData: roomTypeHiveData);
      await box.close();
    } catch (e) {
      await getHostelNameHiveData(search);
    }
  }

  // ???????????????????????

  Future<void> getHostelRegisterDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><semesterid>${TokensManagement.semesterId}</semesterid>',
    );
    final response = await HttpService.sendSoapRequest('getHostelRegister', data);
    log('hostel respose code >>>>> ${response.$1}');
    if (response.$1 == 0) {
      state = NoNetworkAvailableHostel(
        successMessage: '',
        errorMessage: '',
        hostelData: state.hostelData,
        selectedHostelData: HostelHiveData.empty,
        roomTypeData: state.roomTypeData,
        selectedRoomTypeData: RoomTypeHiveData.empty,
        hostelRegisterDetails: state.hostelRegisterDetails,
        hostelAfterRegisterDetails: HostelAfterRegisterHiveData.empty,
        gethostelData: state.gethostelData,
        fromDate: TextEditingController(),
        toDate: TextEditingController(),
        leaveReason: TextEditingController(),
        hostelLeaveData: state.hostelLeaveData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRes = details['getHostelRegisterResponse'] as Map<String, dynamic>;
      final returnData = hostelRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      var hostelRegisterDetailsData = state.hostelRegisterDetails;
      log('getHostelRegister >>>>>>>> ${decryptedData.mapData}');
      // log('hostel >>>>>>>>$hostelRegisterDetailsData');
//change model
      try {
        final hostelRegisterDetailsDataResponse = HostelRegisterModel.fromJson(decryptedData.mapData!);

        hostelRegisterDetailsData = hostelRegisterDetailsDataResponse.data!.first;
        state = state.copyWith(hostelRegisterDetails: hostelRegisterDetailsData);
        if (hostelRegisterDetailsDataResponse.status == 'Success') {
          state = HostelStateSuccessful(
            successMessage: '',
            errorMessage: hostelRegisterDetailsDataResponse.status!,
            hostelData: state.hostelData,
            selectedHostelData: state.selectedHostelData,
            roomTypeData: state.roomTypeData,
            selectedRoomTypeData: state.selectedRoomTypeData,
            hostelRegisterDetails: state.hostelRegisterDetails,
            hostelAfterRegisterDetails: HostelAfterRegisterHiveData.empty,
            gethostelData: state.gethostelData,
            fromDate: TextEditingController(),
            toDate: TextEditingController(),
            leaveReason: TextEditingController(),
            hostelLeaveData: state.hostelLeaveData,
          );
        } else if (hostelRegisterDetailsDataResponse.status != 'Success') {
          state = HostelStateError(
            successMessage: '',
            errorMessage: hostelRegisterDetailsDataResponse.status!,
            hostelData: state.hostelData,
            selectedHostelData: state.selectedHostelData,
            roomTypeData: state.roomTypeData,
            selectedRoomTypeData: state.selectedRoomTypeData,
            hostelRegisterDetails: state.hostelRegisterDetails,
            hostelAfterRegisterDetails: HostelAfterRegisterHiveData.empty,
            gethostelData: state.gethostelData,
            fromDate: TextEditingController(),
            toDate: TextEditingController(),
            leaveReason: TextEditingController(),
            hostelLeaveData: state.hostelLeaveData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = HostelStateError(
          successMessage: '',
          errorMessage: error.message!,
          hostelData: state.hostelData,
          selectedHostelData: state.selectedHostelData,
          roomTypeData: state.roomTypeData,
          selectedRoomTypeData: state.selectedRoomTypeData,
          hostelRegisterDetails: state.hostelRegisterDetails,
          hostelAfterRegisterDetails: HostelAfterRegisterHiveData.empty,
          gethostelData: state.gethostelData,
          fromDate: TextEditingController(),
          toDate: TextEditingController(),
          leaveReason: TextEditingController(),
          hostelLeaveData: state.hostelLeaveData,
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
        hostelAfterRegisterDetails: HostelAfterRegisterHiveData.empty,
        gethostelData: state.gethostelData,
        fromDate: TextEditingController(),
        toDate: TextEditingController(),
        leaveReason: TextEditingController(),
        hostelLeaveData: state.hostelLeaveData,
      );
    }
  }

  // Future<void> getHostelRegisterDetails(EncryptionProvider encrypt) async {
  //   _setLoading();
  //   final data = encrypt.getEncryptedData(
  //     '<studentid>${TokensManagement.studentId}</studentid><semesterid>${TokensManagement.semesterId}</semesterid>',
  //   );
  //   final response =
  //       await HttpService.sendSoapRequest('getHostelRegister', data);
  //   if (response.$1 == 0) {
  //     state = NoNetworkAvailableHostel(
  //       successMessage: '',
  //       errorMessage: '',
  //       hostelData: state.hostelData,
  //       selectedHostelData: HostelHiveData.empty,
  //       roomTypeData: state.roomTypeData,
  //       selectedRoomTypeData: RoomTypeHiveData.empty,
  //       hostelRegisterDetails: HostelBeforeRegisterHiveData.empty,
  //       hostelAfterRegisterDetails: HostelAfterRegisterHiveData.empty,
  //       gethostelData: state.gethostelData,
  //       fromDate: TextEditingController(),
  //       toDate: TextEditingController(),
  //       leaveReason: TextEditingController(),
  //       hostelLeaveData: state.hostelLeaveData,
  //     );
  //   } else if (response.$1 == 200) {
  //     final details = response.$2['Body'] as Map<String, dynamic>;
  //     final hostelRes =
  //         details['getHostelRegisterResponse'] as Map<String, dynamic>;
  //     final returnData = hostelRes['return'] as Map<String, dynamic>;
  //     final data = returnData['#text'];
  //     final decryptedData = encrypt.getDecryptedData('$data');
  //     log('hostel mapdata>>>${decryptedData.mapData}');
  //     log('hostel stringdata>>>${decryptedData.stringData}');
  //     // var hostelRegisterDetails = HostelRegisterData.empty;
  //     // var hostelAfterRegisterDetails = HostelAfterRegisterData.empty;

  //     // if (decryptedData.mapData!['Status'] == 'Success') {
  //     // if (decryptedData.mapData!['Data'][0]['status'] == 0) {
  //     //   final listData = decryptedData.mapData!['Data'][0] as List<dynamic>;
  //     //   final box = await Hive.openBox<HostelBeforeRegisterHiveData>(
  //     //     'hostelRegister',
  //     //   );
  //     //   if (box.isEmpty) {
  //     //     for (var i = 0; i < listData.length; i++) {
  //     //       final parseData = HostelBeforeRegisterHiveData.fromJson(
  //     //         listData[i] as Map<String, dynamic>,
  //     //       );

  //     //       await box.add(parseData);
  //     //     }
  //     //   } else {
  //     //     await box.clear();
  //     //     for (var i = 0; i < listData.length; i++) {
  //     //       final parseData = HostelBeforeRegisterHiveData.fromJson(
  //     //         listData[i] as Map<String, dynamic>,
  //     //       );

  //     //       await box.add(parseData);
  //     //     }
  //     //   }
  //     //   await box.close();
  //     //   //     // final hostelRegisterResponse =
  //     //   //     //     HostelRegisterModel.fromJson(decryptedData.mapData!);

  //     //   //     // hostelRegisterDetails = hostelRegisterResponse.data![0];
  //     //   //     // state = state.copyWith(hostelRegisterDetails: hostelRegisterDetails);
  //     // } else {
  //     //   final listData =
  //     //       decryptedData.mapData!['Data'][0] as Map<String, dynamic>;
  //     //   final box = await Hive.openBox<HostelAfterRegisterHiveData>(
  //     //     'hostelAfterRegister',
  //     //   );
  //     //   if (box.isEmpty) {
  //     //     for (var i = 0; i < listData.length; i++) {
  //     //       final parseData = HostelAfterRegisterHiveData.fromJson(
  //     //         listData,
  //     //       );

  //     //       await box.add(parseData);
  //     //     }
  //     //   } else {
  //     //     await box.clear();
  //     //     for (var i = 0; i < listData.length; i++) {
  //     //       final parseData = HostelAfterRegisterHiveData.fromJson(
  //     //         listData,
  //     //       );

  //     //       await box.add(parseData);
  //     //     }
  //     //   }
  //     //   await box.close();
  //     //   //     // final hostelAfterRegisterResponse =
  //     //   //     //     HostelAfterRegisterData.fromJson(decryptedData.mapData!);

  //     //   //     // hostelAfterRegisterDetails = hostelAfterRegisterResponse;
  //     //   //     // state = state.copyWith(
  //     //   //     //   hostelAfterRegisterDetails: hostelAfterRegisterDetails,
  //     //   //     // );
  //     // }
  //     //   } else if (decryptedData.mapData!['Status'] != 'Success') {
  //     //     state = HostelStateError(
  //     //       successMessage: '',
  //     //       errorMessage: decryptedData.mapData!['Status'] as String,
  //     //       hostelData: state.hostelData,
  //     //       selectedHostelData: state.selectedHostelData,
  //     //       roomTypeData: state.roomTypeData,
  //     //       selectedRoomTypeData: state.selectedRoomTypeData,
  //     //       hostelRegisterDetails: HostelBeforeRegisterHiveData.empty,
  //     //       hostelAfterRegisterDetails: HostelAfterRegisterHiveData.empty,
  //     //       gethostelData: state.gethostelData,
  //     //       fromDate: TextEditingController(),
  //     //       toDate: TextEditingController(),
  //     //       leaveReason: TextEditingController(),
  //     //       hostelLeaveData: state.hostelLeaveData,
  //     //     );
  //     //   }
  //   } else if (response.$1 != 200) {
  //     state = HostelStateError(
  //       successMessage: '',
  //       errorMessage: 'Error',
  //       hostelData: state.hostelData,
  //       selectedHostelData: state.selectedHostelData,
  //       roomTypeData: state.roomTypeData,
  //       selectedRoomTypeData: state.selectedRoomTypeData,
  //       hostelRegisterDetails: HostelBeforeRegisterHiveData.empty,
  //       hostelAfterRegisterDetails: HostelAfterRegisterHiveData.empty,
  //       gethostelData: state.gethostelData,
  //       fromDate: TextEditingController(),
  //       toDate: TextEditingController(),
  //       leaveReason: TextEditingController(),
  //       hostelLeaveData: state.hostelLeaveData,
  //     );
  //   }
  // }

  void setValue() {
    state = state.copyWith();
  }

  // Future<void> getBeforeHostelRegisterDetailsHive(String search) async {
  //   try {
  //     final box = await Hive.openBox<HostelBeforeRegisterHiveData>(
  //       'hostelRegister',
  //     );
  //     final hostelRegisterDetails = <HostelBeforeRegisterHiveData>[
  //       ...box.values,
  //     ];

  //     state = state.copyWith(hostelRegisterDetails: hostelRegisterDetails[0]);
  //     await box.close();
  //   } catch (e) {
  //     await getBeforeHostelRegisterDetailsHive(search);
  //   }
  // }

  Future<void> getAfterHostelRegisterDetailsHive(String search) async {
    try {
      _setLoading();
      final box = await Hive.openBox<HostelAfterRegisterHiveData>(
        'hostelAfterRegister',
      );
      final hostelAfterRegisterDetails = <HostelAfterRegisterHiveData>[
        ...box.values,
      ];

      state = state.copyWith(
        hostelAfterRegisterDetails: hostelAfterRegisterDetails[0],
      );
      await box.close();
    } catch (e) {
      await getAfterHostelRegisterDetailsHive(search);
    }
  }

  Future<void> studentLeaveSubmit(EncryptionProvider encrypt) async {
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><fromdate>${state.fromDate.text}</fromdate><todate>${state.toDate.text}</todate><reason>${state.leaveReason.text}</reason>',
    );

    final response = await HttpService.sendSoapRequest('getStudentLeaveSave', data);
    log('student leave response>>>>${response}');
    if (response.$1 == 0) {
      state = NoNetworkAvailableHostel(
        successMessage: '',
        errorMessage: 'No Internet',
        hostelData: state.hostelData,
        selectedHostelData: state.selectedHostelData,
        roomTypeData: state.roomTypeData,
        selectedRoomTypeData: state.selectedRoomTypeData,
        hostelRegisterDetails: state.hostelRegisterDetails,
        hostelAfterRegisterDetails: state.hostelAfterRegisterDetails,
        fromDate: state.fromDate,
        toDate: state.toDate,
        leaveReason: state.leaveReason,
        hostelLeaveData: state.hostelLeaveData,
        gethostelData: state.gethostelData,
      );
    } else if (response.$1 == 200) {
      log('enters 200');
      final details = response.$2['Body'] as Map<String, dynamic>;
      log('details>>$details');
      final hostelRegisterRes = details['getStudentLeaveSaveResponse'] as Map<String, dynamic>;
      log('reponse of student save data>>$hostelRegisterRes');
      final returnData = hostelRegisterRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      log('data>>$data');
      if (data != null) {
        final decryptedData = encrypt.getDecryptedData('$data');
        log('student save>>>>>${decryptedData.mapData}');

        // try {
        if (decryptedData.mapData!['status'] == 'Success') {
          state = HostelStateSuccessful(
            successMessage: '${decryptedData.mapData!['Message']}',
            errorMessage: '',
            hostelData: state.hostelData,
            selectedHostelData: state.selectedHostelData,
            roomTypeData: state.roomTypeData,
            selectedRoomTypeData: state.selectedRoomTypeData,
            hostelRegisterDetails: state.hostelRegisterDetails,
            hostelAfterRegisterDetails: state.hostelAfterRegisterDetails,
            fromDate: TextEditingController(),
            toDate: TextEditingController(),
            leaveReason: TextEditingController(),
            hostelLeaveData: state.hostelLeaveData,
            gethostelData: state.gethostelData,
          );
        } else {
          state = HostelStateError(
            successMessage: '',
            errorMessage: '${decryptedData.mapData!['Message']}',
            hostelData: state.hostelData,
            selectedHostelData: state.selectedHostelData,
            roomTypeData: state.roomTypeData,
            selectedRoomTypeData: state.selectedRoomTypeData,
            hostelRegisterDetails: state.hostelRegisterDetails,
            hostelAfterRegisterDetails: state.hostelAfterRegisterDetails,
            fromDate: state.fromDate,
            toDate: state.toDate,
            leaveReason: state.leaveReason,
            hostelLeaveData: state.hostelLeaveData,
            gethostelData: state.gethostelData,
          );
        }
        // }
        // catch (e) {
        //   log('Enters here');
        //   log('$e');
        // final jsonString = '${decryptedData.stringData}';
        // var jsonObject = <String, dynamic>{};
        // try {
        //   jsonObject = jsonDecode(jsonString) as Map<String, dynamic>;
        // } catch (e) {
        //   state = HostelStateError(
        //     successMessage: '',
        //     errorMessage: '$e',
        //     hostelData: state.hostelData,
        //     selectedHostelData: state.selectedHostelData,
        //     roomTypeData: state.roomTypeData,
        //     selectedRoomTypeData: state.selectedRoomTypeData,
        //     hostelRegisterDetails: state.hostelRegisterDetails,
        //     hostelAfterRegisterDetails: state.hostelAfterRegisterDetails,
        //     fromDate: state.fromDate,
        //     toDate: state.toDate,
        //     leaveReason: state.leaveReason,
        //     hostelLeaveData: state.hostelLeaveData,
        //     gethostelData: state.gethostelData,
        //   );
        // }

        // state = HostelStateError(
        //   successMessage: '',
        //   errorMessage: jsonObject['Message'] as String,
        //   hostelData: state.hostelData,
        //   selectedHostelData: state.selectedHostelData,
        //   roomTypeData: state.roomTypeData,
        //   selectedRoomTypeData: state.selectedRoomTypeData,
        //   hostelRegisterDetails: state.hostelRegisterDetails,
        //   hostelAfterRegisterDetails: state.hostelAfterRegisterDetails,
        //   fromDate: state.fromDate,
        //   toDate: state.toDate,
        //   leaveReason: state.leaveReason,
        //   hostelLeaveData: state.hostelLeaveData,
        //   gethostelData: state.gethostelData,
        // );
        // }
      } else if (response.$1 != 200) {
        state = HostelStateError(
          successMessage: '',
          errorMessage: 'Error',
          hostelData: state.hostelData,
          selectedHostelData: state.selectedHostelData,
          roomTypeData: state.roomTypeData,
          selectedRoomTypeData: state.selectedRoomTypeData,
          hostelRegisterDetails: state.hostelRegisterDetails,
          hostelAfterRegisterDetails: state.hostelAfterRegisterDetails,
          fromDate: state.fromDate,
          toDate: state.toDate,
          leaveReason: state.leaveReason,
          hostelLeaveData: state.hostelLeaveData,
          gethostelData: state.gethostelData,
        );
      }
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
        hostelData: state.hostelData,
        selectedHostelData: state.selectedHostelData,
        roomTypeData: state.roomTypeData,
        selectedRoomTypeData: state.selectedRoomTypeData,
        hostelRegisterDetails: state.hostelRegisterDetails,
        hostelAfterRegisterDetails: state.hostelAfterRegisterDetails,
        fromDate: TextEditingController(),
        toDate: TextEditingController(),
        leaveReason: TextEditingController(),
        hostelLeaveData: <HostelLeaveHiveData>[],
        gethostelData: state.gethostelData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRes = details['getHostelLeaveApplicationDetailsResponse'] as Map<String, dynamic>;
      final returnData = hostelRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      final listData = decryptedData.mapData!['Data'] as String;
      final box = await Hive.openBox<HostelLeaveHiveData>(
        'hostelLeaveStatus',
      );
      if (box.isEmpty) {
        for (var i = 0; i < listData.length; i++) {
          final parseData = HostelLeaveHiveData.fromJson(
            listData[i] as Map<String, dynamic>,
          );

          await box.add(parseData);
        }
      } else {
        await box.clear();
        for (var i = 0; i < listData.length; i++) {
          final parseData = HostelLeaveHiveData.fromJson(
            listData[i] as Map<String, dynamic>,
          );

          await box.add(parseData);
        }
      }
      await box.close();
      // var hostelLeaveData = <HostelLeaveData>[];

//change model
      // try {
      //   final hostelLeaveResponse =
      //       HostelLeaveApplicationModel.fromJson(decryptedData.mapData!);
      //   hostelLeaveData = hostelLeaveResponse.data!;
      //   state = state.copyWith(hostelLeaveData: hostelLeaveData);
      if (decryptedData.mapData!['Status'] == 'Success') {
      } else if (decryptedData.mapData!['Status'] != 'Success') {
        state = HostelStateError(
          successMessage: '',
          errorMessage: decryptedData.mapData!['Message'] as String,
          hostelData: state.hostelData,
          selectedHostelData: state.selectedHostelData,
          roomTypeData: state.roomTypeData,
          selectedRoomTypeData: state.selectedRoomTypeData,
          hostelRegisterDetails: state.hostelRegisterDetails,
          hostelAfterRegisterDetails: state.hostelAfterRegisterDetails,
          fromDate: TextEditingController(),
          toDate: TextEditingController(),
          leaveReason: TextEditingController(),
          hostelLeaveData: <HostelLeaveHiveData>[],
          gethostelData: state.gethostelData,
        );
      }
      // } catch (e) {
      //   final error = ErrorModel.fromJson(decryptedData.mapData!);
      //   state = HostelStateError(
      //     successMessage: '',
      //     errorMessage: error.message!,
      //     hostelData: state.hostelData,
      //     selectedHostelData: state.selectedHostelData,
      //     roomTypeData: state.roomTypeData,
      //     selectedRoomTypeData: state.selectedRoomTypeData,
      //     hostelRegisterDetails: HostelRegisterData.empty,
      //     hostelAfterRegisterDetails: HostelAfterRegisterHiveData.empty,
      //     fromDate: TextEditingController(),
      //     toDate: TextEditingController(),
      //     leaveReason: TextEditingController(),
      //     hostelLeaveData: <HostelLeaveData>[],
      //     gethostelData: state.gethostelData,
      //   );
      // }
    } else if (response.$1 != 200) {
      state = HostelStateError(
        successMessage: '',
        errorMessage: 'Error',
        hostelData: state.hostelData,
        selectedHostelData: state.selectedHostelData,
        roomTypeData: state.roomTypeData,
        selectedRoomTypeData: state.selectedRoomTypeData,
        hostelRegisterDetails: state.hostelRegisterDetails,
        hostelAfterRegisterDetails: state.hostelAfterRegisterDetails,
        fromDate: TextEditingController(),
        toDate: TextEditingController(),
        leaveReason: TextEditingController(),
        hostelLeaveData: <HostelLeaveHiveData>[],
        gethostelData: state.gethostelData,
      );
    }
  }

  Future<void> getHostelLeaveStatusHive(String search) async {
    try {
      _setLoading();
      final box = await Hive.openBox<HostelLeaveHiveData>(
        'hostelLeaveStatus',
      );
      final hostelLeaveStatusHive = <HostelLeaveHiveData>[
        ...box.values,
      ];

      state = state.copyWith(hostelLeaveData: hostelLeaveStatusHive);
      await box.close();
    } catch (e) {
      await getHostelLeaveStatusHive(search);
    }
  }
}

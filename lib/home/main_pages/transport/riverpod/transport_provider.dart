import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/transport/model/boarding_point_hive_model.dart';
import 'package:sample/home/main_pages/transport/model/route_hive_model.dart';
import 'package:sample/home/main_pages/transport/model/transport_after_reg_hive_model.dart';
import 'package:sample/home/main_pages/transport/model/transport_register_hive_model.dart';
import 'package:sample/home/main_pages/transport/model/transport_status_hive_model.dart';
import 'package:sample/home/main_pages/transport/riverpod/transport_state.dart';

class TrasportProvider extends StateNotifier<TransportState> {
  TrasportProvider() : super(TransportInitial());

  void disposeState() => state = TransportInitial();

  void _setLoading() => state = TransportStateLoading(
        successMessage: '',
        errorMessage: '',
        studentId: TextEditingController(),
        academicyearId: TextEditingController(),
        boardingpointId: TextEditingController(),
        busrouteId: TextEditingController(),
        controllerId: TextEditingController(),
        officeId: TextEditingController(),
        routeDetailsDataList: <RouteDetailsHiveData>[],
        selectedRouteDetailsDataList: RouteDetailsHiveData.empty,
        boardingPointDataList: <BoardingPointHiveData>[],
        selectedBoardingPointDataList: BoardingPointHiveData.empty,
        transportRegisterDetails: TransportRegisterHiveData.empty,
        transportStatusData: <TransportStatusHiveData>[],
        transportAfterRegisterDetails: TransportAfterRegisterHiveData.empty,
      );

  Future<void> getTransportStatusDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );

    final response = await HttpService.sendSoapRequest(
      'getTransportRegistrationStatus',
      data,
    );
    if (response.$1 == 0) {
      state = NoNetworkAvailableTransport(
        successMessage: '',
        errorMessage: '',
        studentId: TextEditingController(),
        academicyearId: TextEditingController(),
        boardingpointId: TextEditingController(),
        busrouteId: TextEditingController(),
        controllerId: TextEditingController(),
        officeId: TextEditingController(),
        routeDetailsDataList: state.routeDetailsDataList,
        selectedRouteDetailsDataList: state.selectedRouteDetailsDataList,
        boardingPointDataList: state.boardingPointDataList,
        selectedBoardingPointDataList: state.selectedBoardingPointDataList,
        transportRegisterDetails: state.transportRegisterDetails,
        transportStatusData: <TransportStatusHiveData>[],
        transportAfterRegisterDetails: state.transportAfterRegisterDetails,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final transportStatusDataRes =
          details['getTransportRegistrationStatusResponse']
              as Map<String, dynamic>;
      final returnData =
          transportStatusDataRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      if (decryptedData.mapData!['Status'] == 'Success') {
        // var transportStatusData = state.transportStatusData;
        // log('decrypted >>>>>>>> $decryptedData');
        final listData = decryptedData.mapData!['Data'] as List<dynamic>;
        if (listData.isNotEmpty) {
          log('length transaction >>>${listData.length}');
          final box = await Hive.openBox<TransportStatusHiveData>(
            'transportStatus',
          );
          if (box.isEmpty) {
            for (var i = 0; i < listData.length; i++) {
              final parseData = TransportStatusHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          } else {
            await box.clear();
            for (var i = 0; i < listData.length; i++) {
              final parseData = TransportStatusHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          }
          await box.close();
          // final transportdataResponse =
          //     GetTransportRegistrationStatusModel.fromJson(
          //         decryptedData.mapData!,);
          // transportStatusData = transportdataResponse.data!;
          // state = state.copyWith(
          //   transportStatusData: transportStatusData,
          // );

          state = TransportStateSuccessful(
            successMessage: '',
            errorMessage: '',
            studentId: TextEditingController(),
            academicyearId: TextEditingController(),
            boardingpointId: TextEditingController(),
            busrouteId: TextEditingController(),
            controllerId: TextEditingController(),
            officeId: TextEditingController(),
            routeDetailsDataList: state.routeDetailsDataList,
            selectedRouteDetailsDataList: state.selectedRouteDetailsDataList,
            boardingPointDataList: state.boardingPointDataList,
            selectedBoardingPointDataList: state.selectedBoardingPointDataList,
            transportRegisterDetails: state.transportRegisterDetails,
            transportStatusData: <TransportStatusHiveData>[],
            transportAfterRegisterDetails: state.transportAfterRegisterDetails,
          );
        } else {
          final error = ErrorModel.fromJson(decryptedData.mapData!);
          state = TransportStateError(
            successMessage: '',
            errorMessage: error.message!,
            studentId: TextEditingController(),
            academicyearId: TextEditingController(),
            boardingpointId: TextEditingController(),
            busrouteId: TextEditingController(),
            controllerId: TextEditingController(),
            officeId: TextEditingController(),
            routeDetailsDataList: state.routeDetailsDataList,
            selectedRouteDetailsDataList: state.selectedRouteDetailsDataList,
            boardingPointDataList: state.boardingPointDataList,
            selectedBoardingPointDataList: state.selectedBoardingPointDataList,
            transportRegisterDetails: state.transportRegisterDetails,
            transportStatusData: <TransportStatusHiveData>[],
            transportAfterRegisterDetails: state.transportAfterRegisterDetails,
          );
        }
      } else if (decryptedData.mapData!['Status'] != 'Success') {
        state = TransportStateError(
          successMessage: '',
          errorMessage: '',
          studentId: TextEditingController(),
          academicyearId: TextEditingController(),
          boardingpointId: TextEditingController(),
          busrouteId: TextEditingController(),
          controllerId: TextEditingController(),
          officeId: TextEditingController(),
          routeDetailsDataList: state.routeDetailsDataList,
          selectedRouteDetailsDataList: state.selectedRouteDetailsDataList,
          boardingPointDataList: state.boardingPointDataList,
          selectedBoardingPointDataList: state.selectedBoardingPointDataList,
          transportRegisterDetails: state.transportRegisterDetails,
          transportStatusData: <TransportStatusHiveData>[],
          transportAfterRegisterDetails: state.transportAfterRegisterDetails,
        );
      }
    } else if (response.$1 != 200) {
      state = TransportStateError(
        successMessage: '',
        errorMessage: 'Error',
        studentId: TextEditingController(),
        academicyearId: TextEditingController(),
        boardingpointId: TextEditingController(),
        busrouteId: TextEditingController(),
        controllerId: TextEditingController(),
        officeId: TextEditingController(),
        routeDetailsDataList: state.routeDetailsDataList,
        selectedRouteDetailsDataList: state.selectedRouteDetailsDataList,
        boardingPointDataList: state.boardingPointDataList,
        selectedBoardingPointDataList: state.selectedBoardingPointDataList,
        transportRegisterDetails: state.transportRegisterDetails,
        transportStatusData: <TransportStatusHiveData>[],
        transportAfterRegisterDetails: state.transportAfterRegisterDetails,
      );
    }
  }

  Future<void> getTransportStatusHiveDetails(String search) async {
    try {
      final box = await Hive.openBox<TransportStatusHiveData>(
        'transportStatus',
      );
      final transportStatusHiveData = <TransportStatusHiveData>[
        ...box.values,
      ];

      state = state.copyWith(transportStatusData: transportStatusHiveData);
      await box.close();
    } catch (e) {
      await getTransportStatusHiveDetails(search);
    }
  }

  Future<void> getRouteIdDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getRequestRoutes', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableTransport(
        successMessage: '',
        errorMessage: '',
        studentId: TextEditingController(),
        academicyearId: TextEditingController(),
        boardingpointId: TextEditingController(),
        busrouteId: TextEditingController(),
        controllerId: TextEditingController(),
        officeId: TextEditingController(),
        routeDetailsDataList: <RouteDetailsHiveData>[],
        selectedRouteDetailsDataList: RouteDetailsHiveData.empty,
        boardingPointDataList: state.boardingPointDataList,
        selectedBoardingPointDataList: state.selectedBoardingPointDataList,
        transportRegisterDetails: state.transportRegisterDetails,
        transportStatusData: state.transportStatusData,
        transportAfterRegisterDetails: state.transportAfterRegisterDetails,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final routeIDRes =
          details['getRequestRoutesResponse'] as Map<String, dynamic>;
      final returnData = routeIDRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      if (decryptedData.mapData!['Status'] == 'Success') {
        final listData = decryptedData.mapData!['Data'] as List<dynamic>;
        final box = await Hive.openBox<RouteDetailsHiveData>(
          'routeDetails',
        );
        if (listData.isNotEmpty) {
          if (box.isEmpty) {
            for (var i = 0; i < listData.length; i++) {
              final parseData = RouteDetailsHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          } else {
            await box.clear();
            for (var i = 0; i < listData.length; i++) {
              final parseData = RouteDetailsHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          }
          await box.close();
          // var routeDetailsDataList = state.routeDetailsDataList;
          // log('decrypted >>>>>>>>$decryptedData');

          // try {
          //   final routeResponse =
          //       TransportRequestRoutes.fromJson(decryptedData.mapData!);
          //   routeDetailsDataList = routeResponse.data!;
          //   state = state.copyWith(routeDetailsDataList: routeDetailsDataList);

          state = TransportStateSuccessful(
            successMessage: '',
            errorMessage: '',
            studentId: TextEditingController(),
            academicyearId: TextEditingController(),
            boardingpointId: TextEditingController(),
            busrouteId: TextEditingController(),
            controllerId: TextEditingController(),
            officeId: TextEditingController(),
            routeDetailsDataList: <RouteDetailsHiveData>[],
            selectedRouteDetailsDataList: RouteDetailsHiveData.empty,
            boardingPointDataList: state.boardingPointDataList,
            selectedBoardingPointDataList: state.selectedBoardingPointDataList,
            transportRegisterDetails: state.transportRegisterDetails,
            transportStatusData: state.transportStatusData,
            transportAfterRegisterDetails: state.transportAfterRegisterDetails,
          );
        } else {
          final error = ErrorModel.fromJson(decryptedData.mapData!);
          state = TransportStateError(
            successMessage: '',
            errorMessage: error.message!,
            studentId: TextEditingController(),
            academicyearId: TextEditingController(),
            boardingpointId: TextEditingController(),
            busrouteId: TextEditingController(),
            controllerId: TextEditingController(),
            officeId: TextEditingController(),
            routeDetailsDataList: <RouteDetailsHiveData>[],
            selectedRouteDetailsDataList: RouteDetailsHiveData.empty,
            boardingPointDataList: state.boardingPointDataList,
            selectedBoardingPointDataList: state.selectedBoardingPointDataList,
            transportRegisterDetails: state.transportRegisterDetails,
            transportStatusData: state.transportStatusData,
            transportAfterRegisterDetails: state.transportAfterRegisterDetails,
          );
        }
      } else if (decryptedData.mapData!['Status'] != 'Success') {
        state = TransportStateError(
          successMessage: '',
          errorMessage: 'Error',
          studentId: TextEditingController(),
          academicyearId: TextEditingController(),
          boardingpointId: TextEditingController(),
          busrouteId: TextEditingController(),
          controllerId: TextEditingController(),
          officeId: TextEditingController(),
          routeDetailsDataList: <RouteDetailsHiveData>[],
          selectedRouteDetailsDataList: RouteDetailsHiveData.empty,
          boardingPointDataList: state.boardingPointDataList,
          selectedBoardingPointDataList: state.selectedBoardingPointDataList,
          transportRegisterDetails: state.transportRegisterDetails,
          transportStatusData: state.transportStatusData,
          transportAfterRegisterDetails: state.transportAfterRegisterDetails,
        );
      }
    } else if (response.$1 != 200) {
      state = TransportStateError(
        successMessage: '',
        errorMessage: 'Error',
        studentId: TextEditingController(),
        academicyearId: TextEditingController(),
        boardingpointId: TextEditingController(),
        busrouteId: TextEditingController(),
        controllerId: TextEditingController(),
        officeId: TextEditingController(),
        routeDetailsDataList: <RouteDetailsHiveData>[],
        selectedRouteDetailsDataList: RouteDetailsHiveData.empty,
        boardingPointDataList: state.boardingPointDataList,
        selectedBoardingPointDataList: state.selectedBoardingPointDataList,
        transportRegisterDetails: state.transportRegisterDetails,
        transportStatusData: state.transportStatusData,
        transportAfterRegisterDetails: state.transportAfterRegisterDetails,
      );
    }
  }

  Future<void> getRouteIdHiveDetails(String search) async {
    _setLoading();
    try {
      final box = await Hive.openBox<RouteDetailsHiveData>(
        'routeDetails',
      );
      final routeHiveData = <RouteDetailsHiveData>[
        ...box.values,
      ];

      state = state.copyWith(routeDetailsDataList: routeHiveData);
      await box.close();
    } catch (e) {
      await getTransportStatusHiveDetails(search);
    }
  }

  void setsubtype(RouteDetailsHiveData data, EncryptionProvider encrypt) {
    state = state.copyWith(
      selectedRouteDetailsDataList: data,
    );

    getBoardingIdDetails(encrypt);
  }

  Future<void> getBoardingIdDetails(EncryptionProvider encrypt) async {
    log('enters boarding');
    // _setLoading();
    log(
      'body >>>>>><studentid>${TokensManagement.studentId}</studentid><busrouteid>${state.selectedRouteDetailsDataList.busrouteid}</busrouteid>',
    );
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><busrouteid>${state.selectedRouteDetailsDataList.busrouteid}</busrouteid>',
    );
    final response =
        await HttpService.sendSoapRequest('getRouteBoardingPoint', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableTransport(
        successMessage: '',
        errorMessage: '',
        studentId: TextEditingController(),
        academicyearId: TextEditingController(),
        boardingpointId: TextEditingController(),
        busrouteId: TextEditingController(),
        controllerId: TextEditingController(),
        officeId: TextEditingController(),
        routeDetailsDataList: state.routeDetailsDataList,
        selectedRouteDetailsDataList: state.selectedRouteDetailsDataList,
        boardingPointDataList: <BoardingPointHiveData>[],
        selectedBoardingPointDataList: BoardingPointHiveData.empty,
        transportRegisterDetails: state.transportRegisterDetails,
        transportStatusData: state.transportStatusData,
        transportAfterRegisterDetails: state.transportAfterRegisterDetails,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final borderidRes =
          details['getRouteBoardingPointResponse'] as Map<String, dynamic>;
      final returnData = borderidRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      if (decryptedData.mapData!['Status'] == 'Success') {
        // var boardingPointDataList = state.boardingPointDataList;
        // log('decrypted >>>>>>>>$decryptedData');
        final listData = decryptedData.mapData!['Data'] as List<dynamic>;
        if (listData.isNotEmpty) {
          final box = await Hive.openBox<BoardingPointHiveData>(
            'boardingPoint',
          );
          if (box.isEmpty) {
            for (var i = 0; i < listData.length; i++) {
              final parseData = BoardingPointHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          } else {
            await box.clear();
            for (var i = 0; i < listData.length; i++) {
              final parseData = BoardingPointHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          }
          await box.close();
          // final borderidResponse =
          //     BorderPointModel.fromJson(decryptedData.mapData!);
          // boardingPointDataList = borderidResponse.data!;
          // state = state.copyWith(boardingPointDataList: boardingPointDataList);

          await getBoardingPointHiveDetails('');
        } else {
          final error = ErrorModel.fromJson(decryptedData.mapData!);
          state = TransportStateError(
            successMessage: '',
            errorMessage: error.message!,
            studentId: TextEditingController(),
            academicyearId: TextEditingController(),
            boardingpointId: TextEditingController(),
            busrouteId: TextEditingController(),
            controllerId: TextEditingController(),
            officeId: TextEditingController(),
            routeDetailsDataList: state.routeDetailsDataList,
            selectedRouteDetailsDataList: state.selectedRouteDetailsDataList,
            boardingPointDataList: <BoardingPointHiveData>[],
            selectedBoardingPointDataList: BoardingPointHiveData.empty,
            transportRegisterDetails: state.transportRegisterDetails,
            transportStatusData: state.transportStatusData,
            transportAfterRegisterDetails: state.transportAfterRegisterDetails,
          );
        }
      } else if (decryptedData.mapData!['Status'] != 'Success') {
        state = TransportStateError(
          successMessage: '',
          errorMessage: 'Error',
          studentId: TextEditingController(),
          academicyearId: TextEditingController(),
          boardingpointId: TextEditingController(),
          busrouteId: TextEditingController(),
          controllerId: TextEditingController(),
          officeId: TextEditingController(),
          routeDetailsDataList: state.routeDetailsDataList,
          selectedRouteDetailsDataList: state.selectedRouteDetailsDataList,
          boardingPointDataList: <BoardingPointHiveData>[],
          selectedBoardingPointDataList: BoardingPointHiveData.empty,
          transportRegisterDetails: state.transportRegisterDetails,
          transportStatusData: state.transportStatusData,
          transportAfterRegisterDetails: state.transportAfterRegisterDetails,
        );
      }
    } else if (response.$1 != 200) {
      state = TransportStateError(
        successMessage: '',
        errorMessage: 'Error',
        studentId: TextEditingController(),
        academicyearId: TextEditingController(),
        boardingpointId: TextEditingController(),
        busrouteId: TextEditingController(),
        controllerId: TextEditingController(),
        officeId: TextEditingController(),
        routeDetailsDataList: state.routeDetailsDataList,
        selectedRouteDetailsDataList: state.selectedRouteDetailsDataList,
        boardingPointDataList: <BoardingPointHiveData>[],
        selectedBoardingPointDataList: BoardingPointHiveData.empty,
        transportRegisterDetails: state.transportRegisterDetails,
        transportStatusData: state.transportStatusData,
        transportAfterRegisterDetails: state.transportAfterRegisterDetails,
      );
    }
  }

  Future<void> getBoardingPointHiveDetails(String search) async {
    log('enters hive boading ');
    // _setLoading();
    try {
      log('enters try');
      final box = await Hive.openBox<BoardingPointHiveData>(
        'boardingPoint',
      );
      final boardingPointHiveData = <BoardingPointHiveData>[
        ...box.values,
      ];

      state = state.copyWith(boardingPointDataList: boardingPointHiveData);
      log('data boarding>>${state.boardingPointDataList.length}');
      await box.close();
    } catch (e) {
      log('enters catch');
      await getBoardingPointHiveDetails(search);
    }
  }

  void setBorderRoute(BoardingPointHiveData data) {
    state = state.copyWith(
      selectedBoardingPointDataList: data,
    );
  }

  Future<void> saveTransportstatusDetails(EncryptionProvider encrypt) async {
    log(
      '<studentid>${TokensManagement.studentId}</studentid><academicyearid>${state.academicyearId.text}</academicyearid><boardingpointid>${state.boardingpointId.text}</boardingpointid><busrouteid>${state.selectedRouteDetailsDataList}</busrouteid><controllerid>${state.controllerId.text}</controllerid><officeid>${state.officeId.text}</officeid>',
    );
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><academicyearid>${state.transportRegisterDetails!.academicyearid}</academicyearid><boardingpointid>${state.selectedBoardingPointDataList.busboardingpointid}</boardingpointid><busrouteid>${state.selectedRouteDetailsDataList.busrouteid}</busrouteid><controllerid>${state.transportRegisterDetails!.controllerid}</controllerid><officeid>${state.transportRegisterDetails!.officeid}</officeid>',
    );
    final response =
        await HttpService.sendSoapRequest('insertTransportRequest', data);

    if (response.$1 == 0) {
      state = NoNetworkAvailableTransport(
        successMessage: '',
        errorMessage: '',
        studentId: state.studentId,
        academicyearId: state.academicyearId,
        boardingpointId: state.boardingpointId,
        busrouteId: state.busrouteId,
        controllerId: state.controllerId,
        routeDetailsDataList: state.routeDetailsDataList,
        officeId: state.officeId,
        selectedRouteDetailsDataList: state.selectedRouteDetailsDataList,
        boardingPointDataList: state.boardingPointDataList,
        selectedBoardingPointDataList: state.selectedBoardingPointDataList,
        transportRegisterDetails: state.transportRegisterDetails,
        transportStatusData: state.transportStatusData,
        transportAfterRegisterDetails: state.transportAfterRegisterDetails,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final saveTransportRes =
          details['insertTransportRequestResponse'] as Map<String, dynamic>;
      final returnData = saveTransportRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      log('Status >>>> ${decryptedData.mapData!['Status']}');

      if (decryptedData.mapData!['Status'] == 'Success') {
        state = TransportStateSuccessful(
          successMessage: '${decryptedData.mapData!['Status']}',
          errorMessage: '',
          studentId: TextEditingController(),
          academicyearId: TextEditingController(),
          boardingpointId: TextEditingController(),
          busrouteId: TextEditingController(),
          controllerId: TextEditingController(),
          officeId: TextEditingController(),
          routeDetailsDataList: state.routeDetailsDataList,
          selectedRouteDetailsDataList: state.selectedRouteDetailsDataList,
          boardingPointDataList: state.boardingPointDataList,
          selectedBoardingPointDataList: state.selectedBoardingPointDataList,
          transportRegisterDetails: state.transportRegisterDetails,
          transportStatusData: state.transportStatusData,
          transportAfterRegisterDetails: state.transportAfterRegisterDetails,
        );
      } else {
        state = TransportStateError(
          successMessage: '',
          errorMessage: '${decryptedData.mapData!['Status']}',
          studentId: state.studentId,
          academicyearId: state.academicyearId,
          boardingpointId: state.boardingpointId,
          busrouteId: state.busrouteId,
          controllerId: state.controllerId,
          routeDetailsDataList: state.routeDetailsDataList,
          officeId: state.officeId,
          selectedRouteDetailsDataList: state.selectedRouteDetailsDataList,
          boardingPointDataList: state.boardingPointDataList,
          selectedBoardingPointDataList: state.selectedBoardingPointDataList,
          transportRegisterDetails: state.transportRegisterDetails,
          transportStatusData: state.transportStatusData,
          transportAfterRegisterDetails: state.transportAfterRegisterDetails,
        );
      }
    } else if (response.$1 != 200) {
      state = TransportStateError(
        successMessage: '',
        errorMessage: 'Error',
        studentId: state.studentId,
        academicyearId: state.academicyearId,
        boardingpointId: state.boardingpointId,
        busrouteId: state.busrouteId,
        controllerId: state.controllerId,
        routeDetailsDataList: state.routeDetailsDataList,
        officeId: state.officeId,
        selectedRouteDetailsDataList: state.selectedRouteDetailsDataList,
        boardingPointDataList: state.boardingPointDataList,
        selectedBoardingPointDataList: state.selectedBoardingPointDataList,
        transportRegisterDetails: state.transportRegisterDetails,
        transportStatusData: state.transportStatusData,
        transportAfterRegisterDetails: state.transportAfterRegisterDetails,
      );
    }
  }

  Future<void> gettransportRegisterDetails(EncryptionProvider encrypt) async {
    log('enters trans');
    // _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );

    final response = await HttpService.sendSoapRequest(
      'getTransportRegistrationStatus',
      data,
    );
    if (response.$1 == 0) {
      state = NoNetworkAvailableTransport(
        successMessage: '',
        errorMessage: 'No Network. Connect to Internet',
        studentId: TextEditingController(),
        academicyearId: TextEditingController(),
        boardingpointId: TextEditingController(),
        busrouteId: TextEditingController(),
        controllerId: TextEditingController(),
        officeId: TextEditingController(),
        routeDetailsDataList: state.routeDetailsDataList,
        selectedRouteDetailsDataList: RouteDetailsHiveData.empty,
        boardingPointDataList: state.boardingPointDataList,
        selectedBoardingPointDataList: BoardingPointHiveData.empty,
        transportRegisterDetails: state.transportRegisterDetails,
        transportStatusData: state.transportStatusData,
        transportAfterRegisterDetails: state.transportAfterRegisterDetails,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final getTransportRegistrationStatusRes =
          details['getTransportRegistrationStatusResponse']
              as Map<String, dynamic>;
      final returnData =
          getTransportRegistrationStatusRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      log('Transport Register >>>>>>>> ${decryptedData.mapData}');

      // var transportRegisterDetails = TransportRegisterHiveData.empty;

      // var transportAfterRegisterDetails = TransportAfterRegisterData.empty;
      log('status>>>>${decryptedData.mapData!['Data'][0]['status']}');
      if (decryptedData.mapData!['Status'] == 'Success') {
        if (decryptedData.mapData!['Data'][0]['status'] == '0' &&
            decryptedData.mapData!['Data'][0]['regconfig'] == '1') {
          final listData = decryptedData.mapData!['Data'][0] as List<dynamic>;
          if (listData.isNotEmpty) {
            final box = await Hive.openBox<TransportRegisterHiveData>(
              'transportRegister',
            );
            if (box.isEmpty) {
              for (var i = 0; i < listData.length; i++) {
                final parseData = TransportRegisterHiveData.fromJson(
                  listData[i] as Map<String, dynamic>,
                );
                log('dataparse>>>$parseData');
                await box.add(parseData);
              }
            } else {
              await box.clear();
              for (var i = 0; i < listData.length; i++) {
                final parseData = TransportRegisterHiveData.fromJson(
                  listData[i] as Map<String, dynamic>,
                );

                await box.add(parseData);
              }
            }
            await box.close();
          } else {
            final error = ErrorModel.fromJson(decryptedData.mapData!);
            state = TransportStateError(
              successMessage: '',
              errorMessage: '$error',
              studentId: TextEditingController(),
              academicyearId: TextEditingController(),
              boardingpointId: TextEditingController(),
              busrouteId: TextEditingController(),
              controllerId: TextEditingController(),
              officeId: TextEditingController(),
              routeDetailsDataList: state.routeDetailsDataList,
              selectedRouteDetailsDataList: RouteDetailsHiveData.empty,
              boardingPointDataList: state.boardingPointDataList,
              selectedBoardingPointDataList: BoardingPointHiveData.empty,
              transportRegisterDetails: TransportRegisterHiveData.empty,
              transportStatusData: state.transportStatusData,
              transportAfterRegisterDetails:
                  TransportAfterRegisterHiveData.empty,
            );
          }
        } else {
          final listData =
              decryptedData.mapData!['Data'][0] as Map<String, dynamic>;
          if (listData.isNotEmpty) {
            final box = await Hive.openBox<TransportAfterRegisterHiveData>(
              'transportAfterRegister',
            );
            if (box.isEmpty) {
              for (var i = 0; i < listData.length; i++) {
                final parseData = TransportAfterRegisterHiveData.fromJson(
                  listData,
                );

                await box.add(parseData);
              }
            } else {
              await box.clear();
              for (var i = 0; i < listData.length; i++) {
                final parseData = TransportAfterRegisterHiveData.fromJson(
                  listData,
                );

                await box.add(parseData);
              }
            }
            await box.close();
          } else {
            final error = ErrorModel.fromJson(decryptedData.mapData!);
            state = TransportStateError(
              successMessage: '',
              errorMessage: '$error',
              studentId: TextEditingController(),
              academicyearId: TextEditingController(),
              boardingpointId: TextEditingController(),
              busrouteId: TextEditingController(),
              controllerId: TextEditingController(),
              officeId: TextEditingController(),
              routeDetailsDataList: state.routeDetailsDataList,
              selectedRouteDetailsDataList: RouteDetailsHiveData.empty,
              boardingPointDataList: state.boardingPointDataList,
              selectedBoardingPointDataList: BoardingPointHiveData.empty,
              transportRegisterDetails: TransportRegisterHiveData.empty,
              transportStatusData: state.transportStatusData,
              transportAfterRegisterDetails:
                  TransportAfterRegisterHiveData.empty,
            );
          }
        }
      } else if (decryptedData.mapData!['Status'] != 'Success') {
        log('enters here !success');
        state = TransportStateError(
          successMessage: '',
          errorMessage: 'Error',
          studentId: TextEditingController(),
          academicyearId: TextEditingController(),
          boardingpointId: TextEditingController(),
          busrouteId: TextEditingController(),
          controllerId: TextEditingController(),
          officeId: TextEditingController(),
          routeDetailsDataList: state.routeDetailsDataList,
          selectedRouteDetailsDataList: RouteDetailsHiveData.empty,
          boardingPointDataList: state.boardingPointDataList,
          selectedBoardingPointDataList: BoardingPointHiveData.empty,
          transportRegisterDetails: TransportRegisterHiveData.empty,
          transportStatusData: state.transportStatusData,
          transportAfterRegisterDetails: state.transportAfterRegisterDetails,
        );
      }
    } else if (response.$1 != 200) {
      state = TransportStateError(
        successMessage: '',
        errorMessage: 'Error',
        studentId: TextEditingController(),
        academicyearId: TextEditingController(),
        boardingpointId: TextEditingController(),
        busrouteId: TextEditingController(),
        controllerId: TextEditingController(),
        officeId: TextEditingController(),
        routeDetailsDataList: state.routeDetailsDataList,
        selectedRouteDetailsDataList: RouteDetailsHiveData.empty,
        boardingPointDataList: state.boardingPointDataList,
        selectedBoardingPointDataList: BoardingPointHiveData.empty,
        transportRegisterDetails: TransportRegisterHiveData.empty,
        transportStatusData: state.transportStatusData,
        transportAfterRegisterDetails: state.transportAfterRegisterDetails,
      );
    }
  }

  Future<void> getTransportHiveRegisterDetails(String search) async {
    try {
      final box = await Hive.openBox<TransportRegisterHiveData>(
        'transportRegister',
      );
      final transportRegister = <TransportRegisterHiveData>[
        ...box.values,
      ];

      state = state.copyWith(transportRegisterDetails: transportRegister[0]);
      await box.close();
    } catch (e) {
      await getTransportStatusHiveDetails(search);
    }
  }

  Future<void> getTransportHiveAfterRegisterDetails(String search) async {
    try {
      final box = await Hive.openBox<TransportAfterRegisterHiveData>(
        'transportAfterRegister',
      );
      final transportAfterRegister = <TransportAfterRegisterHiveData>[
        ...box.values,
      ];

      state = state.copyWith(
          transportAfterRegisterDetails: transportAfterRegister[0]);
      await box.close();
    } catch (e) {
      await getTransportStatusHiveDetails(search);
    }
  }
}

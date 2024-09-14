import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/transport/model/border_point_model.dart';
import 'package:sample/home/main_pages/transport/model/route_model.dart';
import 'package:sample/home/main_pages/transport/model/transport_after_register_model.dart';
import 'package:sample/home/main_pages/transport/model/transport_register_model.dart';
import 'package:sample/home/main_pages/transport/model/transport_status.dart';
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
        routeDetailsDataList: <RouteDetailsData>[],
        selectedRouteDetailsDataList: RouteDetailsData.empty,
        borderpointDataList: <BorderPointData>[],
        selectedborderpointDataList: BorderPointData.empty,
        transportRegisterDetails: TransportRegisterData.empty,
        grievanceTransportStatusData: <TransportStatusData>[],
        transportAfterRegisterDetails: TransportAfterRegisterData.empty,
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
        borderpointDataList: state.borderpointDataList,
        selectedborderpointDataList: state.selectedborderpointDataList,
        transportRegisterDetails: state.transportRegisterDetails,
        grievanceTransportStatusData: state.grievanceTransportStatusData,
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

      var transportStatusData = state.grievanceTransportStatusData;
      log('decrypted >>>>>>>> $decryptedData');

      try {
        final transportdataResponse = getTransportRegistrationStatusModel
            .fromJson(decryptedData.mapData!);
        transportStatusData = transportdataResponse.data!;
        state = state.copyWith(
          grievanceTransportStatusData: transportStatusData,
        );

        if (transportdataResponse.status == 'Success') {
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
            borderpointDataList: state.borderpointDataList,
            selectedborderpointDataList: state.selectedborderpointDataList,
            transportRegisterDetails: state.transportRegisterDetails,
            grievanceTransportStatusData: state.grievanceTransportStatusData,
            transportAfterRegisterDetails: state.transportAfterRegisterDetails,
          );
        } else if (transportdataResponse.status != 'Success') {
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
            borderpointDataList: state.borderpointDataList,
            selectedborderpointDataList: state.selectedborderpointDataList,
            transportRegisterDetails: state.transportRegisterDetails,
            grievanceTransportStatusData: state.grievanceTransportStatusData,
            transportAfterRegisterDetails: state.transportAfterRegisterDetails,
          );
        }
      } catch (e) {
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
          borderpointDataList: state.borderpointDataList,
          selectedborderpointDataList: state.selectedborderpointDataList,
          transportRegisterDetails: state.transportRegisterDetails,
          grievanceTransportStatusData: state.grievanceTransportStatusData,
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
        borderpointDataList: state.borderpointDataList,
        selectedborderpointDataList: state.selectedborderpointDataList,
        transportRegisterDetails: state.transportRegisterDetails,
        grievanceTransportStatusData: state.grievanceTransportStatusData,
        transportAfterRegisterDetails: state.transportAfterRegisterDetails,
      );
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
        routeDetailsDataList: <RouteDetailsData>[],
        selectedRouteDetailsDataList: RouteDetailsData.empty,
        borderpointDataList: <BorderPointData>[],
        selectedborderpointDataList: BorderPointData.empty,
        transportRegisterDetails: TransportRegisterData.empty,
        grievanceTransportStatusData: <TransportStatusData>[],
        transportAfterRegisterDetails: TransportAfterRegisterData.empty,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final RouteIDRes =
          details['getRequestRoutesResponse'] as Map<String, dynamic>;
      final returnData = RouteIDRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      var routeDetailsDataList = state.routeDetailsDataList;
      log('decrypted >>>>>>>>$decryptedData');

      try {
        final routeResponse =
            TransportRequestRoutes.fromJson(decryptedData.mapData!);
        routeDetailsDataList = routeResponse.data!;
        state = state.copyWith(routeDetailsDataList: routeDetailsDataList);
        if (routeResponse.status == 'Success') {
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
            borderpointDataList: <BorderPointData>[],
            selectedborderpointDataList: BorderPointData.empty,
            transportRegisterDetails: TransportRegisterData.empty,
            grievanceTransportStatusData: <TransportStatusData>[],
            transportAfterRegisterDetails: TransportAfterRegisterData.empty,
          );
        } else if (routeResponse.status != 'Success') {
          state = TransportStateError(
            successMessage: '',
            errorMessage: 'Error',
            studentId: TextEditingController(),
            academicyearId: TextEditingController(),
            boardingpointId: TextEditingController(),
            busrouteId: TextEditingController(),
            controllerId: TextEditingController(),
            officeId: TextEditingController(),
            routeDetailsDataList: <RouteDetailsData>[],
            selectedRouteDetailsDataList: RouteDetailsData.empty,
            borderpointDataList: <BorderPointData>[],
            selectedborderpointDataList: BorderPointData.empty,
            transportRegisterDetails: TransportRegisterData.empty,
            grievanceTransportStatusData: <TransportStatusData>[],
            transportAfterRegisterDetails: TransportAfterRegisterData.empty,
          );
        }
      } catch (e) {
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
          routeDetailsDataList: <RouteDetailsData>[],
          selectedRouteDetailsDataList: RouteDetailsData.empty,
          borderpointDataList: <BorderPointData>[],
          selectedborderpointDataList: BorderPointData.empty,
          transportRegisterDetails: TransportRegisterData.empty,
          grievanceTransportStatusData: <TransportStatusData>[],
          transportAfterRegisterDetails: TransportAfterRegisterData.empty,
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
        routeDetailsDataList: <RouteDetailsData>[],
        selectedRouteDetailsDataList: RouteDetailsData.empty,
        borderpointDataList: <BorderPointData>[],
        selectedborderpointDataList: BorderPointData.empty,
        transportRegisterDetails: TransportRegisterData.empty,
        grievanceTransportStatusData: <TransportStatusData>[],
        transportAfterRegisterDetails: TransportAfterRegisterData.empty,
      );
    }
  }

  void setsubtype(RouteDetailsData data, EncryptionProvider encrypt) {
    state = state.copyWith(
      selectedRouteDetailsDataList: data,
    );
    getBorderIdDetails(encrypt);
  }

  Future<void> getBorderIdDetails(EncryptionProvider encrypt) async {
    // _setLoading();
    log(
      '<studentid>${TokensManagement.studentId}</studentid><busrouteid>${state.selectedRouteDetailsDataList.busrouteid}</busrouteid>',
    );
    // _setLoading();
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
        borderpointDataList: <BorderPointData>[],
        selectedborderpointDataList: BorderPointData.empty,
        transportRegisterDetails: TransportRegisterData.empty,
        grievanceTransportStatusData: <TransportStatusData>[],
        transportAfterRegisterDetails: state.transportAfterRegisterDetails,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final borderidRes =
          details['getRouteBoardingPointResponse'] as Map<String, dynamic>;
      final returnData = borderidRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      var borderpointDataList = state.borderpointDataList;
      log('decrypted >>>>>>>>$decryptedData');

      try {
        final borderidResponse =
            BorderPointModel.fromJson(decryptedData.mapData!);
        borderpointDataList = borderidResponse.data!;
        state = state.copyWith(borderpointDataList: borderpointDataList);
        if (borderidResponse.status == 'Success') {
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
            borderpointDataList: state.borderpointDataList,
            selectedborderpointDataList: state.selectedborderpointDataList,
            transportRegisterDetails: state.transportRegisterDetails,
            grievanceTransportStatusData: state.grievanceTransportStatusData,
            transportAfterRegisterDetails: state.transportAfterRegisterDetails,
          );
        } else if (borderidResponse.status != 'Success') {
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
            borderpointDataList: <BorderPointData>[],
            selectedborderpointDataList: BorderPointData.empty,
            transportRegisterDetails: TransportRegisterData.empty,
            grievanceTransportStatusData: <TransportStatusData>[],
            transportAfterRegisterDetails: TransportAfterRegisterData.empty,
          );
        }
      } catch (e) {
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
          borderpointDataList: <BorderPointData>[],
          selectedborderpointDataList: BorderPointData.empty,
          transportRegisterDetails: TransportRegisterData.empty,
          grievanceTransportStatusData: <TransportStatusData>[],
          transportAfterRegisterDetails: TransportAfterRegisterData.empty,
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
        borderpointDataList: <BorderPointData>[],
        selectedborderpointDataList: BorderPointData.empty,
        transportRegisterDetails: TransportRegisterData.empty,
        grievanceTransportStatusData: <TransportStatusData>[],
        transportAfterRegisterDetails: TransportAfterRegisterData.empty,
      );
    }
  }

  void setBorderRoute(BorderPointData data) {
    state = state.copyWith(
      selectedborderpointDataList: data,
    );
  }

  Future<void> saveTransportstatusDetails(EncryptionProvider encrypt) async {
    log(
      '<studentid>${TokensManagement.studentId}</studentid><academicyearid>${state.academicyearId.text}</academicyearid><boardingpointid>${state.boardingpointId.text}</boardingpointid><busrouteid>${state.selectedRouteDetailsDataList}</busrouteid><controllerid>${state.controllerId.text}</controllerid><officeid>${state.officeId.text}</officeid>',
    );
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><academicyearid>${state.transportRegisterDetails!.academicyearid}</academicyearid><boardingpointid>${state.selectedborderpointDataList.busboardingpointid}</boardingpointid><busrouteid>${state.selectedRouteDetailsDataList.busrouteid}</busrouteid><controllerid>${state.transportRegisterDetails!.controllerid}</controllerid><officeid>${state.transportRegisterDetails!.officeid}</officeid>',
    );
    final response =
        await HttpService.sendSoapRequest('insertTransportRequest', data);

    if (response.$1 == 0) {
      state = NoNetworkAvailableTransport(
        successMessage: '',
        errorMessage: '',
        studentId: TextEditingController(),
        academicyearId: TextEditingController(),
        boardingpointId: TextEditingController(),
        busrouteId: TextEditingController(),
        controllerId: TextEditingController(),
        routeDetailsDataList: state.routeDetailsDataList,
        officeId: TextEditingController(),
        selectedRouteDetailsDataList: state.selectedRouteDetailsDataList,
        borderpointDataList: state.borderpointDataList,
        selectedborderpointDataList: state.selectedborderpointDataList,
        transportRegisterDetails: state.transportRegisterDetails,
        grievanceTransportStatusData: state.grievanceTransportStatusData,
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
          borderpointDataList: state.borderpointDataList,
          selectedborderpointDataList: state.selectedborderpointDataList,
          transportRegisterDetails: state.transportRegisterDetails,
          grievanceTransportStatusData: state.grievanceTransportStatusData,
          transportAfterRegisterDetails: state.transportAfterRegisterDetails,
        );
      } else {
        state = TransportStateError(
          successMessage: '',
          errorMessage: '${decryptedData.mapData!['Status']}',
          studentId: TextEditingController(),
          academicyearId: TextEditingController(),
          boardingpointId: TextEditingController(),
          busrouteId: TextEditingController(),
          controllerId: TextEditingController(),
          officeId: TextEditingController(),
          routeDetailsDataList: state.routeDetailsDataList,
          selectedRouteDetailsDataList: state.selectedRouteDetailsDataList,
          borderpointDataList: state.borderpointDataList,
          selectedborderpointDataList: state.selectedborderpointDataList,
          transportRegisterDetails: state.transportRegisterDetails,
          grievanceTransportStatusData: state.grievanceTransportStatusData,
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
        borderpointDataList: state.borderpointDataList,
        selectedborderpointDataList: state.selectedborderpointDataList,
        transportRegisterDetails: state.transportRegisterDetails,
        grievanceTransportStatusData: state.grievanceTransportStatusData,
        transportAfterRegisterDetails: state.transportAfterRegisterDetails,
      );
    }
  }

  Future<void> gettransportRegisterDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    log(
      'transportRegister>>>>>  <studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response = await HttpService.sendSoapRequest(
        'getTransportRegistrationStatus', data);
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
        borderpointDataList: <BorderPointData>[],
        selectedborderpointDataList: BorderPointData.empty,
        transportRegisterDetails: TransportRegisterData.empty,
        grievanceTransportStatusData: <TransportStatusData>[],
        transportAfterRegisterDetails: TransportAfterRegisterData.empty,
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

      var transportRegisterDetails = TransportRegisterData.empty;

      var transportAfterRegisterDetails = TransportAfterRegisterData.empty;

      if (decryptedData.mapData!['Status'] == 'Success') {
        if (decryptedData.mapData!['Data'][0]['status'] == '0') {
          log('enters status==0');
          final transportRegisterResponse =
              GetTransportRegistrationStateModel.fromJson(
                  decryptedData.mapData!);

          transportRegisterDetails = transportRegisterResponse.data![0];
          state = state.copyWith(
            transportRegisterDetails: transportRegisterDetails,
          );
        } else {
          log('enters status==1');
          final transportAfterRegisterResponse =
              GetTransportAfterRegistrationStateModel.fromJson(
            decryptedData.mapData!,
          );

          transportAfterRegisterDetails =
              transportAfterRegisterResponse.data![0];
          state = state.copyWith(
            transportAfterRegisterDetails: transportAfterRegisterDetails,
          );
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
          selectedRouteDetailsDataList: state.selectedRouteDetailsDataList,
          borderpointDataList: <BorderPointData>[],
          selectedborderpointDataList: BorderPointData.empty,
          transportRegisterDetails: TransportRegisterData.empty,
          grievanceTransportStatusData: <TransportStatusData>[],
          transportAfterRegisterDetails: TransportAfterRegisterData.empty,
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
        borderpointDataList: <BorderPointData>[],
        selectedborderpointDataList: BorderPointData.empty,
        transportRegisterDetails: TransportRegisterData.empty,
        grievanceTransportStatusData: <TransportStatusData>[],
        transportAfterRegisterDetails: TransportAfterRegisterData.empty,
      );
    }
  }
}

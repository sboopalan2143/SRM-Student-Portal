import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/transport/model/transport_status.dart';
import 'package:sample/home/main_pages/transport/riverpod/transport_state.dart';

class TrasportProvider extends StateNotifier<TransportState> {
  TrasportProvider() : super(TransportInitial());

  void disposeState() => state = TransportInitial();

  void _setLoading() => state = TransportStateLoading(
        successMessage: '',
        errorMessage: '',
        grievanceTransportStatusData: state.grievanceTransportStatusData,
        studentId: TextEditingController(),
        academicyearId: TextEditingController(),
        boardingpointId: TextEditingController(),
        busrouteId: TextEditingController(),
        controllerId: TextEditingController(),
        officeId: TextEditingController(),
      );

  Future<void> getTransportStatusDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );

    final response = await HttpService.sendSoapRequest(
        'getTransportRegistrationStatus', data,);
    if (response.$1 == 0) {
      state = NoNetworkAvailableTransport(
        successMessage: '',
        errorMessage: '',
        grievanceTransportStatusData: state.grievanceTransportStatusData,
        studentId: TextEditingController(),
        academicyearId: TextEditingController(),
        boardingpointId: TextEditingController(),
        busrouteId: TextEditingController(),
        controllerId: TextEditingController(),
        officeId: TextEditingController(),
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final grievanceTransportStatusDataRes =
          details['getTransportRegistrationStatusResponse']
              as Map<String, dynamic>;
      final returnData =
          grievanceTransportStatusDataRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      var grievanceTransportStatusData = state.grievanceTransportStatusData;
      log('decrypted >>>>>>>> $decryptedData');

      try {
        final transportdataResponse = getTransportRegistrationStatusModel
            .fromJson(decryptedData.mapData!);
        grievanceTransportStatusData = transportdataResponse.data!;
        state = state.copyWith(
            grievanceTransportStatusData: grievanceTransportStatusData,);

        if (transportdataResponse.status == 'Success') {
          state = TransportStateSuccessful(
            successMessage: '',
            errorMessage: '',
            grievanceTransportStatusData: state.grievanceTransportStatusData,
            studentId: TextEditingController(),
            academicyearId: TextEditingController(),
            boardingpointId: TextEditingController(),
            busrouteId: TextEditingController(),
            controllerId: TextEditingController(),
            officeId: TextEditingController(),
          );
        } else if (transportdataResponse.status != 'Success') {
          state = TransportStateError(
            successMessage: '',
            errorMessage: '',
            grievanceTransportStatusData: state.grievanceTransportStatusData,
            studentId: TextEditingController(),
            academicyearId: TextEditingController(),
            boardingpointId: TextEditingController(),
            busrouteId: TextEditingController(),
            controllerId: TextEditingController(),
            officeId: TextEditingController(),
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = TransportStateError(
          successMessage: '',
          errorMessage: error.message!,
          grievanceTransportStatusData: state.grievanceTransportStatusData,
          studentId: TextEditingController(),
          academicyearId: TextEditingController(),
          boardingpointId: TextEditingController(),
          busrouteId: TextEditingController(),
          controllerId: TextEditingController(),
          officeId: TextEditingController(),
        );
      }
    } else if (response.$1 != 200) {
      state = TransportStateError(
        successMessage: '',
        errorMessage: 'Error',
        grievanceTransportStatusData: state.grievanceTransportStatusData,
        studentId: TextEditingController(),
        academicyearId: TextEditingController(),
        boardingpointId: TextEditingController(),
        busrouteId: TextEditingController(),
        controllerId: TextEditingController(),
        officeId: TextEditingController(),
      );
    }
  }

  Future<void> saveTransportstatusDetails(EncryptionProvider encrypt) async {
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><academicyearid>${state.academicyearId.text}</academicyearid><boardingpointid>${state.boardingpointId.text}</boardingpointid><busrouteid>${state.busrouteId.text}</busrouteid><controllerid>${state.controllerId.text}</controllerid><officeid>${state.officeId.text}</officeid>',
    );
    final response =
        await HttpService.sendSoapRequest('insertTransportRequest', data);

    if (response.$1 == 0) {
      state = NoNetworkAvailableTransport(
        successMessage: '',
        errorMessage: '',
        grievanceTransportStatusData: state.grievanceTransportStatusData,
        studentId: TextEditingController(),
        academicyearId: TextEditingController(),
        boardingpointId: TextEditingController(),
        busrouteId: TextEditingController(),
        controllerId: TextEditingController(),
        officeId: TextEditingController(),
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
          grievanceTransportStatusData: state.grievanceTransportStatusData,
          studentId: TextEditingController(),
          academicyearId: TextEditingController(),
          boardingpointId: TextEditingController(),
          busrouteId: TextEditingController(),
          controllerId: TextEditingController(),
          officeId: TextEditingController(),
        );
      } else {
        state = TransportStateError(
          successMessage: '',
          errorMessage: '${decryptedData.mapData!['Status']}',
          grievanceTransportStatusData: state.grievanceTransportStatusData,
          studentId: TextEditingController(),
          academicyearId: TextEditingController(),
          boardingpointId: TextEditingController(),
          busrouteId: TextEditingController(),
          controllerId: TextEditingController(),
          officeId: TextEditingController(),
        );
      }
    } else if (response.$1 != 200) {
      state = TransportStateError(
        successMessage: '',
        errorMessage: 'Error',
        grievanceTransportStatusData: state.grievanceTransportStatusData,
        studentId: TextEditingController(),
        academicyearId: TextEditingController(),
        boardingpointId: TextEditingController(),
        busrouteId: TextEditingController(),
        controllerId: TextEditingController(),
        officeId: TextEditingController(),
      );
    }
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/transport/model/boarding_point_hive_model.dart';
import 'package:sample/home/main_pages/transport/model/route_hive_model.dart';
import 'package:sample/home/main_pages/transport/model/transport_after_reg_hive_model.dart';
import 'package:sample/home/main_pages/transport/model/transport_after_register_model.dart';
import 'package:sample/home/main_pages/transport/model/transport_register_hive_model.dart';
import 'package:sample/home/main_pages/transport/model/transport_status_hive_model.dart';
import 'package:sample/home/main_pages/transport/riverpod/transport_provider.dart';

final transportProvider =
    StateNotifierProvider<TrasportProvider, TransportState>((ref) {
  return TrasportProvider();
});

class TransportState {
  const TransportState({
    required this.successMessage,
    required this.errorMessage,
    required this.transportStatusData,
    required this.studentId,
    required this.academicyearId,
    required this.boardingpointId,
    required this.busrouteId,
    required this.controllerId,
    required this.officeId,
    required this.routeDetailsDataList,
    required this.selectedRouteDetailsDataList,
    required this.boardingPointDataList,
    required this.selectedBoardingPointDataList,
    required this.transportRegisterDetails,
    required this.transportAfterRegisterDetails,
  });

  final String successMessage;
  final String errorMessage;
  final List<TransportStatusHiveData> transportStatusData;
  final TextEditingController studentId;
  final TextEditingController academicyearId;
  final TextEditingController boardingpointId;
  final TextEditingController busrouteId;
  final TextEditingController controllerId;
  final TextEditingController officeId;
  final List<RouteDetailsHiveData> routeDetailsDataList;
  final RouteDetailsHiveData selectedRouteDetailsDataList;
  final List<BoardingPointHiveData> boardingPointDataList;
  final BoardingPointHiveData selectedBoardingPointDataList;
  final TransportRegisterHiveData? transportRegisterDetails;
  final TransportAfterRegisterHiveData? transportAfterRegisterDetails;

  TransportState copyWith({
    String? successMessage,
    String? errorMessage,
    List<TransportStatusHiveData>? transportStatusData,
    TextEditingController? studentId,
    TextEditingController? academicyearId,
    TextEditingController? boardingpointId,
    TextEditingController? busrouteId,
    TextEditingController? controllerId,
    TextEditingController? officeId,
    List<RouteDetailsHiveData>? routeDetailsDataList,
    RouteDetailsHiveData? selectedRouteDetailsDataList,
    List<BoardingPointHiveData>? boardingPointDataList,
    BoardingPointHiveData? selectedBoardingPointDataList,
    TransportRegisterHiveData? transportRegisterDetails,
    TransportAfterRegisterHiveData? transportAfterRegisterDetails,
  }) =>
      TransportState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        transportStatusData: transportStatusData ?? this.transportStatusData,
        studentId: studentId ?? this.studentId,
        academicyearId: academicyearId ?? this.academicyearId,
        boardingpointId: boardingpointId ?? this.boardingpointId,
        busrouteId: busrouteId ?? this.busrouteId,
        controllerId: controllerId ?? this.controllerId,
        officeId: officeId ?? this.officeId,
        routeDetailsDataList: routeDetailsDataList ?? this.routeDetailsDataList,
        selectedRouteDetailsDataList:
            selectedRouteDetailsDataList ?? this.selectedRouteDetailsDataList,
        boardingPointDataList:
            boardingPointDataList ?? this.boardingPointDataList,
        selectedBoardingPointDataList:
            selectedBoardingPointDataList ?? this.selectedBoardingPointDataList,
        transportRegisterDetails:
            transportRegisterDetails ?? this.transportRegisterDetails,
        transportAfterRegisterDetails:
            transportAfterRegisterDetails ?? this.transportAfterRegisterDetails,
      );
}

class TransportInitial extends TransportState {
  TransportInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          transportStatusData: <TransportStatusHiveData>[],
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
          transportAfterRegisterDetails: TransportAfterRegisterHiveData.empty,
        );
}

class TransportStateLoading extends TransportState {
  const TransportStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.transportStatusData,
    required super.studentId,
    required super.academicyearId,
    required super.boardingpointId,
    required super.busrouteId,
    required super.controllerId,
    required super.officeId,
    required super.routeDetailsDataList,
    required super.selectedRouteDetailsDataList,
    required super.boardingPointDataList,
    required super.selectedBoardingPointDataList,
    required super.transportRegisterDetails,
    required super.transportAfterRegisterDetails,
  });
}

class TransportStateError extends TransportState {
  const TransportStateError({
    required super.successMessage,
    required super.errorMessage,
    required super.transportStatusData,
    required super.studentId,
    required super.academicyearId,
    required super.boardingpointId,
    required super.busrouteId,
    required super.controllerId,
    required super.officeId,
    required super.routeDetailsDataList,
    required super.selectedRouteDetailsDataList,
    required super.boardingPointDataList,
    required super.selectedBoardingPointDataList,
    required super.transportRegisterDetails,
    required super.transportAfterRegisterDetails,
  });
}

class TransportStateSuccessful extends TransportState {
  const TransportStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.transportStatusData,
    required super.studentId,
    required super.academicyearId,
    required super.boardingpointId,
    required super.busrouteId,
    required super.controllerId,
    required super.officeId,
    required super.routeDetailsDataList,
    required super.selectedRouteDetailsDataList,
    required super.boardingPointDataList,
    required super.selectedBoardingPointDataList,
    required super.transportRegisterDetails,
    required super.transportAfterRegisterDetails,
  });
}

class NoNetworkAvailableTransport extends TransportState {
  const NoNetworkAvailableTransport({
    required super.successMessage,
    required super.errorMessage,
    required super.transportStatusData,
    required super.studentId,
    required super.academicyearId,
    required super.boardingpointId,
    required super.busrouteId,
    required super.controllerId,
    required super.officeId,
    required super.routeDetailsDataList,
    required super.selectedRouteDetailsDataList,
    required super.boardingPointDataList,
    required super.selectedBoardingPointDataList,
    required super.transportRegisterDetails,
    required super.transportAfterRegisterDetails,
  });
}

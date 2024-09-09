import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/transport/model/route_model.dart';
import 'package:sample/home/main_pages/transport/model/transport_status.dart';
import 'package:sample/home/main_pages/transport/riverpod/transport_provider.dart';

final transportProvider =
    StateNotifierProvider<TrasportProvider, TransportState>((ref) {
  return TrasportProvider();
});

class TransportState {
  const TransportState({
    required this.successMessage,
    required this.errorMessage,
    required this.grievanceTransportStatusData,
    required this.studentId,
    required this.academicyearId,
    required this.boardingpointId,
    required this.busrouteId,
    required this.controllerId,
    required this.officeId,
    required this.routeDetailsDataList,
    required this.selectedRouteDetailsDataList,
  });

  final String successMessage;
  final String errorMessage;
  final List<TransportStatusData> grievanceTransportStatusData;
  final TextEditingController studentId;
  final TextEditingController academicyearId;
  final TextEditingController boardingpointId;
  final TextEditingController busrouteId;
  final TextEditingController controllerId;
  final TextEditingController officeId;

  final List<RouteDetailsData> routeDetailsDataList;
  final RouteDetailsData selectedRouteDetailsDataList;

  TransportState copyWith({
    String? successMessage,
    String? errorMessage,
    List<TransportStatusData>? grievanceTransportStatusData,
    TextEditingController? studentId,
    TextEditingController? academicyearId,
    TextEditingController? boardingpointId,
    TextEditingController? busrouteId,
    TextEditingController? controllerId,
    TextEditingController? officeId,
    List<RouteDetailsData>? routeDetailsDataList,
    RouteDetailsData? selectedRouteDetailsDataList,
  }) =>
      TransportState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        grievanceTransportStatusData:
            grievanceTransportStatusData ?? this.grievanceTransportStatusData,
        studentId: studentId ?? this.studentId,
        academicyearId: academicyearId ?? this.academicyearId,
        boardingpointId: boardingpointId ?? this.boardingpointId,
        busrouteId: busrouteId ?? this.busrouteId,
        controllerId: controllerId ?? this.controllerId,
        officeId: officeId ?? this.officeId,
        routeDetailsDataList: routeDetailsDataList ?? this.routeDetailsDataList,
        selectedRouteDetailsDataList:
            selectedRouteDetailsDataList ?? this.selectedRouteDetailsDataList,
      );
}

class TransportInitial extends TransportState {
  TransportInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          grievanceTransportStatusData: <TransportStatusData>[],
          studentId: TextEditingController(),
          academicyearId: TextEditingController(),
          boardingpointId: TextEditingController(),
          busrouteId: TextEditingController(),
          controllerId: TextEditingController(),
          officeId: TextEditingController(),
          routeDetailsDataList: <RouteDetailsData>[],
          selectedRouteDetailsDataList: RouteDetailsData.empty,
        );
}

class TransportStateLoading extends TransportState {
  const TransportStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.grievanceTransportStatusData,
    required super.studentId,
    required super.academicyearId,
    required super.boardingpointId,
    required super.busrouteId,
    required super.controllerId,
    required super.officeId,
    required super.routeDetailsDataList,
    required super.selectedRouteDetailsDataList,
  });
}

class TransportStateError extends TransportState {
  const TransportStateError({
    required super.successMessage,
    required super.errorMessage,
    required super.grievanceTransportStatusData,
    required super.studentId,
    required super.academicyearId,
    required super.boardingpointId,
    required super.busrouteId,
    required super.controllerId,
    required super.officeId,
    required super.routeDetailsDataList,
    required super.selectedRouteDetailsDataList,
  });
}

class TransportStateSuccessful extends TransportState {
  const TransportStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.grievanceTransportStatusData,
    required super.studentId,
    required super.academicyearId,
    required super.boardingpointId,
    required super.busrouteId,
    required super.controllerId,
    required super.officeId,
    required super.routeDetailsDataList,
    required super.selectedRouteDetailsDataList,
  });
}

class NoNetworkAvailableTransport extends TransportState {
  const NoNetworkAvailableTransport({
    required super.successMessage,
    required super.errorMessage,
    required super.grievanceTransportStatusData,
    required super.studentId,
    required super.academicyearId,
    required super.boardingpointId,
    required super.busrouteId,
    required super.controllerId,
    required super.officeId,
    required super.routeDetailsDataList,
    required super.selectedRouteDetailsDataList,
  });
}

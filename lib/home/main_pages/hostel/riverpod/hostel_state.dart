import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_details_model.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_after_register_model.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_before_register_model.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_model.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_leave_application_model.dart';
import 'package:sample/home/main_pages/hostel/model/room_type_model.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_provider.dart';

final hostelProvider =
    StateNotifierProvider<HostelProvider, HostelState>((ref) {
  return HostelProvider();
});

class HostelState {
  const HostelState({
    required this.successMessage,
    required this.errorMessage,
    required this.hostelData,
    required this.selectedHostelData,
    required this.roomTypeData,
    required this.selectedRoomTypeData,
    required this.hostelRegisterDetails,
    required this.hostelAfterRegisterDetails,
    required this.gethostelData,
    required this.fromDate,
    required this.toDate,
    required this.leaveReason,
    required this.hostelLeaveData,
  });

  final String successMessage;
  final String errorMessage;
  final List<HostelData> hostelData;
  final HostelData selectedHostelData;
  final List<RoomTypeData> roomTypeData;
  final RoomTypeData selectedRoomTypeData;
  final HostelRegisterData? hostelRegisterDetails;
  final HostelAfterRegisterData? hostelAfterRegisterDetails;
  final List<GetHostelData> gethostelData;
  final TextEditingController fromDate;
  final TextEditingController toDate;
  final TextEditingController leaveReason;
  final List<HostelLeaveData> hostelLeaveData;

  HostelState copyWith({
    String? successMessage,
    String? errorMessage,
    List<HostelData>? hostelData,
    HostelData? selectedHostelData,
    List<RoomTypeData>? roomTypeData,
    RoomTypeData? selectedRoomTypeData,
    HostelRegisterData? hostelRegisterDetails,
    HostelAfterRegisterData? hostelAfterRegisterDetails,
    List<GetHostelData>? gethostelData,
    TextEditingController? fromDate,
    TextEditingController? toDate,
    TextEditingController? leaveReason,
    List<HostelLeaveData>? hostelLeaveData,
  }) =>
      HostelState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        hostelData: hostelData ?? this.hostelData,
        selectedHostelData: selectedHostelData ?? this.selectedHostelData,
        roomTypeData: roomTypeData ?? this.roomTypeData,
        selectedRoomTypeData: selectedRoomTypeData ?? this.selectedRoomTypeData,
        hostelRegisterDetails:
            hostelRegisterDetails ?? this.hostelRegisterDetails,
        hostelAfterRegisterDetails:
            hostelAfterRegisterDetails ?? this.hostelAfterRegisterDetails,
        gethostelData: gethostelData ?? this.gethostelData,
        fromDate: fromDate ?? this.fromDate,
        toDate: toDate ?? this.toDate,
        leaveReason: leaveReason ?? this.leaveReason,
        hostelLeaveData: hostelLeaveData ?? this.hostelLeaveData,
      );
}

class HostelInitial extends HostelState {
  HostelInitial()
      : super(
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
}

class HostelStateLoading extends HostelState {
  const HostelStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.hostelData,
    required super.selectedHostelData,
    required super.roomTypeData,
    required super.selectedRoomTypeData,
    required super.hostelRegisterDetails,
    required super.hostelAfterRegisterDetails,
    required super.gethostelData,
    required super.fromDate,
    required super.toDate,
    required super.leaveReason,
    required super.hostelLeaveData,
  });
}

class HostelStateError extends HostelState {
  const HostelStateError({
    required super.successMessage,
    required super.errorMessage,
    required super.hostelData,
    required super.selectedHostelData,
    required super.roomTypeData,
    required super.selectedRoomTypeData,
    required super.hostelRegisterDetails,
    required super.hostelAfterRegisterDetails,
    required super.gethostelData,
    required super.fromDate,
    required super.toDate,
    required super.leaveReason,
    required super.hostelLeaveData,
  });
}

class HostelStateSuccessful extends HostelState {
  const HostelStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.hostelData,
    required super.selectedHostelData,
    required super.roomTypeData,
    required super.selectedRoomTypeData,
    required super.hostelRegisterDetails,
    required super.hostelAfterRegisterDetails,
    required super.gethostelData,
    required super.fromDate,
    required super.toDate,
    required super.leaveReason,
    required super.hostelLeaveData,
  });
}

class NoNetworkAvailableHostel extends HostelState {
  const NoNetworkAvailableHostel({
    required super.successMessage,
    required super.errorMessage,
    required super.hostelData,
    required super.selectedHostelData,
    required super.roomTypeData,
    required super.selectedRoomTypeData,
    required super.hostelRegisterDetails,
    required super.hostelAfterRegisterDetails,
    required super.gethostelData,
    required super.fromDate,
    required super.toDate,
    required super.leaveReason,
    required super.hostelLeaveData,
  });
}

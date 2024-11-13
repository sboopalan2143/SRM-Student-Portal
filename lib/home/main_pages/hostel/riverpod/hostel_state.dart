import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_after_register_hive_model.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_before_register_hive_model.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_details_hive_model.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_hive_model.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_leave_application_hive_model.dart';
import 'package:sample/home/main_pages/hostel/model/room_type_hive_model.dart';
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
  final List<HostelHiveData> hostelData;
  final HostelHiveData selectedHostelData;
  final List<RoomTypeHiveData> roomTypeData;
  final RoomTypeHiveData selectedRoomTypeData;
  final HostelBeforeRegisterHiveData? hostelRegisterDetails;
  final HostelAfterRegisterHiveData? hostelAfterRegisterDetails;
  final List<GetHostelHiveData> gethostelData;
  final TextEditingController fromDate;
  final TextEditingController toDate;
  final TextEditingController leaveReason;
  final List<HostelLeaveHiveData> hostelLeaveData;

  HostelState copyWith({
    String? successMessage,
    String? errorMessage,
    List<HostelHiveData>? hostelData,
    HostelHiveData? selectedHostelData,
    List<RoomTypeHiveData>? roomTypeData,
    RoomTypeHiveData? selectedRoomTypeData,
    HostelBeforeRegisterHiveData? hostelRegisterDetails,
    HostelAfterRegisterHiveData? hostelAfterRegisterDetails,
    List<GetHostelHiveData>? gethostelData,
    TextEditingController? fromDate,
    TextEditingController? toDate,
    TextEditingController? leaveReason,
    List<HostelLeaveHiveData>? hostelLeaveData,
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
          hostelData: <HostelHiveData>[],
          selectedHostelData: HostelHiveData.empty,
          roomTypeData: <RoomTypeHiveData>[],
          selectedRoomTypeData: RoomTypeHiveData.empty,
          hostelRegisterDetails: HostelBeforeRegisterHiveData.empty,
          hostelAfterRegisterDetails: HostelAfterRegisterHiveData.empty,
          gethostelData: <GetHostelHiveData>[],
          fromDate: TextEditingController(),
          toDate: TextEditingController(),
          leaveReason: TextEditingController(),
          hostelLeaveData: <HostelLeaveHiveData>[],
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

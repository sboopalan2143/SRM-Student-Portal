import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_model.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_register_model.dart';
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
  });

  final String successMessage;
  final String errorMessage;
  final List<HostelData> hostelData;
  final HostelData selectedHostelData;
  final List<RoomTypeData> roomTypeData;
  final RoomTypeData selectedRoomTypeData;
  final HostelRegisterData? hostelRegisterDetails;

  HostelState copyWith({
    String? successMessage,
    String? errorMessage,
    List<HostelData>? hostelData,
    HostelData? selectedHostelData,
    List<RoomTypeData>? roomTypeData,
    RoomTypeData? selectedRoomTypeData,
    HostelRegisterData? hostelRegisterDetails,
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
  });
}

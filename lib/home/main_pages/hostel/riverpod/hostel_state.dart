import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_provider.dart';

final hostelProvider =
    StateNotifierProvider<HostelProvider, HostelState>((ref) {
  return HostelProvider();
});

class HostelState {
  const HostelState({
    required this.successMessage,
    required this.errorMessage,
    required this.hospitalData,
    required this.academicYearId,
    required this.roomTypeId,
    required this.hostelId,
    required this.controllerId,
    required this.officeId,
  });

  final String successMessage;
  final String errorMessage;
  final List<dynamic> hospitalData;
  final TextEditingController academicYearId;
  final TextEditingController roomTypeId;
  final TextEditingController hostelId;
  final TextEditingController controllerId;
  final TextEditingController officeId;

  HostelState copyWith({
    String? successMessage,
    String? errorMessage,
    List<dynamic>? hospitalData,
    TextEditingController? academicYearId,
    TextEditingController? roomTypeId,
    TextEditingController? hostelId,
    TextEditingController? controllerId,
    TextEditingController? officeId,
  }) =>
      HostelState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        hospitalData: hospitalData ?? this.hospitalData,
        academicYearId: academicYearId ?? this.academicYearId,
        roomTypeId: roomTypeId ?? this.roomTypeId,
        hostelId: hostelId ?? this.hostelId,
        controllerId: controllerId ?? this.controllerId,
        officeId: officeId ?? this.officeId,
      );
}

class HostelInitial extends HostelState {
  HostelInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          hospitalData: <dynamic>[],
          academicYearId: TextEditingController(),
          roomTypeId: TextEditingController(),
          hostelId: TextEditingController(),
          controllerId: TextEditingController(),
          officeId: TextEditingController(),
        );
}

class HostelStateLoading extends HostelState {
  const HostelStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.hospitalData,
    required super.academicYearId,
    required super.roomTypeId,
    required super.hostelId,
    required super.controllerId,
    required super.officeId,
  });
}

class HostelStateError extends HostelState {
  const HostelStateError({
    required super.successMessage,
    required super.errorMessage,
    required super.hospitalData,
    required super.academicYearId,
    required super.roomTypeId,
    required super.hostelId,
    required super.controllerId,
    required super.officeId,
  });
}

class HostelStateSuccessful extends HostelState {
  const HostelStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.hospitalData,
    required super.academicYearId,
    required super.roomTypeId,
    required super.hostelId,
    required super.controllerId,
    required super.officeId,
  });
}

class NoNetworkAvailableHostel extends HostelState {
  const NoNetworkAvailableHostel({
    required super.successMessage,
    required super.errorMessage,
    required super.hospitalData,
    required super.academicYearId,
    required super.roomTypeId,
    required super.hostelId,
    required super.controllerId,
    required super.officeId,
  });
}

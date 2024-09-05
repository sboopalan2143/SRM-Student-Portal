import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_category_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_subtype_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_type_model.dart';
import 'package:sample/home/main_pages/grievances/riverpod/grievance_provider.dart';

final grievanceProvider =
    StateNotifierProvider<GrievanceProvider, GrievanceState>((ref) {
  return GrievanceProvider();
});

class GrievanceState {
  const GrievanceState({
    required this.successMessage,
    required this.errorMessage,
    required this.grievanceCaregoryData,
    required this.grievanceSubType,
    required this.grievanceType,
  });

  final String successMessage;
  final String errorMessage;
  final List<GrievanceCategoryData> grievanceCaregoryData;
  final List<GrievanceSubTypeData> grievanceSubType;
  final List<GrievanceData> grievanceType;

  GrievanceState copyWith({
    String? successMessage,
    String? errorMessage,
    List<GrievanceCategoryData>? grievanceCaregoryData,
    List<GrievanceSubTypeData>? grievanceSubType,
    List<GrievanceData>? grievanceType,
  }) =>
      GrievanceState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        grievanceCaregoryData:
            grievanceCaregoryData ?? this.grievanceCaregoryData,
        grievanceSubType: grievanceSubType ?? this.grievanceSubType,
        grievanceType: grievanceType ?? this.grievanceType,
      );
}

class GrievanceInitial extends GrievanceState {
  GrievanceInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          grievanceCaregoryData: <GrievanceCategoryData>[],
          grievanceSubType: <GrievanceSubTypeData>[],
          grievanceType: <GrievanceData>[],
        );
}

class GrievanceStateLoading extends GrievanceState {
  const GrievanceStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.grievanceCaregoryData,
    required super.grievanceSubType,
    required super.grievanceType,
  });
}

class GrievanceStateError extends GrievanceState {
  const GrievanceStateError({
    required super.successMessage,
    required super.errorMessage,
    required super.grievanceCaregoryData,
    required super.grievanceSubType,
    required super.grievanceType,
  });
}

class GrievanceStateSuccessful extends GrievanceState {
  const GrievanceStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.grievanceCaregoryData,
    required super.grievanceSubType,
    required super.grievanceType,
  });
}

class NoNetworkAvailableGrievance extends GrievanceState {
  const NoNetworkAvailableGrievance({
    required super.successMessage,
    required super.errorMessage,
    required super.grievanceCaregoryData,
    required super.grievanceSubType,
    required super.grievanceType,
  });
}

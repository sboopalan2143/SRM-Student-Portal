import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_category_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_subtype_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_type_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/studentwise_grievance_hive_model.dart';
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
    required this.selectedgrievanceCaregoryDataList,
    required this.grievanceSubType,
    required this.selectedgrievanceSubTypeDataList,
    required this.grievanceType,
    required this.selectedgrievanceTypeDataList,
    required this.studentId,
    required this.studentname,
    required this.subject,
    required this.description,
    required this.studentwisegrievanceData,
  });

  final String successMessage;
  final String errorMessage;
  final List<GrievanceCategoryHiveData> grievanceCaregoryData;
  final GrievanceCategoryHiveData selectedgrievanceCaregoryDataList;
  final List<GrievanceSubTypeHiveData> grievanceSubType;
  final GrievanceSubTypeHiveData selectedgrievanceSubTypeDataList;
  final List<GrievanceTypeHiveData> grievanceType;
  final GrievanceTypeHiveData selectedgrievanceTypeDataList;

  final TextEditingController studentId;
  final TextEditingController studentname;
  final TextEditingController subject;
  final TextEditingController description;
  final List<StudentWiseHiveData> studentwisegrievanceData;

  GrievanceState copyWith({
    String? successMessage,
    String? errorMessage,
    List<GrievanceCategoryHiveData>? grievanceCaregoryData,
    GrievanceCategoryHiveData? selectedgrievanceCaregoryDataList,
    List<GrievanceSubTypeHiveData>? grievanceSubType,
    GrievanceSubTypeHiveData? selectedgrievanceSubTypeDataList,
    List<GrievanceTypeHiveData>? grievanceType,
    GrievanceTypeHiveData? selectedgrievanceTypeDataList,
    TextEditingController? studentId,
    TextEditingController? studentname,
    TextEditingController? subject,
    TextEditingController? description,
    List<StudentWiseHiveData>? studentwisegrievanceData,
  }) =>
      GrievanceState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        grievanceCaregoryData:
            grievanceCaregoryData ?? this.grievanceCaregoryData,
        selectedgrievanceCaregoryDataList: selectedgrievanceCaregoryDataList ??
            this.selectedgrievanceCaregoryDataList,
        grievanceSubType: grievanceSubType ?? this.grievanceSubType,
        grievanceType: grievanceType ?? this.grievanceType,
        selectedgrievanceSubTypeDataList: selectedgrievanceSubTypeDataList ??
            this.selectedgrievanceSubTypeDataList,
        selectedgrievanceTypeDataList:
            selectedgrievanceTypeDataList ?? this.selectedgrievanceTypeDataList,
        studentId: studentId ?? this.studentId,
        studentname: studentname ?? this.studentname,
        subject: subject ?? this.subject,
        description: description ?? this.description,
        studentwisegrievanceData:
            studentwisegrievanceData ?? this.studentwisegrievanceData,
      );
}

class GrievanceInitial extends GrievanceState {
  GrievanceInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          grievanceCaregoryData: <GrievanceCategoryHiveData>[],
          selectedgrievanceCaregoryDataList: GrievanceCategoryHiveData.empty,
          grievanceSubType: <GrievanceSubTypeHiveData>[],
          selectedgrievanceSubTypeDataList: GrievanceSubTypeHiveData.empty,
          grievanceType: <GrievanceTypeHiveData>[],
          selectedgrievanceTypeDataList: GrievanceTypeHiveData.empty,
          studentId: TextEditingController(),
          studentname: TextEditingController(),
          subject: TextEditingController(),
          description: TextEditingController(),
          studentwisegrievanceData: <StudentWiseHiveData>[],
        );
}

class GrievanceStateLoading extends GrievanceState {
  const GrievanceStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.grievanceCaregoryData,
    required super.selectedgrievanceCaregoryDataList,
    required super.grievanceSubType,
    required super.selectedgrievanceSubTypeDataList,
    required super.grievanceType,
    required super.selectedgrievanceTypeDataList,
    required super.studentId,
    required super.studentname,
    required super.subject,
    required super.description,
    required super.studentwisegrievanceData,
  });
}

class GrievanceStateError extends GrievanceState {
  const GrievanceStateError({
    required super.successMessage,
    required super.errorMessage,
    required super.grievanceCaregoryData,
    required super.selectedgrievanceCaregoryDataList,
    required super.grievanceSubType,
    required super.selectedgrievanceSubTypeDataList,
    required super.grievanceType,
    required super.selectedgrievanceTypeDataList,
    required super.studentId,
    required super.studentname,
    required super.subject,
    required super.description,
    required super.studentwisegrievanceData,
  });
}

class GrievanceStateSuccessful extends GrievanceState {
  const GrievanceStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.grievanceCaregoryData,
    required super.selectedgrievanceCaregoryDataList,
    required super.grievanceSubType,
    required super.selectedgrievanceSubTypeDataList,
    required super.grievanceType,
    required super.selectedgrievanceTypeDataList,
    required super.studentId,
    required super.studentname,
    required super.subject,
    required super.description,
    required super.studentwisegrievanceData,
  });
}

class NoNetworkAvailableGrievance extends GrievanceState {
  const NoNetworkAvailableGrievance({
    required super.successMessage,
    required super.errorMessage,
    required super.grievanceCaregoryData,
    required super.selectedgrievanceCaregoryDataList,
    required super.grievanceSubType,
    required super.selectedgrievanceSubTypeDataList,
    required super.grievanceType,
    required super.selectedgrievanceTypeDataList,
    required super.studentId,
    required super.studentname,
    required super.subject,
    required super.description,
    required super.studentwisegrievanceData,
  });
}

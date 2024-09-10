import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_category_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_subtype_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_type_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/studetwise_grievance_model.dart';
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
  final List<GrievanceCategoryData> grievanceCaregoryData;
  final GrievanceCategoryData selectedgrievanceCaregoryDataList;
  final List<GrievanceSubTypeData> grievanceSubType;
  final GrievanceSubTypeData selectedgrievanceSubTypeDataList;
  final List<GrievanceData> grievanceType;
  final GrievanceData selectedgrievanceTypeDataList;

  final TextEditingController studentId;
  final TextEditingController studentname;
  final TextEditingController subject;
  final TextEditingController description;
  final List<StudentWiseData> studentwisegrievanceData;

  GrievanceState copyWith({
    String? successMessage,
    String? errorMessage,
    List<GrievanceCategoryData>? grievanceCaregoryData,
    GrievanceCategoryData? selectedgrievanceCaregoryDataList,
    List<GrievanceSubTypeData>? grievanceSubType,
    GrievanceSubTypeData? selectedgrievanceSubTypeDataList,
    List<GrievanceData>? grievanceType,
    GrievanceData? selectedgrievanceTypeDataList,
    TextEditingController? studentId,
    TextEditingController? studentname,
    TextEditingController? subject,
    TextEditingController? description,
    List<StudentWiseData>? studentwisegrievanceData,
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
          grievanceCaregoryData: <GrievanceCategoryData>[],
          selectedgrievanceCaregoryDataList: GrievanceCategoryData.empty,
          grievanceSubType: <GrievanceSubTypeData>[],
          selectedgrievanceSubTypeDataList: GrievanceSubTypeData.empty,
          grievanceType: <GrievanceData>[],
          selectedgrievanceTypeDataList: GrievanceData.empty,
          studentId: TextEditingController(),
          studentname: TextEditingController(),
          subject: TextEditingController(),
          description: TextEditingController(),
          studentwisegrievanceData: <StudentWiseData>[],
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

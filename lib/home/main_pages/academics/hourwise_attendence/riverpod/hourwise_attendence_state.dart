import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/academics/hourwise_attendence/hourwise_model.dart/hourwise_hive_model.dart';
import 'package:sample/home/main_pages/academics/hourwise_attendence/hourwise_model.dart/hourwise_model.dart';
import 'package:sample/home/main_pages/academics/hourwise_attendence/riverpod/hourwise_attendence_provider.dart';

final hourwiseProvider =
    StateNotifierProvider<HourwiseProvider, HourwiseState>((ref) {
  return HourwiseProvider();
});

class HourwiseState {
  const HourwiseState({
    required this.successMessage,
    required this.errorMessage,
    required this.hourwiseData,
    required this.listHourWiseData,
    required this.listHourWiseHiveData,
  });

  final String successMessage;
  final String errorMessage;
  final HourwiseData hourwiseData;
  final List<HourwiseData> listHourWiseData;
  final List<HourwiseHiveData> listHourWiseHiveData;

  HourwiseState copyWith({
    String? successMessage,
    String? errorMessage,
    HourwiseData? hourwiseData,
    List<HourwiseData>? listHourWiseData,
    List<HourwiseHiveData>? listHourWiseHiveData,
  }) =>
      HourwiseState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        hourwiseData: hourwiseData ?? this.hourwiseData,
        listHourWiseData: listHourWiseData ?? this.listHourWiseData,
        listHourWiseHiveData: listHourWiseHiveData ?? this.listHourWiseHiveData,
      );
}

class HourwiseInitial extends HourwiseState {
  HourwiseInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          hourwiseData: HourwiseData.empty,
          listHourWiseData: <HourwiseData>[],
          listHourWiseHiveData: <HourwiseHiveData>[],
        );
}

class HourwiseStateLoading extends HourwiseState {
  const HourwiseStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.hourwiseData,
    required super.listHourWiseData,
    required super.listHourWiseHiveData,
  });
}

class HourwiseSuccessFull extends HourwiseState {
  const HourwiseSuccessFull({
    required super.successMessage,
    required super.errorMessage,
    required super.hourwiseData,
    required super.listHourWiseData,
    required super.listHourWiseHiveData,
  });
}

class HourwiseError extends HourwiseState {
  const HourwiseError({
    required super.successMessage,
    required super.errorMessage,
    required super.hourwiseData,
    required super.listHourWiseData,
    required super.listHourWiseHiveData,
  });
}

class HourwiseStateSuccessful extends HourwiseState {
  const HourwiseStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.hourwiseData,
    required super.listHourWiseData,
    required super.listHourWiseHiveData,
  });
}

class NoNetworkAvailablehourwise extends HourwiseState {
  const NoNetworkAvailablehourwise({
    required super.successMessage,
    required super.errorMessage,
    required super.hourwiseData,
    required super.listHourWiseData,
    required super.listHourWiseHiveData,
  });
}

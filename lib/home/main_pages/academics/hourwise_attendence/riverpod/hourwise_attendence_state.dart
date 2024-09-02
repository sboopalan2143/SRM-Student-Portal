import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  });

  final String successMessage;
  final String errorMessage;
  final HourwiseData hourwiseData;
  final List<HourwiseData> listHourWiseData;

  HourwiseState copyWith({
    String? successMessage,
    String? errorMessage,
    HourwiseData? hourwiseData,
    List<HourwiseData>? listHourWiseData,
  }) =>
      HourwiseState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        hourwiseData: hourwiseData ?? this.hourwiseData,
        listHourWiseData: listHourWiseData?? this.listHourWiseData,
      );
}

class HourwiseInitial extends HourwiseState {
  HourwiseInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          hourwiseData: HourwiseData.empty,
          listHourWiseData: <HourwiseData>[],
        );
}

class HourwiseStateLoading extends HourwiseState {
  const HourwiseStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.hourwiseData,
    required super.listHourWiseData,
  });
}

class HourwiseSuccessFull extends HourwiseState {
  const HourwiseSuccessFull({
    required super.successMessage,
    required super.errorMessage,
    required super.hourwiseData,
    required super.listHourWiseData,
  });
}

class HourwiseError extends HourwiseState {
  const HourwiseError({
    required super.successMessage,
    required super.errorMessage,
    required super.hourwiseData,
    required super.listHourWiseData,
  });
}

class HourwiseStateSuccessful extends HourwiseState {
  const HourwiseStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.hourwiseData,
    required super.listHourWiseData,
  });
}

class NoNetworkAvailablehourwise extends HourwiseState {
  const NoNetworkAvailablehourwise({
    required super.successMessage,
    required super.errorMessage,
    required super.hourwiseData,
    required super.listHourWiseData,
  });
}

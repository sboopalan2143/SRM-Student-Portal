import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/academics/hourwise_attendence/hourwise_model.dart/hourwise_model.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_provider.dart';
import 'package:sample/home/main_pages/academics/hourwise_attendence/riverpod/hourwise_attendence_provider.dart';

final hourwiseProvider =
    StateNotifierProvider<HourwiseProvider, hourwiseState>((ref) {
  return HourwiseProvider();
});

class hourwiseState {
  const hourwiseState({
    required this.successMessage,
    required this.errorMessage,
    required this.hourwiseData,
    required this.listHourWiseData,
  });

  final String successMessage;
  final String errorMessage;
  final HourwiseData hourwiseData;
  final List<HourwiseData> listHourWiseData;

  hourwiseState copyWith({
    String? successMessage,
    String? errorMessage,
    HourwiseData? hourwiseData,
    List<HourwiseData>? listHourWiseData,
  }) =>
      hourwiseState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        hourwiseData: hourwiseData ?? this.hourwiseData,
        listHourWiseData: listHourWiseData?? this.listHourWiseData,
      );
}

class hourwiseInitial extends hourwiseState {
  hourwiseInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          hourwiseData: HourwiseData.empty,
          listHourWiseData: <HourwiseData>[],
        );
}

class hourwiseStateLoading extends hourwiseState {
  const hourwiseStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.hourwiseData,
    required super.listHourWiseData,
  });
}

class hourwiseSuccessFull extends hourwiseState {
  const hourwiseSuccessFull({
    required super.successMessage,
    required super.errorMessage,
    required super.hourwiseData,
    required super.listHourWiseData,
  });
}

class hourwiseError extends hourwiseState {
  const hourwiseError({
    required super.successMessage,
    required super.errorMessage,
    required super.hourwiseData,
    required super.listHourWiseData,
  });
}

class hourwiseStateSuccessful extends hourwiseState {
  const hourwiseStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.hourwiseData,
    required super.listHourWiseData,
  });
}

class NoNetworkAvailablehourwise extends hourwiseState {
  const NoNetworkAvailablehourwise({
    required super.successMessage,
    required super.errorMessage,
    required super.hourwiseData,
    required super.listHourWiseData,
  });
}

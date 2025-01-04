import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/cgpa/model/cgpa_model.dart';
import 'package:sample/home/main_pages/cgpa/riverpod/cgpa_provider.dart';

final cgpaProvider = StateNotifierProvider<CgpaProvider, CgpaState>((ref) {
  return CgpaProvider();
});

class CgpaState {
  const CgpaState({
    required this.successMessage,
    required this.errorMessage,
    required this.cgpaData,
  });

  final String successMessage;
  final String errorMessage;
  final List<CGPAData> cgpaData;

  CgpaState copyWith({
    String? successMessage,
    String? errorMessage,
    String? navNotificationString,
    List<CGPAData>? cgpaData,
  }) =>
      CgpaState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        cgpaData: cgpaData ?? this.cgpaData,
      );
}

class CgpaInitial extends CgpaState {
  CgpaInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          cgpaData: <CGPAData>[],
        );
}

class CgpaLoading extends CgpaState {
  const CgpaLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.cgpaData,
  });
}

class CgpaSuccessFull extends CgpaState {
  const CgpaSuccessFull({
    required super.successMessage,
    required super.errorMessage,
    required super.cgpaData,
  });
}

class CgpaError extends CgpaState {
  const CgpaError({
    required super.successMessage,
    required super.errorMessage,
    required super.cgpaData,
  });
}

class NoNetworkAvailableCgpa extends CgpaState {
  const NoNetworkAvailableCgpa({
    required super.successMessage,
    required super.errorMessage,
    required super.cgpaData,
  });
}

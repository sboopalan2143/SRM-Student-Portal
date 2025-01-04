import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/sgpa/model/sgpa_model.dart';
import 'package:sample/home/main_pages/sgpa/riverpod/sgpa_provider.dart';

final sgpaProvider = StateNotifierProvider<SgpaProvider, SgpaState>((ref) {
  return SgpaProvider();
});

class SgpaState {
  const SgpaState({
    required this.successMessage,
    required this.errorMessage,
    required this.sgpaData,
  });

  final String successMessage;
  final String errorMessage;
  final List<SGPAData> sgpaData;

  SgpaState copyWith({
    String? successMessage,
    String? errorMessage,
    String? navNotificationString,
    List<SGPAData>? sgpaData,
  }) =>
      SgpaState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        sgpaData: sgpaData ?? this.sgpaData,
      );
}

class SgpaInitial extends SgpaState {
  SgpaInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          sgpaData: <SGPAData>[],
        );
}

class SgpaLoading extends SgpaState {
  const SgpaLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.sgpaData,
  });
}

class SgpaSuccessFull extends SgpaState {
  const SgpaSuccessFull({
    required super.successMessage,
    required super.errorMessage,
    required super.sgpaData,
  });
}

class SgpaError extends SgpaState {
  const SgpaError({
    required super.successMessage,
    required super.errorMessage,
    required super.sgpaData,
  });
}

class NoNetworkAvailableSgpa extends SgpaState {
  const NoNetworkAvailableSgpa({
    required super.successMessage,
    required super.errorMessage,
    required super.sgpaData,
  });
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/cgpa/model/cgpa_model.dart';
import 'package:sample/home/main_pages/cgpa/riverpod/cgpa_provider.dart';
import 'package:sample/home/main_pages/fees_due_home_page.dart/model/fees_due_home_page_model.dart';
import 'package:sample/home/main_pages/fees_due_home_page.dart/riverpod/fees_dhasboard_Page_provider.dart';

final feesDhasboardProvider =
    StateNotifierProvider<FeesDhasboardProvider, FeesDhasboardState>((ref) {
  return FeesDhasboardProvider();
});

class FeesDhasboardState {
  const FeesDhasboardState({
    required this.successMessage,
    required this.errorMessage,
    required this.feesDueDhasboardData,
  });

  final String successMessage;
  final String errorMessage;
  final List<FeesDueHomePageData> feesDueDhasboardData;

  FeesDhasboardState copyWith({
    String? successMessage,
    String? errorMessage,
    String? navNotificationString,
    List<FeesDueHomePageData>? feesDueDhasboardData,
  }) =>
      FeesDhasboardState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        feesDueDhasboardData: feesDueDhasboardData ?? this.feesDueDhasboardData,
      );
}

class FeesDhasboardInitial extends FeesDhasboardState {
  FeesDhasboardInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          feesDueDhasboardData: <FeesDueHomePageData>[],
        );
}

class FeesDhasboardLoading extends FeesDhasboardState {
  const FeesDhasboardLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.feesDueDhasboardData,
  });
}

class FeesDhasboardSuccessFull extends FeesDhasboardState {
  const FeesDhasboardSuccessFull({
    required super.successMessage,
    required super.errorMessage,
    required super.feesDueDhasboardData,
  });
}

class FeesDhasboardError extends FeesDhasboardState {
  const FeesDhasboardError({
    required super.successMessage,
    required super.errorMessage,
    required super.feesDueDhasboardData,
  });
}

class NoNetworkAvailableFeesDhasboard extends FeesDhasboardState {
  const NoNetworkAvailableFeesDhasboard({
    required super.successMessage,
    required super.errorMessage,
    required super.feesDueDhasboardData,
  });
}

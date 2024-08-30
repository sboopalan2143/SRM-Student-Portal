import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/fees/model.dart/finance_response_model.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_provider.dart';

final feesProvider = StateNotifierProvider<FeesProvider, FeesState>((ref) {
  return FeesProvider();
});

class FeesState {
  const FeesState({
    required this.successMessage,
    required this.errorMessage,
    required this.navFeesString,
    required this.financeData,
  });

  final String successMessage;
  final String errorMessage;
  final String navFeesString;
  final List<FinanceData> financeData;

  FeesState copyWith({
    String? successMessage,
    String? errorMessage,
    String? navFeesString,
    List<FinanceData>? financeData,
  }) =>
      FeesState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        navFeesString: navFeesString ?? this.navFeesString,
        financeData: financeData ?? this.financeData,
      );
}

class FeesInitial extends FeesState {
  FeesInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          navFeesString: 'Online Trans',
          financeData: <FinanceData>[],
        );
}

class FeesStateLoading extends FeesState {
  const FeesStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.navFeesString,
    required super.financeData,
  });
}

class FeesSuccessFull extends FeesState {
  const FeesSuccessFull({
    required super.successMessage,
    required super.errorMessage,
    required super.navFeesString,
    required super.financeData,
  });
}

class FeesError extends FeesState {
  const FeesError({
    required super.successMessage,
    required super.errorMessage,
    required super.navFeesString,
    required super.financeData,
  });
}

class FeesStateSuccessful extends FeesState {
  const FeesStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.navFeesString,
    required super.financeData,
  });
}

class NoNetworkAvailableFees extends FeesState {
  const NoNetworkAvailableFees({
    required super.successMessage,
    required super.errorMessage,
    required super.navFeesString,
    required super.financeData,
  });
}

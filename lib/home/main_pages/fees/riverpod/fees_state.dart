import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/fees/model.dart/feespaidmodel.dart';
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
    required this.feespaidData,
  });

  final String successMessage;
  final String errorMessage;
  final String navFeesString;
  final List<FinanceData> financeData;
  final List<FeesPaidData> feespaidData;

  FeesState copyWith({
    String? successMessage,
    String? errorMessage,
    String? navFeesString,
    List<FinanceData>? financeData,
    List<FeesPaidData>? feespaidData,
  }) =>
      FeesState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        navFeesString: navFeesString ?? this.navFeesString,
        financeData: financeData ?? this.financeData,
        feespaidData: feespaidData ?? this.feespaidData,
      );
}

class FeesInitial extends FeesState {
  FeesInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          navFeesString: 'Online Trans',
          financeData: <FinanceData>[],
          feespaidData: <FeesPaidData>[],
        );
}

class FeesStateLoading extends FeesState {
  const FeesStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.navFeesString,
    required super.financeData,
    required super.feespaidData,
  });
}

class FeesSuccessFull extends FeesState {
  const FeesSuccessFull({
    required super.successMessage,
    required super.errorMessage,
    required super.navFeesString,
    required super.financeData,
    required super.feespaidData,
  });
}

class FeesError extends FeesState {
  const FeesError({
    required super.successMessage,
    required super.errorMessage,
    required super.navFeesString,
    required super.financeData,
    required super.feespaidData,
  });
}

class FeesStateSuccessful extends FeesState {
  const FeesStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.navFeesString,
    required super.financeData,
    required super.feespaidData,
  });
}

class NoNetworkAvailableFees extends FeesState {
  const NoNetworkAvailableFees({
    required super.successMessage,
    required super.errorMessage,
    required super.navFeesString,
    required super.financeData,
    required super.feespaidData,
  });
}

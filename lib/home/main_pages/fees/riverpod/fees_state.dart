import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/fees/model.dart/finance_response_hive_model.dart';
import 'package:sample/home/main_pages/fees/model.dart/get_fees_details_hive_model.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_provider.dart';

final feesProvider = StateNotifierProvider<FeesProvider, FeesState>((ref) {
  return FeesProvider();
});

class FeesState {
  const FeesState({
    required this.successMessage,
    required this.errorMessage,
    required this.navFeesString,
    required this.financeHiveData,
    required this.feesDetailsHiveData,
  });

  final String successMessage;
  final String errorMessage;
  final String navFeesString;

  final List<FinanceHiveData> financeHiveData;
  final List<GetFeesHiveData> feesDetailsHiveData;

  FeesState copyWith({
    String? successMessage,
    String? errorMessage,
    String? navFeesString,
    List<FinanceHiveData>? financeHiveData,
    List<GetFeesHiveData>? feesDetailsHiveData,
  }) =>
      FeesState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        navFeesString: navFeesString ?? this.navFeesString,
        financeHiveData: financeHiveData ?? this.financeHiveData,
        feesDetailsHiveData: feesDetailsHiveData ?? this.feesDetailsHiveData,
      );
}

class FeesInitial extends FeesState {
  FeesInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          navFeesString: 'Online Trans',
          financeHiveData: <FinanceHiveData>[],
          feesDetailsHiveData: <GetFeesHiveData>[],
        );
}

class FeesStateLoading extends FeesState {
  const FeesStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.navFeesString,
    required super.financeHiveData,
    required super.feesDetailsHiveData,
  });
}

class FeesSuccessFull extends FeesState {
  const FeesSuccessFull({
    required super.successMessage,
    required super.errorMessage,
    required super.navFeesString,
    required super.financeHiveData,
    required super.feesDetailsHiveData,
  });
}

class FeesError extends FeesState {
  const FeesError({
    required super.successMessage,
    required super.errorMessage,
    required super.navFeesString,
    required super.financeHiveData,
    required super.feesDetailsHiveData,
  });
}

class FeesStateSuccessful extends FeesState {
  const FeesStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.navFeesString,
    required super.financeHiveData,
    required super.feesDetailsHiveData,
  });
}

class NoNetworkAvailableFees extends FeesState {
  const NoNetworkAvailableFees({
    required super.successMessage,
    required super.errorMessage,
    required super.navFeesString,
    required super.financeHiveData,
    required super.feesDetailsHiveData,
  });
}

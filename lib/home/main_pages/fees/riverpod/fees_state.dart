import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_provider.dart';

final feesProvider = StateNotifierProvider<FeesProvider, FeesState>((ref) {
  return FeesProvider();
});

class FeesState {
  const FeesState({
    required this.successMessage,
    required this.errorMessage,
    required this.navFeesString,
  });

  final String successMessage;
  final String errorMessage;
  final String navFeesString;

  FeesState copyWith({
    String? successMessage,
    String? errorMessage,
    String? navFeesString,
  }) =>
      FeesState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        navFeesString: navFeesString ?? this.navFeesString,
      );
}

class FeesInitial extends FeesState {
  FeesInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          navFeesString: 'Paid Details',
        );
}

class FeesStateLoading extends FeesState {
  const FeesStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.navFeesString,
  });
}

class FeesSuccessFull extends FeesState {
  const FeesSuccessFull({
    required super.successMessage,
    required super.errorMessage,
    required super.navFeesString,
  });
}

class FeesError extends FeesState {
  const FeesError({
    required super.successMessage,
    required super.errorMessage,
    required super.navFeesString,
  });
}

class FeesStateSuccessful extends FeesState {
  const FeesStateSuccessful({
    required super.successMessage,
    required super.errorMessage, required super.navFeesString,
  });
}

class NoNetworkAvailableFees extends FeesState {
  const NoNetworkAvailableFees({
    required super.successMessage,
    required super.errorMessage,
    required super.navFeesString,
  });
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_provider.dart';

final hostelProvider =
    StateNotifierProvider<HostelProvider, HostelState>((ref) {
  return HostelProvider();
});

class HostelState {
  const HostelState({
    required this.successMessage,
    required this.errorMessage,
  });

  final String successMessage;
  final String errorMessage;

  HostelState copyWith({
    String? successMessage,
    String? errorMessage,
  }) =>
      HostelState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}

class HostelInitial extends HostelState {
  HostelInitial()
      : super(
          successMessage: '',
          errorMessage: '',
        );
}

class HostelStateLoading extends HostelState {
  const HostelStateLoading({
    required super.successMessage,
    required super.errorMessage,
  });
}

class HostelStateError extends HostelState {
  const HostelStateError({
    required super.successMessage,
    required super.errorMessage,
  });
}

class HostelStateSuccessful extends HostelState {
  const HostelStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
  });
}

class NoNetworkAvailableHostel extends HostelState {
  const NoNetworkAvailableHostel({
    required super.successMessage,
    required super.errorMessage,
  });
}

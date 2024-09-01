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
    required this.hospitalData,
  });

  final String successMessage;
  final String errorMessage;
  final List<dynamic> hospitalData;

  HostelState copyWith({
    String? successMessage,
    String? errorMessage,
    List<dynamic>? hospitalData,
  }) =>
      HostelState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        hospitalData: hospitalData ?? this.hospitalData,
      );
}

class HostelInitial extends HostelState {
  HostelInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          hospitalData: <dynamic>[],
        );
}

class HostelStateLoading extends HostelState {
  const HostelStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.hospitalData,
  });
}

class HostelStateError extends HostelState {
  const HostelStateError({
    required super.successMessage,
    required super.errorMessage,
    required super.hospitalData,
  });
}

class HostelStateSuccessful extends HostelState {
  const HostelStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.hospitalData,
  });
}

class NoNetworkAvailableHostel extends HostelState {
  const NoNetworkAvailableHostel({
    required super.successMessage,
    required super.errorMessage,
    required super.hospitalData,
  });
}

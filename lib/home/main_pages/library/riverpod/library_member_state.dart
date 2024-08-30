import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/library/model/library_transaction_response_model.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_provider.dart';

final libraryProvider =
    StateNotifierProvider<LibraryTransactionProvider, LibraryTrancsactionState>(
        (ref) {
  return LibraryTransactionProvider();
});

class LibraryTrancsactionState {
  const LibraryTrancsactionState({
    required this.successMessage,
    required this.errorMessage,
    required this.libraryTransactionData,
  });

  final String successMessage;
  final String errorMessage;
  final List<LibraryTransactionData> libraryTransactionData;

  LibraryTrancsactionState copyWith({
    String? successMessage,
    String? errorMessage,
    List<LibraryTransactionData>? libraryTransactionData,
  }) =>
      LibraryTrancsactionState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        libraryTransactionData:
            libraryTransactionData ?? this.libraryTransactionData,
      );
}

class LibraryMemberInitial extends LibraryTrancsactionState {
  LibraryMemberInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          libraryTransactionData: <LibraryTransactionData>[],
        );
}

class LibraryTrancsactionStateLoading extends LibraryTrancsactionState {
  const LibraryTrancsactionStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.libraryTransactionData,
  });
}

class LibraryTrancsactionStateError extends LibraryTrancsactionState {
  const LibraryTrancsactionStateError({
    required super.successMessage,
    required super.errorMessage,
    required super.libraryTransactionData,
  });
}

class LibraryTrancsactionStateSuccessful extends LibraryTrancsactionState {
  const LibraryTrancsactionStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.libraryTransactionData,
  });
}

class NoNetworkAvailableLibraryMember extends LibraryTrancsactionState {
  const NoNetworkAvailableLibraryMember({
    required super.successMessage,
    required super.errorMessage,
    required super.libraryTransactionData,
  });
}

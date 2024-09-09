import 'package:flutter/material.dart';
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
    required this.studentId,
    required this.officeid,
    required this.filter,
  });

  final String successMessage;
  final String errorMessage;
  final List<LibraryTransactionData> libraryTransactionData;
  final TextEditingController studentId;
  final TextEditingController officeid;
  final TextEditingController filter;

  LibraryTrancsactionState copyWith({
    String? successMessage,
    String? errorMessage,
    List<LibraryTransactionData>? libraryTransactionData,
    TextEditingController? studentId,
    TextEditingController? officeid,
    TextEditingController? filter,
  }) =>
      LibraryTrancsactionState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        libraryTransactionData:
            libraryTransactionData ?? this.libraryTransactionData,
        studentId: studentId ?? this.studentId,
        officeid: officeid ?? this.officeid,
        filter: filter ?? this.filter,
      );
}

class LibraryMemberInitial extends LibraryTrancsactionState {
  LibraryMemberInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          libraryTransactionData: <LibraryTransactionData>[],
          studentId: TextEditingController(),
          officeid: TextEditingController(),
          filter: TextEditingController(),
        );
}

class LibraryTrancsactionStateLoading extends LibraryTrancsactionState {
  const LibraryTrancsactionStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.libraryTransactionData,
    required super.studentId,
    required super.officeid,
    required super.filter,
  });
}

class LibraryTrancsactionStateError extends LibraryTrancsactionState {
  const LibraryTrancsactionStateError({
    required super.successMessage,
    required super.errorMessage,
    required super.libraryTransactionData,
    required super.studentId,
    required super.officeid,
    required super.filter,
  });
}

class LibraryTrancsactionStateSuccessful extends LibraryTrancsactionState {
  const LibraryTrancsactionStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.libraryTransactionData,
    required super.studentId,
    required super.officeid,
    required super.filter,
  });
}

class NoNetworkAvailableLibraryMember extends LibraryTrancsactionState {
  const NoNetworkAvailableLibraryMember({
    required super.successMessage,
    required super.errorMessage,
    required super.libraryTransactionData,
    required super.studentId,
    required super.officeid,
    required super.filter,
  });
}

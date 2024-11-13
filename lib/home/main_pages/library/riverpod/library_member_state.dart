import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/library/model/library_search_model.dart';
import 'package:sample/home/main_pages/library/model/library_transaction_res_hive_model.dart';
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
    required this.librarysearchData,
  });

  final String successMessage;
  final String errorMessage;
  final List<LibraryTransactionHiveData> libraryTransactionData;
  final TextEditingController studentId;
  final TextEditingController officeid;
  final TextEditingController filter;
  final List<BookSearchData> librarysearchData;

  LibraryTrancsactionState copyWith({
    String? successMessage,
    String? errorMessage,
    List<LibraryTransactionHiveData>? libraryTransactionData,
    TextEditingController? studentId,
    TextEditingController? officeid,
    TextEditingController? filter,
    List<BookSearchData>? librarysearchData,
  }) =>
      LibraryTrancsactionState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        libraryTransactionData:
            libraryTransactionData ?? this.libraryTransactionData,
        studentId: studentId ?? this.studentId,
        officeid: officeid ?? this.officeid,
        filter: filter ?? this.filter,
        librarysearchData: librarysearchData ?? this.librarysearchData,
      );
}

class LibraryMemberInitial extends LibraryTrancsactionState {
  LibraryMemberInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          libraryTransactionData: <LibraryTransactionHiveData>[],
          studentId: TextEditingController(),
          officeid: TextEditingController(),
          filter: TextEditingController(),
          librarysearchData: <BookSearchData>[],
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
    required super.librarysearchData,
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
    required super.librarysearchData,
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
    required super.librarysearchData,
  });
}

class LibraryTrancsactionStateclear extends LibraryTrancsactionState {
  const LibraryTrancsactionStateclear({
    required super.successMessage,
    required super.errorMessage,
    required super.libraryTransactionData,
    required super.studentId,
    required super.officeid,
    required super.filter,
    required super.librarysearchData,
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
    required super.librarysearchData,
  });
}

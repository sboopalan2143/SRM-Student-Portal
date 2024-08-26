import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/library/model/library_member_response_model.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_provider.dart';

final libraryProvider =
    StateNotifierProvider<LibraryMemberProvider, LibraryMemberState>((ref) {
  return LibraryMemberProvider();
});

class LibraryMemberState {
  const LibraryMemberState({
    required this.successMessage,
    required this.errorMessage,
    required this.libraryMemberData,
  });

  final String successMessage;
  final String errorMessage;
  final LibraryMemberData libraryMemberData;

  LibraryMemberState copyWith({
    String? successMessage,
    String? errorMessage,
    LibraryMemberData? libraryMemberData,
  }) =>
      LibraryMemberState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        libraryMemberData: libraryMemberData ?? this.libraryMemberData,
      );
}

class LibraryMemberInitial extends LibraryMemberState {
  LibraryMemberInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          libraryMemberData: LibraryMemberData.empty,
        );
}

class LibraryMemberStateLoading extends LibraryMemberState {
  const LibraryMemberStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.libraryMemberData,
  });
}

class LibraryMemberStateError extends LibraryMemberState {
  const LibraryMemberStateError({
    required super.successMessage,
    required super.errorMessage,
    required super.libraryMemberData,
  });
}

class LibraryMemberStateSuccessful extends LibraryMemberState {
  const LibraryMemberStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.libraryMemberData,
  });
}

class NoNetworkAvailableLibraryMember extends LibraryMemberState {
  const NoNetworkAvailableLibraryMember({
    required super.successMessage,
    required super.errorMessage,
    required super.libraryMemberData,
  });
}

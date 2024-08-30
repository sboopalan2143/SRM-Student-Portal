import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/library/model/library_transaction_response_model.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';

class LibraryTransactionProvider
    extends StateNotifier<LibraryTrancsactionState> {
  LibraryTransactionProvider() : super(LibraryMemberInitial());

  void disposeState() => state = LibraryMemberInitial();

  void _setLoading() => state = const LibraryTrancsactionStateLoading(
        successMessage: '',
        errorMessage: '',
        // libraryMemberData: LibraryMemberData.empty,
        libraryTransactionData: <LibraryTransactionData>[],
      );

  Future<void> getLibraryMemberDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>${TokensManagement.deviceId}</deviceid><accesstoken>${TokensManagement.phoneToken}</accesstoken><androidversion>${TokensManagement.androidVersion}</androidversion><model>${TokensManagement.model}</model><sdkversion>${TokensManagement.sdkVersion}</sdkversion><appversion>${TokensManagement.appVersion}</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getLibraryTransaction', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableLibraryMember(
        successMessage: '',
        errorMessage: '',
        libraryTransactionData: state.libraryTransactionData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final libraryMemberRes =
          details['getLibraryTransactionResponse'] as Map<String, dynamic>;
      final returnData = libraryMemberRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      var libraryTransactionData = state.libraryTransactionData;
      log('decrypted>>>>>>>>$decryptedData');

      try {
        final libraryTransactionDataResponse =
            GetLibraryTransaction.fromJson(decryptedData);
        libraryTransactionData = libraryTransactionDataResponse.data!;
        state = state.copyWith(libraryTransactionData: libraryTransactionData);
        if (libraryTransactionDataResponse.status == 'Success') {
          state = LibraryTrancsactionStateSuccessful(
            successMessage: libraryTransactionDataResponse.status!,
            errorMessage: '',
            libraryTransactionData: state.libraryTransactionData,
          );
        } else if (libraryTransactionDataResponse.status != 'Success') {
          state = LibraryTrancsactionStateError(
            successMessage: '',
            errorMessage: libraryTransactionDataResponse.status!,
            libraryTransactionData: state.libraryTransactionData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData);
        state = LibraryTrancsactionStateError(
          successMessage: '',
          errorMessage: error.message!,
          libraryTransactionData: state.libraryTransactionData,
        );
      }
    } else if (response.$1 != 200) {
      state = LibraryTrancsactionStateError(
        successMessage: '',
        errorMessage: 'Error',
        libraryTransactionData: state.libraryTransactionData,
      );
    }
  }
}

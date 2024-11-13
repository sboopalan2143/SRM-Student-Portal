import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/library/model/library_search_model.dart';
import 'package:sample/home/main_pages/library/model/library_transaction_res_hive_model.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';

class LibraryTransactionProvider
    extends StateNotifier<LibraryTrancsactionState> {
  LibraryTransactionProvider() : super(LibraryMemberInitial());

  void disposeState() => state = LibraryMemberInitial();

  void _setLoading() => state = LibraryTrancsactionStateLoading(
        successMessage: '',
        errorMessage: '',
        // libraryMemberData: LibraryMemberData.empty,
        libraryTransactionData: <LibraryTransactionHiveData>[],
        studentId: TextEditingController(),
        officeid: TextEditingController(),
        filter: TextEditingController(),
        librarysearchData: <BookSearchData>[],
      );

  void clearstate() => state = LibraryTrancsactionStateclear(
        successMessage: '',
        errorMessage: '',
        // libraryMemberData: LibraryMemberData.empty,
        libraryTransactionData: <LibraryTransactionHiveData>[],
        studentId: TextEditingController(),
        officeid: TextEditingController(),
        filter: state.filter,
        librarysearchData: <BookSearchData>[],
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
        studentId: TextEditingController(),
        officeid: TextEditingController(),
        filter: TextEditingController(),
        librarysearchData: state.librarysearchData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final libraryMemberRes =
          details['getLibraryTransactionResponse'] as Map<String, dynamic>;
      final returnData = libraryMemberRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      if (decryptedData.mapData!['Status'] == 'Success') {
        // var libraryTransactionData = state.libraryTransactionData;
        // log('decrypted>>>>>>>>$decryptedData');
        final listData = decryptedData.mapData!['Data'] as List<dynamic>;
        if (listData.isNotEmpty) {
          final box = await Hive.openBox<LibraryTransactionHiveData>(
            'libraryMemberDetails',
          );
          if (box.isEmpty) {
            for (var i = 0; i < listData.length; i++) {
              final parseData = LibraryTransactionHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          } else {
            await box.clear();
            for (var i = 0; i < listData.length; i++) {
              final parseData = LibraryTransactionHiveData.fromJson(
                listData[i] as Map<String, dynamic>,
              );

              await box.add(parseData);
            }
          }
          await box.close();

          // final libraryTransactionDataResponse =
          //     GetLibraryTransaction.fromJson(decryptedData.mapData!);
          // libraryTransactionData = libraryTransactionDataResponse.data!;
          // state = state.copyWith(libraryTransactionData: libraryTransactionData);

          // state = LibraryTrancsactionStateSuccessful(
          //   successMessage: libraryTransactionDataResponse.status!,
          //   errorMessage: '',
          //   libraryTransactionData: state.libraryTransactionData,
          //   studentId: TextEditingController(),
          //   officeid: TextEditingController(),
          //   filter: TextEditingController(),
          // );
        } else {
          final error = ErrorModel.fromJson(decryptedData.mapData!);
          state = LibraryTrancsactionStateError(
            successMessage: '',
            errorMessage: error.message!,
            libraryTransactionData: state.libraryTransactionData,
            studentId: TextEditingController(),
            officeid: TextEditingController(),
            filter: TextEditingController(),
            librarysearchData: state.librarysearchData,
          );
        }
      } else if (decryptedData.mapData!['Status'] != 'Success') {
        state = LibraryTrancsactionStateError(
          successMessage: '',
          errorMessage:
              '''${decryptedData.mapData!['Status']}, ${decryptedData.mapData!['Message']}''',
          libraryTransactionData: state.libraryTransactionData,
          studentId: TextEditingController(),
          officeid: TextEditingController(),
          filter: TextEditingController(),
          librarysearchData: state.librarysearchData,
        );
      }
    } else if (response.$1 != 200) {
      state = LibraryTrancsactionStateError(
        successMessage: '',
        errorMessage: 'Error',
        libraryTransactionData: state.libraryTransactionData,
        studentId: TextEditingController(),
        officeid: TextEditingController(),
        filter: TextEditingController(),
        librarysearchData: state.librarysearchData,
      );
    }
  }

  Future<void> getLibraryMemberHiveData(String search) async {
    try {
      final box = await Hive.openBox<LibraryTransactionHiveData>(
        'libraryMemberDetails',
      );
      final libraryTransactionData = <LibraryTransactionHiveData>[
        ...box.values,
      ];

      state = state.copyWith(libraryTransactionData: libraryTransactionData);
      await box.close();
    } catch (e) {
      await getLibraryMemberHiveData(search);
    }
  }

  Future<void> saveLibrartBookSearchDetails(EncryptionProvider encrypt) async {
    // clearstate();
    log(
      '<studentid>${TokensManagement.studentId}</studentid><officeid>${4}</officeid><filter>${state.filter.text}</filter>',
    );
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><officeid>${TokensManagement.officeId}</officeid><filter>${state.filter.text}</filter>',
    );
    final response = await HttpService.sendSoapRequest('getBookSearch', data);

    if (response.$1 == 0) {
      state = NoNetworkAvailableLibraryMember(
        successMessage: '',
        errorMessage: '',
        libraryTransactionData: state.libraryTransactionData,
        studentId: TextEditingController(),
        officeid: TextEditingController(),
        filter: TextEditingController(),
        librarysearchData: state.librarysearchData,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final libraryMemberRes =
          details['getBookSearchResponse'] as Map<String, dynamic>;
      final returnData = libraryMemberRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');

      var librarysearchData = state.librarysearchData;
      log('decrypted search >>>>>>>> ${decryptedData.mapData}');

      try {
        final librarySearchResponse =
            BooksearchList.fromJson(decryptedData.mapData!);
        librarysearchData = librarySearchResponse.data!;
        state = state.copyWith(librarysearchData: librarysearchData);
        if (librarySearchResponse.status == 'Success') {
        } else if (librarySearchResponse.status != 'Success') {
          state = LibraryTrancsactionStateError(
            successMessage: '',
            errorMessage:
                '''${librarySearchResponse.status!}, ${librarySearchResponse.message!}''',
            libraryTransactionData: state.libraryTransactionData,
            studentId: TextEditingController(),
            officeid: TextEditingController(),
            filter: TextEditingController(),
            librarysearchData: state.librarysearchData,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = LibraryTrancsactionStateError(
          successMessage: '',
          errorMessage: error.message!,
          libraryTransactionData: state.libraryTransactionData,
          studentId: TextEditingController(),
          officeid: TextEditingController(),
          filter: TextEditingController(),
          librarysearchData: state.librarysearchData,
        );
      }
    } else if (response.$1 != 200) {
      state = LibraryTrancsactionStateError(
        successMessage: '',
        errorMessage: 'Error',
        libraryTransactionData: state.libraryTransactionData,
        studentId: TextEditingController(),
        officeid: TextEditingController(),
        filter: TextEditingController(),
        librarysearchData: state.librarysearchData,
      );
    }
  }
}

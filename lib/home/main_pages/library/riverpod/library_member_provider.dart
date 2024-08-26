import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/library/model/library_member_response_model.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';

class LibraryMemberProvider extends StateNotifier<LibraryMemberState> {
  LibraryMemberProvider() : super(LibraryMemberInitial());

  void disposeState() => state = LibraryMemberInitial();

  void _setLoading() => state = LibraryMemberStateLoading(
        successMessage: '',
        errorMessage: '',
        libraryMemberData: LibraryMemberData.empty,
      );

  Future<void> getLibraryMemberDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>21f84947bd6aa060</deviceid><accesstoken>TR</accesstoken><androidversion>TR</androidversion><model>TR</model><sdkversion>TR</sdkversion><appversion>TR</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getfeepaiddetails', data);
    if (response.$1 == 0) {
      state = NoNetworkAvailableLibraryMember(
        successMessage: '',
        errorMessage: '',
        libraryMemberData: LibraryMemberData.empty,
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final libraryMemberRes =
          details['getfeepaiddetailsResponse'] as Map<String, dynamic>;
      final returnData = libraryMemberRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      log('decrypted>>>>>>>>$decryptedData');

      var libraryMemberDetails = LibraryMemberData.empty;
      try {
        final libraryMemberDataResponse =
            LibraryMemberResponseModel.fromJson(decryptedData);
        libraryMemberDetails = libraryMemberDataResponse.data![0];
        state = state.copyWith(libraryMemberData: libraryMemberDetails);
        if (libraryMemberDataResponse.status == 'Success') {
          state = LibraryMemberStateSuccessful(
            successMessage: libraryMemberDataResponse.status!,
            errorMessage: '',
            libraryMemberData: state.libraryMemberData,
          );
        } else if (libraryMemberDataResponse.status != 'Success') {
          state = LibraryMemberStateError(
            successMessage: '',
            errorMessage: libraryMemberDataResponse.status!,
            libraryMemberData: LibraryMemberData.empty,
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData);
        state = LibraryMemberStateError(
          successMessage: '',
          errorMessage: error.message!,
          libraryMemberData: LibraryMemberData.empty,
        );
      }
    } else if (response.$1 != 200) {
      state = LibraryMemberStateError(
        successMessage: '',
        errorMessage: 'Error',
        libraryMemberData: LibraryMemberData.empty,
      );
    }
  }

// Future<void> getLibraryTransactionDetails(EncryptionProvider encrypt) async {
//     _setLoading();
//     final data = encrypt.getEncryptedData(
//       '<studentid>${TokensManagement.studentId}</studentid><deviceid>21f84947bd6aa060</deviceid><accesstoken>TR</accesstoken><androidversion>TR</androidversion><model>TR</model><sdkversion>TR</sdkversion><appversion>TR</appversion>',
//     );
//     final response =
//         await HttpService.sendSoapRequest('getfeepaiddetails', data);
//     if (response.$1 == 0) {
//       state = NoNetworkAvailableLibraryMember(
//         successMessage: '',
//         errorMessage: '',
//         libraryMemberData: LibraryMemberData.empty,
//       );
//     } else if (response.$1 == 200) {
//       final details = response.$2['Body'] as Map<String, dynamic>;
//       final libraryMemberRes =
//           details['getfeepaiddetailsResponse'] as Map<String, dynamic>;
//       final returnData = libraryMemberRes['return'] as Map<String, dynamic>;
//       final data = returnData['#text'];
//       final decryptedData = encrypt.getDecryptedData('$data');
//       log('decrypted>>>>>>>>$decryptedData');

//       var libraryMemberDetails = LibraryMemberData.empty;
//       try {
//         final libraryMemberDataResponse =
//             LibraryMemberResponseModel.fromJson(decryptedData);
//         libraryMemberDetails = libraryMemberDataResponse.data![0];
//         state = state.copyWith(libraryMemberData: libraryMemberDetails);
//         if (libraryMemberDataResponse.status == 'Success') {
//           state = LibraryMemberStateSuccessful(
//             successMessage: libraryMemberDataResponse.status!,
//             errorMessage: '',
//             libraryMemberData: state.libraryMemberData,
//           );
//         } else if (libraryMemberDataResponse.status != 'Success') {
//           state = LibraryMemberStateError(
//             successMessage: '',
//             errorMessage: libraryMemberDataResponse.status!,
//             libraryMemberData: LibraryMemberData.empty,
//           );
//         }
//       } catch (e) {
//         final error = ErrorModel.fromJson(decryptedData);
//         state = LibraryMemberStateError(
//           successMessage: '',
//           errorMessage: error.message!,
//           libraryMemberData: LibraryMemberData.empty,
//         );
//       }
//     } else if (response.$1 != 200) {
//       state = LibraryMemberStateError(
//         successMessage: '',
//         errorMessage: 'Error',
//         libraryMemberData: LibraryMemberData.empty,
//       );
//     }
//   }


}

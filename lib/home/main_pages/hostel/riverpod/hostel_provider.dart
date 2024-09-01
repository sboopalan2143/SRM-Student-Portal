import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_state.dart';
import 'package:sample/home/main_pages/library/model/library_member_response_model.dart';

class HostelProvider extends StateNotifier<HostelState> {
  HostelProvider() : super(HostelInitial());

  void disposeState() => state = HostelInitial();

  void _setLoading() => state = const HostelStateLoading(
        successMessage: '',
        errorMessage: '',
        hospitalData: <dynamic>[],
      );

  Future<void> getHostelDetails(EncryptionProvider encrypt) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>21f84947bd6aa060</deviceid><accesstoken>TR</accesstoken><androidversion>TR</androidversion><model>TR</model><sdkversion>TR</sdkversion><appversion>TR</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getHostelDetails', data);
    if (response.$1 == 0) {
      state = const NoNetworkAvailableHostel(
        successMessage: '',
        errorMessage: '',
        hospitalData: <dynamic>[],
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final hostelRes =
          details['getHostelDetailsResponse'] as Map<String, dynamic>;
      final returnData = hostelRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      log('decrypted>>>>>>>>$decryptedData');
//change model
      try {
        final hostelDataResponse =
            LibraryMemberResponseModel.fromJson(decryptedData.mapData!);
        // hostelDetails = hostelDataResponse.data![0];
        // state = state.copyWith(libraryMemberData: libraryMemberDetails);
        if (hostelDataResponse.status == 'Success') {
          state = HostelStateSuccessful(
            successMessage: hostelDataResponse.status!,
            errorMessage: '',
            hospitalData: <dynamic>[],
          );
        } else if (hostelDataResponse.status != 'Success') {
          state = HostelStateError(
              successMessage: '',
              errorMessage: hostelDataResponse.status!,
              hospitalData: <dynamic>[]);
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData.mapData!);
        state = HostelStateError(
          successMessage: '',
          errorMessage: error.message!,
          hospitalData: <dynamic>[],
        );
      }
    } else if (response.$1 != 200) {
      state = const HostelStateError(
        successMessage: '',
        errorMessage: 'Error',
        hospitalData: <dynamic>[],
      );
    }
  }
}

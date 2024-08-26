import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/encryption/encryption_provider.dart';
import 'package:sample/encryption/model/error_model.dart';
import 'package:sample/home/main_pages/academics/internal_marks_pages/riverpod/internal_marks_state.dart';
import 'package:sample/home/main_pages/academics/subject_pages/model/subject_response_model.dart';

class InternalMarksProvider extends StateNotifier<InternalMarksState> {
  InternalMarksProvider() : super(InternalMarksInitial());

  void disposeState() => state = InternalMarksInitial();

  void _setLoading() => state = const InternalMarksState(
        successMessage: '',
        errorMessage: '',
        // cummulativeAttendanceData: <CummulativeAttendanceData>[],
      );

  Future<void> getInternalMarksDetails(
    EncryptionProvider encrypt,
  ) async {
    _setLoading();
    final data = encrypt.getEncryptedData(
      '<studentid>${TokensManagement.studentId}</studentid><deviceid>21f84947bd6aa060</deviceid><accesstoken>TR</accesstoken><androidversion>TR</androidversion><model>TR</model><sdkversion>TR</sdkversion><appversion>TR</appversion>',
    );
    final response =
        await HttpService.sendSoapRequest('getInternalMarkDetails', data);
    if (response.$1 == 0) {
      state = const NoNetworkAvailableInternalMarks(
        successMessage: '',
        errorMessage: '',
        //  cummulativeAttendanceData: <CummulativeAttendanceData>[],
      );
    } else if (response.$1 == 200) {
      final details = response.$2['Body'] as Map<String, dynamic>;
      final internalMarksRes =
          details['getInternalMarkDetailsResponse'] as Map<String, dynamic>;
      final returnData = internalMarksRes['return'] as Map<String, dynamic>;
      final data = returnData['#text'];
      final decryptedData = encrypt.getDecryptedData('$data');
      log('decrypted>>>>>>>>$decryptedData');

      // var cummulativeAttendanceData = <CummulativeAttendanceData>[];
      try {
        //change model
        final InternalMarksDataResponse =
            SubjectResponseModel.fromJson(decryptedData);
        // cummulativeAttendanceData = attendanceDataResponse.data!;
// state = state.copyWith(cummulativeAttendanceData: cummulativeAttendanceData);
        if (InternalMarksDataResponse.status == 'Success') {
          state = InternalMarksStateSuccessful(
            successMessage: InternalMarksDataResponse.status!,
            errorMessage: '',
            //cummulativeAttendanceData: <CummulativeAttendanceData>[],
          );
        } else if (InternalMarksDataResponse.status != 'Success') {
          state = InternalMarksStateError(
            successMessage: '',
            errorMessage: InternalMarksDataResponse.status!,
            //  cummulativeAttendanceData: <CummulativeAttendanceData>[],
          );
        }
      } catch (e) {
        final error = ErrorModel.fromJson(decryptedData);
        state = InternalMarksStateError(
          successMessage: '',
          errorMessage: error.message!,
          // cummulativeAttendanceData: <CummulativeAttendanceData>[],
        );
      }
    } else if (response.$1 != 200) {
      state = const InternalMarksStateError(
        successMessage: '',
        errorMessage: 'Error',
        // cummulativeAttendanceData: <CummulativeAttendanceData>[],
      );
    }
  }
}

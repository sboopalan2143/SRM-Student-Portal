import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/cgpa/model/cgpa_model.dart';
import 'package:sample/home/main_pages/cgpa/riverpod/cgpa_provider.dart';
import 'package:sample/home/main_pages/lms/lms%20content%20details/content%20detail%20model/lms_content_details_model.dart';
import 'package:sample/home/main_pages/lms/lms%20content%20details/content%20details%20riverpod/lms_content_details_provider.dart';

final lmsContentDetailsProvider =
    StateNotifierProvider<LmsContentDetailsProvider, LmsContentDetailsState>(
        (ref) {
  return LmsContentDetailsProvider();
});

class LmsContentDetailsState {
  const LmsContentDetailsState({
    required this.successMessage,
    required this.errorMessage,
    required this.lmsContentData,
  });

  final String successMessage;
  final String errorMessage;
  final List<LmsContentDetailsData> lmsContentData;

  LmsContentDetailsState copyWith({
    String? successMessage,
    String? errorMessage,
    String? navNotificationString,
    List<LmsContentDetailsData>? lmsContentData,
  }) =>
      LmsContentDetailsState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        lmsContentData: lmsContentData ?? this.lmsContentData,
      );
}

class LmsContentDetailsInitial extends LmsContentDetailsState {
  LmsContentDetailsInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          lmsContentData: <LmsContentDetailsData>[],
        );
}

class LmsContentdetailsLoading extends LmsContentDetailsState {
  const LmsContentdetailsLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.lmsContentData,
  });
}

class LmsContentDetailsSuccessFull extends LmsContentDetailsState {
  const LmsContentDetailsSuccessFull({
    required super.successMessage,
    required super.errorMessage,
    required super.lmsContentData,
  });
}

class LmsContentDetailsError extends LmsContentDetailsState {
  const LmsContentDetailsError({
    required super.successMessage,
    required super.errorMessage,
    required super.lmsContentData,
  });
}

class NoNetworkAvailableLmsContentDetails extends LmsContentDetailsState {
  const NoNetworkAvailableLmsContentDetails({
    required super.successMessage,
    required super.errorMessage,
    required super.lmsContentData,
  });
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/drawer_pages/profile/model/profile_response_model.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_provider.dart';

final profileProvider =
    StateNotifierProvider<ProfileProvider, ProfileDetailsState>((ref) {
  return ProfileProvider();
});

class ProfileDetailsState {
  const ProfileDetailsState({
    required this.successMessage,
    required this.errorMessage,
    required this.profileData,
  });

  final String successMessage;
  final String errorMessage;
  final ProfileDetails profileData;

  ProfileDetailsState copyWith({
    String? successMessage,
    String? errorMessage,
    ProfileDetails? profileData,
  }) =>
      ProfileDetailsState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        profileData: profileData ?? this.profileData,
      );
}

class ProfileInitial extends ProfileDetailsState {
  ProfileInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          profileData: ProfileDetails.empty,
        );
}

class ProfileDetailsStateLoading extends ProfileDetailsState {
  const ProfileDetailsStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.profileData,
  });
}

class ProfileDetailsStateError extends ProfileDetailsState {
  const ProfileDetailsStateError({
    required super.successMessage,
    required super.errorMessage,
    required super.profileData,
  });
}

class ProfileDetailsStateSuccessful extends ProfileDetailsState {
  const ProfileDetailsStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.profileData,
  });
}

class NoNetworkAvailableProfile extends ProfileDetailsState {
  const NoNetworkAvailableProfile({
    required super.successMessage,
    required super.errorMessage,
    required super.profileData,
  });
}

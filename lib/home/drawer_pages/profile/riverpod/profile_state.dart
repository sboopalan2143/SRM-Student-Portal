import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_provider.dart';

final profileProvider =
    StateNotifierProvider<ProfileProvider, ProfileState>((ref) {
  return ProfileProvider();
});

class ProfileState {
  const ProfileState({
    required this.successMessage,
    required this.errorMessage,
  });

  final String successMessage;
  final String errorMessage;

  ProfileState copyWith({
    String? successMessage,
    String? errorMessage,
  }) =>
      ProfileState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}

class ProfileInitial extends ProfileState {
  ProfileInitial()
      : super(
          successMessage: '',
          errorMessage: '',
        );
}

class ProfileStateLoading extends ProfileState {
  const ProfileStateLoading({
    required super.successMessage,
    required super.errorMessage,
  });
}

class ProfileStateError extends ProfileState {
  const ProfileStateError({
    required super.successMessage,
    required super.errorMessage,
  });
}

class ProfileStateSuccessful extends ProfileState {
  const ProfileStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
  });
}

class NoNetworkAvailableProfile extends ProfileState {
  const NoNetworkAvailableProfile({
    required super.successMessage,
    required super.errorMessage,
  });
}

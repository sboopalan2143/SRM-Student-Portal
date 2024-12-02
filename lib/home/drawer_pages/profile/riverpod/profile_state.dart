// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sample/home/drawer_pages/profile/model/profile_hive_model.dart';
// import 'package:sample/home/drawer_pages/profile/riverpod/profile_provider.dart';

// final profileProvider =
//     StateNotifierProvider<ProfileProvider, ProfileDetailsState>((ref) {
//   return ProfileProvider();
// });

// class ProfileDetailsState {
//   const ProfileDetailsState({
//     required this.successMessage,
//     required this.errorMessage,
//     required this.profileDataHive,
//   });

//   final String successMessage;
//   final String errorMessage;

//   final ProfileHiveData profileDataHive;

//   ProfileDetailsState copyWith({
//     String? successMessage,
//     String? errorMessage,
//     ProfileHiveData? profileDataHive,
//   }) =>
//       ProfileDetailsState(
//         successMessage: successMessage ?? this.successMessage,
//         errorMessage: errorMessage ?? this.errorMessage,
//         profileDataHive: profileDataHive ?? this.profileDataHive,
//       );
// }

// class ProfileInitial extends ProfileDetailsState {
//   ProfileInitial()
//       : super(
//           successMessage: '',
//           errorMessage: '',
//           profileDataHive: ProfileHiveData.empty,
//         );
// }

// class ProfileDetailsStateLoading extends ProfileDetailsState {
//   const ProfileDetailsStateLoading({
//     required super.successMessage,
//     required super.errorMessage,
//     required super.profileDataHive,
//   });
// }

// class ProfileDetailsStateError extends ProfileDetailsState {
//   const ProfileDetailsStateError({
//     required super.successMessage,
//     required super.errorMessage,
//     required super.profileDataHive,
//   });
// }

// class ProfileDetailsStateSuccessful extends ProfileDetailsState {
//   const ProfileDetailsStateSuccessful({
//     required super.successMessage,
//     required super.errorMessage,
//     required super.profileDataHive,
//   });
// }

// class NoNetworkAvailableProfile extends ProfileDetailsState {
//   const NoNetworkAvailableProfile({
//     required super.successMessage,
//     required super.errorMessage,
//     required super.profileDataHive,
//   });
// }


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/drawer_pages/profile/model/profile_hive_model.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_provider.dart';

final profileProvider =
    StateNotifierProvider<ProfileProvider, ProfileDetailsState>((ref) {
  return ProfileProvider();
});

class ProfileDetailsState {
  const ProfileDetailsState({
    required this.successMessage,
    required this.errorMessage,
    required this.profileDataHive,
  });

  final String successMessage;
  final String errorMessage;

  final ProfileHiveData profileDataHive;

  ProfileDetailsState copyWith({
    String? successMessage,
    String? errorMessage,
    ProfileHiveData? profileDataHive,
  }) =>
      ProfileDetailsState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        profileDataHive: profileDataHive ?? this.profileDataHive,
      );
}

class ProfileInitial extends ProfileDetailsState {
  ProfileInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          profileDataHive: ProfileHiveData.empty,
        );
}

class ProfileDetailsStateLoading extends ProfileDetailsState {
  const ProfileDetailsStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.profileDataHive,
  });
}

class ProfileDetailsStateError extends ProfileDetailsState {
  const ProfileDetailsStateError({
    required super.successMessage,
    required super.errorMessage,
    required super.profileDataHive,
  });
}

class ProfileDetailsStateSuccessful extends ProfileDetailsState {
  const ProfileDetailsStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.profileDataHive,
  });
}

class NoNetworkAvailableProfile extends ProfileDetailsState {
  const NoNetworkAvailableProfile({
    required super.successMessage,
    required super.errorMessage,
    required super.profileDataHive,
  });
}
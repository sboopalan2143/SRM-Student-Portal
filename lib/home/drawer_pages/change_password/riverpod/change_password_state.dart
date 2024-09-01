import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/drawer_pages/change_password/riverpod/change_password_provider.dart';

final changePasswordProvider =
    StateNotifierProvider<ChangePasswordProvider, ChangePasswordState>((ref) {
  return ChangePasswordProvider();
});

class ChangePasswordState {
  const ChangePasswordState({
    required this.message,
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  final String message;
  final TextEditingController currentPassword;
  final TextEditingController newPassword;
  final TextEditingController confirmPassword;

  ChangePasswordState copyWith({
    String? message,
    TextEditingController? currentPassword,
    TextEditingController? newPassword,
    TextEditingController? confirmPassword,
  }) =>
      ChangePasswordState(
        message: message ?? this.message,
        currentPassword: currentPassword ?? this.currentPassword,
        newPassword: newPassword ?? this.newPassword,
        confirmPassword: confirmPassword ?? this.confirmPassword,
      );
}

class ChangePasswordInitial extends ChangePasswordState {
  ChangePasswordInitial()
      : super(
          message: '',
          currentPassword: TextEditingController(),
          newPassword: TextEditingController(),
          confirmPassword: TextEditingController(),
        );
}

class ChangePasswordStateLoading extends ChangePasswordState {
  const ChangePasswordStateLoading({
    required super.message,
    required super.currentPassword,
    required super.newPassword,
    required super.confirmPassword,
  });
}

class ChangePasswordStateError extends ChangePasswordState {
  const ChangePasswordStateError({
    required super.message,
    required super.currentPassword,
    required super.newPassword,
    required super.confirmPassword,
  });
}

class ChangePasswordStateSuccessful extends ChangePasswordState {
  const ChangePasswordStateSuccessful({
    required super.message,
    required super.currentPassword,
    required super.newPassword,
    required super.confirmPassword,
  });
}

class NoNetworkAvailableChangePassword extends ChangePasswordState {
  const NoNetworkAvailableChangePassword({
    required super.message,
    required super.currentPassword,
    required super.newPassword,
    required super.confirmPassword,
  });
}

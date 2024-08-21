import 'package:flutter/widgets.dart';
import 'package:sample/login/riverpod/login_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = StateNotifierProvider<LoginProvider, LoginState>((ref) {
  return LoginProvider();
});

class LoginState {
  const LoginState({
    required this.successMessage,
    required this.errorMessage,
    required this.userName,
    required this.password,
  });

  final String successMessage;
  final String errorMessage;
  final TextEditingController userName;
  final TextEditingController password;

  LoginState copyWith({
    String? successMessage,
    String? errorMessage,
    TextEditingController? userName,
    TextEditingController? password,
  }) =>
      LoginState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        userName: userName ?? this.userName,
        password: password ?? this.password,
      );
}

class LoginInitial extends LoginState {
  LoginInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          userName: TextEditingController(),
          password: TextEditingController(),
        );
}

class LoginStateLoading extends LoginState {
  const LoginStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.userName,
    required super.password,
  });
}

class LoginStateError extends LoginState {
  const LoginStateError({
    required super.successMessage,
    required super.errorMessage,
    required super.userName,
    required super.password,
  });
}

class LoginStateSuccessful extends LoginState {
  const LoginStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.userName,
    required super.password,
  });
}

class NoNetworkAvailable extends LoginState {
  const NoNetworkAvailable({
    required super.successMessage,
    required super.errorMessage,
    required super.userName,
    required super.password,
  });
}

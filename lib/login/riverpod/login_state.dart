import 'package:sample/login/riverpod/login_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = StateNotifierProvider<LoginProvider, LoginState>((ref) {
  return LoginProvider();
});

class LoginState {
  const LoginState({
    required this.phoneNumber,
    required this.password,
    required this.obscure,
  });

  final String phoneNumber;
  final String password;
  final bool obscure;

  LoginState copyWith({
    String? phoneNumber,
    String? password,
    bool? obscure,
  }) =>
      LoginState(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        password: password ?? this.password,
        obscure: obscure ?? this.obscure,
      );
}

class LoginInitial extends LoginState {
  const LoginInitial()
      : super(
          phoneNumber: '',
          password: '',
          obscure: true,
        );
}

class LoginStateLoading extends LoginState {
  const LoginStateLoading({
    required super.phoneNumber,
    required super.password,
    required super.obscure,
  });
}

class LoginStateError extends LoginState {
  const LoginStateError({
    required super.phoneNumber,
    required super.password,
    required super.obscure,
    required this.errorMessage,
  });

  final String errorMessage;
}

class LoginStateSuccessful extends LoginState {
  const LoginStateSuccessful({
    required super.phoneNumber,
    required super.password,
    required super.obscure,
  });
}

class NoNetworkAvailable extends LoginState {
  const NoNetworkAvailable({
    required super.phoneNumber,
    required super.password,
    required super.obscure,
  });
}

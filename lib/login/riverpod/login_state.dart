import 'package:flutter/widgets.dart';
import 'package:sample/login/model/login_response_model.dart';
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
    required this.studentData,
  });

  final String successMessage;
  final String errorMessage;
  final TextEditingController userName;
  final TextEditingController password;
  final LoginData studentData;

  LoginState copyWith({
    String? successMessage,
    String? errorMessage,
    TextEditingController? userName,
    TextEditingController? password,
    LoginData? studentData,
  }) =>
      LoginState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        studentData: studentData ?? this.studentData,
      );
}

class LoginInitial extends LoginState {
  LoginInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          userName: TextEditingController(),
          password: TextEditingController(),
          studentData: LoginData.empty,
        );
}

class LoginStateLoading extends LoginState {
  const LoginStateLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.userName,
    required super.password,
    required super.studentData,
  });
}

class LoginStateError extends LoginState {
  const LoginStateError({
    required super.successMessage,
    required super.errorMessage,
    required super.userName,
    required super.password,
    required super.studentData,
  });
}

class LoginStateSuccessful extends LoginState {
  const LoginStateSuccessful({
    required super.successMessage,
    required super.errorMessage,
    required super.userName,
    required super.password,
    required super.studentData,
  });
}

class NoNetworkAvailable extends LoginState {
  const NoNetworkAvailable({
    required super.successMessage,
    required super.errorMessage,
    required super.userName,
    required super.password,
    required super.studentData,

 
  });
}

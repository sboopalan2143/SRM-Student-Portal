import 'package:sample/api_token_services/http_services.dart';
import 'package:sample/login/riverpod/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginProvider extends StateNotifier<LoginState> {
  LoginProvider() : super(const LoginInitial());

  void disposeState() => state = const LoginInitial();

  void setPhoneNumber(String phoneNumber) =>
      state = state.copyWith(phoneNumber: phoneNumber);

  void setPassword(String password) =>
      state = state.copyWith(password: password);

  void setObscure() => state = state.copyWith(obscure: !state.obscure);

  void _setLoading() => state = LoginStateLoading(
        phoneNumber: state.phoneNumber,
        password: state.password,
        obscure: state.obscure,
      );

  Future<void> login() async {
    _setLoading();
    const url = '';
    final response = await HttpService.initialGetApi(url: url);
    if (response.$1 == 0) {
      state = NoNetworkAvailable(
        phoneNumber: state.phoneNumber,
        password: state.password,
        obscure: state.obscure,
      );
    } else if (response.$1 == 200) {
      state = LoginStateSuccessful(
        phoneNumber: state.phoneNumber,
        password: state.password,
        obscure: state.obscure,
      );
      disposeState();
    } else if (response.$1 != 200) {
      state = LoginStateError(
        phoneNumber: state.phoneNumber,
        password: state.password,
        obscure: state.obscure,
        errorMessage: 'Error Message',
      );
    }
  }
}

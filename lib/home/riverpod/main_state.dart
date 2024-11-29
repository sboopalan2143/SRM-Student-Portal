import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/riverpod/main_provider.dart';

final mainProvider = StateNotifierProvider<MainProvider, MainState>((ref) {
  return MainProvider();
});

class MainState {
  const MainState({
    required this.successMessage,
    required this.errorMessage,
    required this.navString,
    required this.subNavString,
    required this.myCurrentIndex,
  });

  final String successMessage;
  final String errorMessage;
  final String navString;
  final String subNavString;
  final int myCurrentIndex;

  MainState copyWith({
    String? successMessage,
    String? errorMessage,
    String? navString,
    String? subNavString,
    int? myCurrentIndex,
  }) =>
      MainState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        navString: navString ?? this.navString,
        subNavString: subNavString ?? this.subNavString,
        myCurrentIndex: myCurrentIndex ?? this.myCurrentIndex,
      );
}

class SettingInitial extends MainState {
  SettingInitial()
      : super(
            successMessage: '',
            errorMessage: '',
            navString: '',
            subNavString: '',
            myCurrentIndex: 0);
}

class SettingLoading extends MainState {
  const SettingLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.navString,
    required super.subNavString,
    required super.myCurrentIndex,
  });
}

class SettingSuccessFull extends MainState {
  const SettingSuccessFull({
    required super.successMessage,
    required super.errorMessage,
    required super.navString,
    required super.subNavString,
    required super.myCurrentIndex,
  });
}

class SettingError extends MainState {
  const SettingError({
    required super.successMessage,
    required super.errorMessage,
    required super.navString,
    required super.subNavString,
    required super.myCurrentIndex,
  });
}

class NoNetworkAvailablePhoto extends MainState {
  const NoNetworkAvailablePhoto({
    required super.successMessage,
    required super.errorMessage,
    required super.navString,
    required super.subNavString,
    required super.myCurrentIndex,
  });
}

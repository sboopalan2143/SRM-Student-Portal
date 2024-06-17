import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/riverpod/main_state.dart';

class MainProvider extends StateNotifier<MainState> {
  MainProvider() : super(SettingInitial());

  void disposeState() => state = SettingInitial();

  void setNavString(String text) {
    state = state.copyWith(navString: text);
    log(state.navString);
  }
}

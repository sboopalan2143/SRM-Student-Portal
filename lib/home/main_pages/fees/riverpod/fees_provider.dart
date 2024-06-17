import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_state.dart';

class FeesProvider extends StateNotifier<FeesState> {
  FeesProvider() : super(FeesInitial());

  void disposeState() => state = FeesInitial();

  void setFeesNavString(String text) {
    state = state.copyWith(navFeesString: text);
    log(state.navFeesString);
  }
}

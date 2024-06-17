import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_state.dart';

class NotificationProvider extends StateNotifier<NotificationState> {
  NotificationProvider() : super(NotificationInitial());

  void disposeState() => state = NotificationInitial();

  void setNotificationNavString(String text) {
    state = state.copyWith(navNotificationString: text);
    log(state.navNotificationString);
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_provider.dart';

final notificationProvider =
    StateNotifierProvider<NotificationProvider, NotificationState>((ref) {
  return NotificationProvider();
});

class NotificationState {
  const NotificationState({
    required this.successMessage,
    required this.errorMessage,
    required this.navNotificationString,
  });

  final String successMessage;
  final String errorMessage;
  final String navNotificationString;

  NotificationState copyWith({
    String? successMessage,
    String? errorMessage,
    String? navNotificationString,
  }) =>
      NotificationState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        navNotificationString:
            navNotificationString ?? this.navNotificationString,
      );
}

class NotificationInitial extends NotificationState {
  NotificationInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          navNotificationString: 'From Staff',
        );
}

class NotificationSuccessFull extends NotificationState {
  const NotificationSuccessFull({
    required super.successMessage,
    required super.errorMessage,
    required super.navNotificationString,
  });
}

class NotificationError extends NotificationState {
  const NotificationError({
    required super.successMessage,
    required super.errorMessage,
    required super.navNotificationString,
  });
}

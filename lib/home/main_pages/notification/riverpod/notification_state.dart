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
    required this.notificationData,
  });

  final String successMessage;
  final String errorMessage;
  final String navNotificationString;
  final List<dynamic> notificationData;

  NotificationState copyWith({
    String? successMessage,
    String? errorMessage,
    String? navNotificationString,
    List<dynamic>? notificationData,
  }) =>
      NotificationState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        navNotificationString:
            navNotificationString ?? this.navNotificationString,
        notificationData: notificationData ?? this.notificationData,
      );
}

class NotificationInitial extends NotificationState {
  NotificationInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          navNotificationString: 'From Staff',
          notificationData: <dynamic>[],
        );
}

class NotificationLoading extends NotificationState {
  const NotificationLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.navNotificationString,
    required super.notificationData,
  });
}

class NotificationSuccessFull extends NotificationState {
  const NotificationSuccessFull({
    required super.successMessage,
    required super.errorMessage,
    required super.navNotificationString,
    required super.notificationData,
  });
}

class NotificationError extends NotificationState {
  const NotificationError({
    required super.successMessage,
    required super.errorMessage,
    required super.navNotificationString,
    required super.notificationData,
  });
}

class NoNetworkAvailableNotification extends NotificationState {
  const NoNetworkAvailableNotification({
    required super.successMessage,
    required super.errorMessage,
    required super.navNotificationString,
    required super.notificationData,
  });
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/notification/model/notification_model.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_provider.dart';

final notificationProvider =
    StateNotifierProvider<NotificationProvider, NotificationState>((ref) {
  return NotificationProvider();
});

class NotificationState {
  const NotificationState({
    required this.successMessage,
    required this.errorMessage,
    required this.notificationData,
  });

  final String successMessage;
  final String errorMessage;
  final List<NotificationData> notificationData;

  NotificationState copyWith({
    String? successMessage,
    String? errorMessage,
    String? navNotificationString,
    List<NotificationData>? notificationData,
  }) =>
      NotificationState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        notificationData: notificationData ?? this.notificationData,
      );
}

class NotificationInitial extends NotificationState {
  NotificationInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          notificationData: <NotificationData>[],
        );
}

class NotificationLoading extends NotificationState {
  const NotificationLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.notificationData,
  });
}

class NotificationSuccessFull extends NotificationState {
  const NotificationSuccessFull({
    required super.successMessage,
    required super.errorMessage,
    required super.notificationData,
  });
}

class NotificationError extends NotificationState {
  const NotificationError({
    required super.successMessage,
    required super.errorMessage,
    required super.notificationData,
  });
}

class NoNetworkAvailableNotification extends NotificationState {
  const NoNetworkAvailableNotification({
    required super.successMessage,
    required super.errorMessage,
    required super.notificationData,
  });
}

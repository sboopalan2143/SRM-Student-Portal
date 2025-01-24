import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/notification/model/notification_count_model.dart';
import 'package:sample/home/main_pages/notification/model/notification_model.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_count_provider.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_provider.dart';

final notificationCountProvider =
    StateNotifierProvider<NotificationCountProvider, NotificationCountState>(
        (ref) {
  return NotificationCountProvider();
});

class NotificationCountState {
  const NotificationCountState({
    required this.successMessage,
    required this.errorMessage,
    required this.notificationCountData,
  });

  final String successMessage;
  final String errorMessage;
  final List<NotificationCountData> notificationCountData;

  NotificationCountState copyWith({
    String? successMessage,
    String? errorMessage,
    String? navNotificationString,
    List<NotificationCountData>? notificationCountData,
  }) =>
      NotificationCountState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        notificationCountData:
            notificationCountData ?? this.notificationCountData,
      );
}

class NotificationCountInitial extends NotificationCountState {
  NotificationCountInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          notificationCountData: <NotificationCountData>[],
        );
}

class NotificationCountLoading extends NotificationCountState {
  const NotificationCountLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.notificationCountData,
  });
}

class NotificationCountSuccessFull extends NotificationCountState {
  const NotificationCountSuccessFull({
    required super.successMessage,
    required super.errorMessage,
    required super.notificationCountData,
  });
}

class NotificationCountError extends NotificationCountState {
  const NotificationCountError({
    required super.successMessage,
    required super.errorMessage,
    required super.notificationCountData,
  });
}

class NoNetworkCountAvailableNotification extends NotificationCountState {
  const NoNetworkCountAvailableNotification({
    required super.successMessage,
    required super.errorMessage,
    required super.notificationCountData,
  });
}

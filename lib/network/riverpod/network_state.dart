
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/network/riverpod/network_provider.dart';

final networkProvider =
    StateNotifierProvider<NetworkProvider, NetworkState>((ref) {
  return NetworkProvider();
});

class NetworkState {
  const NetworkState({
    required this.connectivityResult,
    required this.showOfflinePage,
  });

  final ConnectivityResult connectivityResult;
  final bool showOfflinePage;

  NetworkState copyWith({
    ConnectivityResult? connectivityResult,
    bool? showOfflinePage,
  }) =>
      NetworkState(
        connectivityResult: connectivityResult ?? this.connectivityResult,
        showOfflinePage: showOfflinePage ?? this.showOfflinePage,
      );
}

class NetworkInitial extends NetworkState {
  const NetworkInitial()
      : super(
          connectivityResult: ConnectivityResult.none,
          showOfflinePage: false,
        );
}

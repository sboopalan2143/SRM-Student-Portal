import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/network/network_state.dart';

class NetworkProvider extends StateNotifier<NetworkState> {
  NetworkProvider() : super(const NetworkInitial());

  StreamSubscription<ConnectivityResult>? subscription;

  void disposeState() {
    subscription?.cancel();
    state = const NetworkInitial();
  }

  //  void subscribe() {
  //   subscription = Connectivity().onConnectivityChanged.listen((result) {
  //     state = state.copyWith(connectivityResult: result);
  //   });
  // }
}

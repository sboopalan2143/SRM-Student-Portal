import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/encryption/encryption_provider.dart';

final encryptionProvider =
    StateNotifierProvider<EncryptionProvider, EncryptionState>((ref) {
  return EncryptionProvider();
});

class EncryptionState {
  const EncryptionState({
    required this.successMessage,
    required this.errorMessage,
    required this.keyString,
    required this.ivString,
    required this.strCommonKey,
    required this.strCommonIV,
    required this.strPrivateKey,
    required this.strPrivateIV,
  });

  final String successMessage;
  final String errorMessage;

  final String keyString;
  final String ivString;
  final String strCommonKey;
  final String strCommonIV;
  final String strPrivateKey;
  final String strPrivateIV;

  EncryptionState copyWith({
    String? successMessage,
    String? errorMessage,
    String? keyString,
    String? ivString,
    String? strCommonKey,
    String? strCommonIV,
    String? strPrivateKey,
    String? strPrivateIV,
  }) =>
      EncryptionState(
        successMessage: successMessage ?? this.successMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        keyString: keyString ?? this.keyString,
        ivString: ivString ?? this.ivString,
        strCommonKey: strCommonKey ?? this.strCommonKey,
        strCommonIV: strCommonIV ?? this.strCommonIV,
        strPrivateKey: strPrivateKey ?? this.strPrivateKey,
        strPrivateIV: strPrivateIV ?? this.strPrivateIV,
      );
}

class EncryptionInitial extends EncryptionState {
  EncryptionInitial()
      : super(
          successMessage: '',
          errorMessage: '',
          keyString: '',
          ivString: '',
          strCommonKey: r"z6pAt3DxKhJO7M5PqWgnfVxaPvgpIS2A",
          strCommonIV: r"FwK6GxkSJ759yH8w",
          strPrivateKey: "G9ywTgT6G7DbPOLgFPi2qGCvZLR4s2TB",
          strPrivateIV: "nQi5qc7K1Js4KYIq",
        );
}

class EncryptionLoading extends EncryptionState {
  const EncryptionLoading({
    required super.successMessage,
    required super.errorMessage,
    required super.keyString,
    required super.ivString,
    required super.strCommonKey,
    required super.strCommonIV,
    required super.strPrivateKey,
    required super.strPrivateIV,
  });
}

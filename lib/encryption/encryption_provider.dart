import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hex/hex.dart';
import 'package:srmuh_std/encryption/encryption_state.dart';

class EncryptionProvider extends StateNotifier<EncryptionState> {
  EncryptionProvider() : super(EncryptionInitial());

  void disposeState() => state = EncryptionInitial();

  // void _setLoading() => state = EncryptionLoading(
  //       successMessage: '',
  //       errorMessage: '',
  //       keyString: '',
  //       ivString: '',
  //       strCommonKey: state.strCommonKey,
  //       strCommonIV: state.strCommonIV,
  //       strPrivateKey: state.strPrivateKey,
  //       strPrivateIV: state.strPrivateIV,
  //     );

  String getEncryptedData(String stringToEncrypt) {
    var strEncryptedData = '';
    try {
      // Encrypting for Data iteration 1
      setKey(state.strPrivateKey, state.strPrivateIV);

      final strData = encrypt(stringToEncrypt);

      // Encrypting for Data iteration 2
      setKey(state.strCommonKey, state.strCommonIV);
      strEncryptedData = encrypt(strData);
    } catch (e) {
      log('$e');
    }
    return strEncryptedData;
  }

  DecryptedData getDecryptedData(String stringToDecrypt) {
    log('enters decrypt');
    var strDecryptedData = '';
    Map<String, dynamic>? mapData;
    String? stringData;

    try {
      setKey(state.strCommonKey, state.strCommonIV);
      final strDecryptedMData = decrypt(stringToDecrypt);

      setKey(state.strPrivateKey, state.strPrivateIV);
      strDecryptedData = decrypt(strDecryptedMData);
    } catch (e) {
      log('$e');
    }

    try {
      mapData = json.decode(strDecryptedData) as Map<String, dynamic>;
    } catch (e) {
      stringData = strDecryptedData;
    }

    final decrypted = DecryptedData(mapData: mapData, stringData: stringData);
    return getCleanedDecryptedData(decrypted);
  }

  DecryptedData getCleanedDecryptedData(DecryptedData decrypted) {
    String? cleanedString;
    Map<String, dynamic>? cleanedMap;

    String cleanString(String value) {
      String result = value;
      // Keep replacing until no more encoded entities remain (handles double encoding)
      while (result.contains('&amp;') /* ||
          result.contains('&lt;') ||
          result.contains('&gt;') ||
          result.contains('&quot;') */ ) {
        result = result.replaceAll('&amp;', ' & ')
        /* .replaceAll('&lt;', '')
            .replaceAll('&gt;', '')
            .replaceAll('&quot;', '"') */
        ;
      }
      return result;
    }

    // Recursively clean any value (String, Map, List)
    dynamic cleanValue(dynamic value) {
      if (value is String) {
        return cleanString(value);
      } else if (value is Map<String, dynamic>) {
        return value.map((k, v) => MapEntry(k, cleanValue(v)));
      } else if (value is List) {
        return value.map((item) => cleanValue(item)).toList();
      }
      return value;
    }

    if (decrypted.stringData != null) {
      cleanedString = cleanString(decrypted.stringData!);
    }

    if (decrypted.mapData != null) {
      cleanedMap = decrypted.mapData!.map(
        (key, value) => MapEntry(key, cleanValue(value)),
      );
    }

    return DecryptedData(
      mapData: cleanedMap ?? decrypted.mapData,
      stringData: cleanedString ?? decrypted.stringData,
    );
  }

  bool setKey(String keyString, String ivString) {
    if (keyString.length != 32) {
      return false;
    }
    if (ivString.length != 16) {
      return false;
    }
    state = state.copyWith(
      keyString: keyString,
      ivString: ivString,
    );

    return true;
  }

  String encrypt(String stplaintxt) {
    final key = Key(const Utf8Encoder().convert(state.keyString));
    final iv = IV(const Utf8Encoder().convert(state.ivString));

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(stplaintxt, iv: iv);

    return HEX.encode(encrypted.bytes).toUpperCase();
  }

  String decrypt(String stEncTxt) {
    final key = Key(const Utf8Encoder().convert(state.keyString));
    final iv = IV(const Utf8Encoder().convert(state.ivString));

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

    final encrypted = Encrypted(hexToBytes(stEncTxt));

    final decrypted = encrypter.decrypt(encrypted, iv: iv);

    return decrypted;
  }
}

Uint8List hexToBytes(String text) {
  final length = text.length;
  final data = Uint8List(length ~/ 2);

  for (var i = 0; i < length; i += 2) {
    final high = int.parse(text[i], radix: 16) << 4;
    final low = int.parse(text[i + 1], radix: 16);
    data[i ~/ 2] = (high + low).toUnsigned(8);
  }

  return data;
}

class DecryptedData {
  DecryptedData({this.mapData, this.stringData});
  final Map<String, dynamic>? mapData;
  final String? stringData;
}

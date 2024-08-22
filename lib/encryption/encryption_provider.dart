import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hex/hex.dart';
import 'package:sample/encryption/encryption_state.dart';

class EncryptionProvider extends StateNotifier<EncryptionState> {
  EncryptionProvider() : super(EncryptionInitial());

  void disposeState() => state = EncryptionInitial();

  void _setLoading() => state = EncryptionLoading(
        successMessage: '',
        errorMessage: '',
        keyString: '',
        ivString: '',
        strCommonKey: state.strCommonKey,
        strCommonIV: state.strCommonIV,
        strPrivateKey: state.strPrivateKey,
        strPrivateIV: state.strPrivateIV,
      );

  String getEncryptedData(String stringToEncrypt) {
    String strEncryptedData = "";
    try {
      // Encrypting for Data iteration 1
      setKey(state.strPrivateKey, state.strPrivateIV);
      print('length1 ${state.strPrivateKey.length}');
      print('length2 ${state.strPrivateIV.length}');
      print('length3 ${state.strCommonKey.length}');
      print('length4 ${state.strCommonIV.length}');

      String strData = encrypt(stringToEncrypt);
      // log('first iteration>>>>>$strData');
      // Encrypting for Data iteration 2
      setKey(state.strCommonKey, state.strCommonIV);
      strEncryptedData = encrypt(strData);
    } catch (e) {
      print('$e');
    }
    return strEncryptedData;
  }

  Map<String, dynamic> getDecryptedData(String String_to_Decrypt) {
    String strDecryptedData = "";
    try {
      setKey(state.strCommonKey, state.strCommonIV);
      String strDecryptedMData = decrypt(String_to_Decrypt);

      setKey(state.strPrivateKey, state.strPrivateIV);
      strDecryptedData = decrypt(strDecryptedMData);
    } catch (e) {
      print('$e');
    }
    final jsonResponse = json.decode(strDecryptedData);
    return jsonResponse as Map<String, dynamic>;
  }

  bool setKey(String _keyString, String _ivString) {
    if (_keyString.length != 32) {
      return false;
    }
    if (_ivString.length != 16) {
      return false;
    }
    state = state.copyWith(
      keyString: _keyString,
      ivString: _ivString,
    );

    return true;
  }

  String encrypt(String stplaintxt) {
    final key = Key(const Utf8Encoder().convert(state.keyString));
    final iv = IV(const Utf8Encoder().convert(state.ivString));

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
    final encrypted = encrypter.encrypt(stplaintxt, iv: iv);

    return HEX.encode(encrypted.bytes).toUpperCase();
  }

  String decrypt(String stEncTxt) {
    final key = Key(const Utf8Encoder().convert(state.keyString));
    final iv = IV(const Utf8Encoder().convert(state.ivString));

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));

    final encrypted = Encrypted(hexToBytes(stEncTxt));

    final decrypted = encrypter.decrypt((encrypted), iv: iv);

    return decrypted;
  }
}

Uint8List hexToBytes(String text) {
  final length = text.length;
  final data = Uint8List(length ~/ 2);

  for (int i = 0; i < length; i += 2) {
    final high = int.parse(text[i], radix: 16) << 4;
    final low = int.parse(text[i + 1], radix: 16);
    data[i ~/ 2] = (high + low).toUnsigned(8);
  }

  return data;
}

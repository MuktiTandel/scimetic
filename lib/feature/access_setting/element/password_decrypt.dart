import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class Encryption {
   static final Encryption instance = Encryption._();

  late IV _iv;
  late Encrypter _encrypter;

   final key = Key.fromUtf8('my 32 length key................');
   final iv = IV.fromLength(16);

  Encryption._() {
    const mykey = 'scimeticEncryptedKey';
    const myiv = 'scimeticEncryptedKey';
    final keyUtf8 = utf8.encode(mykey);
    final ivUtf8 = utf8.encode(myiv);
    final key = sha256.convert(keyUtf8).toString().substring(0, 32);
    final iv = sha256.convert(ivUtf8).toString().substring(0, 16);
    _iv = IV.fromUtf8(iv);

    _encrypter = Encrypter(AES(Key.fromBase16(key), padding: null));
  }

  String encrypt(String value) {
    return _encrypter.encrypt(value, iv: _iv).base64;
  }

  String decrypt(String base64value) {
    final encrypted = Encrypted.fromBase64(base64value);
    return _encrypter.decrypt(encrypted, iv: _iv);
  }

   String decryptPassword(String encryptedPassword, String key) {
     final iv = IV.fromLength(16);
     final encrypter = Encrypter(AES(Key.fromUtf8(key), mode: AESMode.cbc));
     final decrypted = encrypter.decrypt64(encryptedPassword, iv: iv);

     return decrypted;
   }

   String decryptedPassword(String encryptedText) {
     final key = Key.fromLength(16);
     final iv = IV.fromLength(16);
     final encrypter = Encrypter(AES(key, padding: null));

     final encryptedData = Encrypted.fromBase64(encryptedText);
     final decrypted = encrypter.decrypt(encryptedData, iv: iv);

     final decryptedText = decrypted.toString();

     return decryptedText;
   }

    // password() {
    //   final encryptedString = "U2FsdGVkX190MUODKzac4/DW4UkVaolbvH3jShbRvag=";
    //
    //   final key = "scimeticEncryptedKey";
    //
    //   final iv = IV.fromLength(16);
    //
    //   final encrypter = Encrypter(AES(Key.fromBase64(key)));
    //
    //   final decrypted = encrypter.decrypt64(encryptedString, iv: iv);
    //
    //   AppConst().debug("decrypted string => $decrypted");
    // }

}

class EncryptData{
//for AES Algorithms

  static Encrypted? encrypted;
  static var decrypted = "";


  static encryptAES(plainText){
    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    encrypted = encrypter.encrypt(plainText, iv: iv);
  }

  static decryptAES(plainText){
    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key, padding: null));
    decrypted = encrypter.decrypt(Encrypted.fromBase64(plainText), iv: iv);
    return decrypted;
  }


}

String decryptString(String encryptedString, String key) {
  final encryptedBytes = encrypt.Encrypted.fromBase64(encryptedString);
  dynamic keyBytes = utf8.encode(key);
  final iv = encrypt.IV.fromLength(16);

  final encrypter = encrypt.Encrypter(encrypt.AES(keyBytes));

  final decrypted = encrypter.decrypt(encryptedBytes, iv: iv);

  return decrypted;
}

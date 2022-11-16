import 'dart:convert';
import 'dart:typed_data';

import 'package:at_chops/src/algorithm/default_encryption_algo.dart';
import 'package:at_chops/src/algorithm/default_signing_algo.dart';
import 'package:at_chops/src/at_chops_impl.dart';
import 'package:at_chops/src/key/impl/aes_key.dart';
import 'package:at_chops/src/util/at_chops_util.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests for encryption and decryption', () {
    test('Test symmetric encrypt/decrypt bytes with initialisation vector', () {
      String data = 'Hello World';
      final atChops = AtChopsImpl();
      AESKey aesKey = AESKey.generate(32);
      final iv = AtChopsUtil.generateIV(16);
      final algo = DefaultEncryptionAlgo(aesKey);
      final encryptedBytes =
          atChops.encryptBytes(utf8.encode(data) as Uint8List, algo, iv: iv);
      final decryptedBytes = atChops.decryptBytes(encryptedBytes, algo, iv: iv);
      expect(utf8.decode(decryptedBytes), data);
    });
    test('Test symmetric encrypt/decrypt bytes with emoji char', () {
      String data = 'Hello World🛠';
      final atChops = AtChopsImpl();
      AESKey aesKey = AESKey.generate(32);
      final iv = AtChopsUtil.generateIV(16);
      final algo = DefaultEncryptionAlgo(aesKey);
      final encryptedBytes =
          atChops.encryptBytes(utf8.encode(data) as Uint8List, algo, iv: iv);
      final decryptedBytes = atChops.decryptBytes(encryptedBytes, algo, iv: iv);
      expect(utf8.decode(decryptedBytes), data);
    });

    test('Test symmetric encrypt/decrypt bytes with special chars', () {
      String data = 'Hello World🛠';
      final atChops = AtChopsImpl();
      AESKey aesKey = AESKey.generate(32);
      final iv = AtChopsUtil.generateIV(16);
      final algo = DefaultEncryptionAlgo(aesKey);
      final encryptedBytes =
          atChops.encryptBytes(utf8.encode(data) as Uint8List, algo, iv: iv);
      final decryptedBytes = atChops.decryptBytes(encryptedBytes, algo, iv: iv);
      expect(utf8.decode(decryptedBytes), data);
    });
    test('Test symmetric encrypt/decrypt string with initialisation vector',
        () {
      String data = 'Hello World';
      final atChops = AtChopsImpl();
      AESKey aesKey = AESKey.generate(32);
      final iv = AtChopsUtil.generateIV(16);
      final algo = DefaultEncryptionAlgo(aesKey);
      final encryptedString = atChops.encryptString(data, algo, iv: iv);
      final decryptedString =
          atChops.decryptString(encryptedString, algo, iv: iv);
      expect(decryptedString, data);
    });
    test('Test symmetric encrypt/decrypt string with special chars', () {
      String data = 'Hello``*+%';
      final atChops = AtChopsImpl();
      AESKey aesKey = AESKey.generate(32);
      final iv = AtChopsUtil.generateIV(16);
      final algo = DefaultEncryptionAlgo(aesKey);
      final encryptedString = atChops.encryptString(data, algo, iv: iv);
      final decryptedString =
          atChops.decryptString(encryptedString, algo, iv: iv);
      expect(decryptedString, data);
    });
    test('Test symmetric encrypt/decrypt string with emoji', () {
      String data = 'Hello World🛠';
      final atChops = AtChopsImpl();
      AESKey aesKey = AESKey.generate(32);
      final iv = AtChopsUtil.generateIV(16);
      final algo = DefaultEncryptionAlgo(aesKey);
      final encryptedString = atChops.encryptString(data, algo, iv: iv);
      final decryptedString =
          atChops.decryptString(encryptedString, algo, iv: iv);
      expect(decryptedString, data);
    });
  });
  group('A group of tests for data signing and verification', () {
    // test('Test data signing and verification', () {
    //   String data = 'Hello World';
    //   final atChops = AtChopsImpl();
    //   final atSigningKeyPair = AtChopsUtil.generateSigningKeyPair();
    //   final algo = DefaultSigningAlgo(atSigningKeyPair);
    //   final signature = atChops.sign(Uint8List.fromList(data.codeUnits), algo);
    //   final result =
    //       atChops.verify(Uint8List.fromList(data.codeUnits), signature, algo);
    //   expect(result, true);
    // });
    // test('Test data signing and verification - emoji char', () {
    //   String data = 'Hello World🛠';
    //   final atChops = AtChopsImpl();
    //   final atSigningKeyPair = AtChopsUtil.generateSigningKeyPair();
    //   final algo = DefaultSigningAlgo(atSigningKeyPair);
    //   final signature = atChops.sign(Uint8List.fromList(data.codeUnits), algo);
    //   final result =
    //       atChops.verify(Uint8List.fromList(data.codeUnits), signature, algo);
    //   expect(result, true);
    // });
    // test('Test data signing and verification - special char', () {
    //   String data = 'Hello\' World!*``';
    //   final atChops = AtChopsImpl();
    //   final atSigningKeyPair = AtChopsUtil.generateSigningKeyPair();
    //   final algo = DefaultSigningAlgo(atSigningKeyPair);
    //   final signature = atChops.sign(Uint8List.fromList(data.codeUnits), algo);
    //   final result =
    //       atChops.verify(Uint8List.fromList(data.codeUnits), signature, algo);
    //   expect(result, true);
    // });
  });
}

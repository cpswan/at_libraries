import 'dart:typed_data';

import 'package:at_chops/src/algorithm/at_algorithm.dart';
import 'package:at_chops/src/algorithm/at_iv.dart';
import 'package:at_chops/src/algorithm/default_encryption_algo.dart';
import 'package:at_chops/src/algorithm/default_hashing_algo.dart';
import 'package:at_chops/src/algorithm/default_signing_algo.dart';
import 'package:at_chops/src/algorithm/pkam_signing_algo.dart';
import 'package:at_chops/src/key/impl/at_chops_keys.dart';
import 'package:at_chops/src/key/key_type.dart';
import 'package:at_chops/src/metadata/at_signing_input.dart';
import 'package:at_chops/src/metadata/encryption_result.dart';
import 'package:at_chops/src/metadata/signing_result.dart';

/// Base class for all Cryptographic and Hashing Operations. Callers have to either implement
/// specific encryption, signing or hashing algorithms. Otherwise default implementation of specific algorithms will be used.
abstract class AtChops {
  final AtChopsKeys _atChopsKeys;

  AtChopsKeys get atChopsKeys => _atChopsKeys;

  AtChops(this._atChopsKeys);

  /// Encrypts the input bytes [data] using an [encryptionAlgorithm] and returns [AtEncryptionResult].
  /// If [encryptionKeyType] is [EncryptionKeyType.rsa2048] then [encryptionAlgorithm] will be set to [DefaultEncryptionAlgo]
  /// [keyName] specifies which key pair to use if user has multiple key pairs configured.
  /// If [keyName] is not passed default encryption/decryption keypair from .atKeys file will be used.
  AtEncryptionResult encryptBytes(
      Uint8List data, EncryptionKeyType encryptionKeyType,
      {AtEncryptionAlgorithm? encryptionAlgorithm,
      String? keyName,
      InitialisationVector? iv});

  /// Encrypts the input string [data] using an [encryptionAlgorithm] and returns [AtEncryptionResult].
  /// If [encryptionKeyType] is [EncryptionKeyType.rsa2048] then [encryptionAlgorithm] will be set to [DefaultEncryptionAlgo]
  /// [keyName] specifies which key pair to use if user has multiple key pairs configured.
  /// If [keyName] is not passed default encryption/decryption keypair from .atKeys file will be used.
  AtEncryptionResult encryptString(
      String data, EncryptionKeyType encryptionKeyType,
      {AtEncryptionAlgorithm? encryptionAlgorithm,
      String? keyName,
      InitialisationVector? iv});

  /// Decrypts the input bytes [data] using an [encryptionAlgorithm] and returns [AtEncryptionResult].
  /// If [encryptionKeyType] is [EncryptionKeyType.rsa2048] then [encryptionAlgorithm] will be set to [DefaultEncryptionAlgo]
  /// [keyName] specifies which key pair to use if user has multiple key pairs configured.
  /// If [keyName] is not passed default encryption/decryption keypair from .atKeys file will be used.
  AtEncryptionResult decryptBytes(
      Uint8List data, EncryptionKeyType encryptionKeyType,
      {AtEncryptionAlgorithm? encryptionAlgorithm,
      String? keyName,
      InitialisationVector? iv});

  /// Decrypts the input string [data] using an [encryptionAlgorithm] and returns [AtEncryptionResult].
  /// If [encryptionKeyType] is [EncryptionKeyType.rsa2048] then [encryptionAlgorithm] will be set to [DefaultEncryptionAlgo]
  /// [keyName] specifies which key pair to use if user has multiple key pairs configured.
  /// If [keyName] is not passed default encryption/decryption keypair from .atKeys file will be used.
  AtEncryptionResult decryptString(
      String data, EncryptionKeyType encryptionKeyType,
      {AtEncryptionAlgorithm? encryptionAlgorithm,
      String? keyName,
      InitialisationVector? iv});

  /// Sign the input bytes [data] using a [signingAlgorithm].
  /// If [signingKeyType] is [SigningKeyType.pkamSha256] then [signingAlgorithm] will be set to [PkamSigningAlgo]
  /// If [signingKeyType] is [SigningKeyType.signingSha256] then [signingAlgorithm] will be set to [DefaultSigningAlgo]
  AtSigningResult signBytes(Uint8List data, SigningKeyType signingKeyType,
      {AtSigningAlgorithm? signingAlgorithm});

  /// Verify the [signature] of bytes [data] using a [signingAlgorithm]
  /// If [signingKeyType] is [SigningKeyType.pkamSha256] then [signingAlgorithm] will be set to [PkamSigningAlgo]
  /// If [signingKeyType] is [SigningKeyType.signingSha256] then [signingAlgorithm] will be set to [DefaultSigningAlgo]
  AtSigningResult verifySignatureBytes(
      Uint8List data, Uint8List signature, SigningKeyType signingKeyType,
      {AtSigningAlgorithm? signingAlgorithm});

  /// Sign the input string [data] using a [signingAlgorithm].
  /// If [signingKeyType] is [SigningKeyType.pkamSha256] then [signingAlgorithm] will be set to [PkamSigningAlgo]
  /// If [signingKeyType] is [SigningKeyType.signingSha256] then [signingAlgorithm] will be set to [DefaultSigningAlgo]
  @Deprecated('Use sign() instead')
  AtSigningResult signString(String data, SigningKeyType signingKeyType,
      {AtSigningAlgorithm? signingAlgorithm});

  /// Verify the [signature] of string [data] using a [signingAlgorithm]
  /// If [signingKeyType] is [SigningKeyType.pkamSha256] then [signingAlgorithm] will be set to [PkamSigningAlgo]
  /// If [signingKeyType] is [SigningKeyType.signingSha256] then [signingAlgorithm] will be set to [DefaultSigningAlgo]
  @Deprecated('Use verify() instead')
  AtSigningResult verifySignatureString(
      String data, String signature, SigningKeyType signingKeyType,
      {AtSigningAlgorithm? signingAlgorithm});

  ///Generate data signature
  ///Inputs need to passed through [AtSigningInput]
  ///Please refer to [AtSigningInput] docs to create a valid input instance
  AtSigningResult sign(AtSigningInput signingInput);

  ///Verifies data with a valid signature
  ///Inputs need to passed through [AtSigningVerificationInput]
  ///Please refer to [AtSigningVerificationInput] docs to create a valid input instance
  AtSigningResult verify(AtSigningVerificationInput verifyInput);

  /// Create a string hash of input [signedData] using a [hashingAlgorithm].
  /// Refer to [DefaultHash] for default implementation of hashing.
  String hash(Uint8List signedData, AtHashingAlgorithm hashingAlgorithm);
}

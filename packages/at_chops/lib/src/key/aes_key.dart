import 'package:at_chops/src/key/at_encryption_key.dart';

/// Represents an AES key for symmetric encryption.
class AESKey extends AtEncryptionKey {
  late String _aesKey;
  AESKey(this._aesKey);
  String get key => _aesKey;

  @override
  String toString() {
    return _aesKey;
  }
}

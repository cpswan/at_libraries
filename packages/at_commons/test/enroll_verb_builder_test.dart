import 'package:at_commons/src/verb/enroll_verb_builder.dart';
import 'package:at_commons/src/verb/operation_enum.dart';
import 'package:test/test.dart';

void main() {
  group('A group of enroll verb builder test', () {
    test('A test to verify enroll request', () {
      var enrollVerbBuilder = EnrollVerbBuilder()
        ..operation = EnrollOperationEnum.request
        ..appName = 'wavi'
        ..deviceName = 'pixel'
        ..namespaces = {'wavi': 'rw', '__manage': 'r'}
        ..apkamPublicKey = 'abcd1234'
        ..enrollmentId = '1234'
        ..encryptedAPKAMSymmetricKey = 'dummy_pkam_sym_key'
        ..encryptedDefaultEncryptedPrivateKey = 'dummy_encrypted_private_key'
        ..encryptedDefaultSelfEncryptionKey = 'dummy_self_encryption_key';
      var command = enrollVerbBuilder.buildCommand();
      expect(command,
          'enroll:request:{"enrollmentId":"1234","appName":"wavi","deviceName":"pixel","namespaces":{"wavi":"rw","__manage":"r"},"encryptedDefaultEncryptedPrivateKey":"dummy_encrypted_private_key","encryptedDefaultSelfEncryptionKey":"dummy_self_encryption_key","encryptedAPKAMSymmetricKey":"dummy_pkam_sym_key","apkamPublicKey":"abcd1234"}\n');
    });

    test('A test to verify enroll approve operation', () {
      var enrollVerbBuilder = EnrollVerbBuilder()
        ..operation = EnrollOperationEnum.approve
        ..enrollmentId = '123'
        ..appName = 'wavi'
        ..deviceName = 'pixel'
        ..namespaces = {'wavi': 'rw'}
        ..apkamPublicKey = 'abcd1234'
        ..encryptedAPKAMSymmetricKey = 'dummy_pkam_sym_key'
        ..encryptedDefaultEncryptedPrivateKey = 'dummy_encrypted_private_key'
        ..encryptedDefaultSelfEncryptionKey = 'dummy_self_encryption_key';
      var command = enrollVerbBuilder.buildCommand();
      expect(command,
          'enroll:approve:{"enrollmentId":"123","appName":"wavi","deviceName":"pixel","namespaces":{"wavi":"rw"},"encryptedDefaultEncryptedPrivateKey":"dummy_encrypted_private_key","encryptedDefaultSelfEncryptionKey":"dummy_self_encryption_key","encryptedAPKAMSymmetricKey":"dummy_pkam_sym_key","apkamPublicKey":"abcd1234"}\n');
    });

    test('A test to verify enroll deny operation', () {
      var enrollVerbBuilder = EnrollVerbBuilder()
        ..operation = EnrollOperationEnum.deny
        ..enrollmentId = '123';
      var command = enrollVerbBuilder.buildCommand();
      expect(command, 'enroll:deny:{"enrollmentId":"123"}\n');
    });

    test('A test to verify enroll revoke operation', () {
      var enrollVerbBuilder = EnrollVerbBuilder()
        ..operation = EnrollOperationEnum.revoke
        ..enrollmentId = '123';
      var command = enrollVerbBuilder.buildCommand();
      expect(command, 'enroll:revoke:{"enrollmentId":"123"}\n');
    });

    test('A test to verify enroll list operation', () {
      var enrollVerbBuilder = EnrollVerbBuilder()
        ..operation = EnrollOperationEnum.list;
      var command = enrollVerbBuilder.buildCommand();
      expect(command, 'enroll:list\n');
    });
  });
}

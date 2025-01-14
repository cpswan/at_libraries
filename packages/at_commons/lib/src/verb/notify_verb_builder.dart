import 'package:uuid/uuid.dart';

import '../at_constants.dart';
import 'metadata_using_verb_builder.dart';
import 'operation_enum.dart';
import 'verb_util.dart';

class NotifyVerbBuilder extends MetadataUsingVerbBuilder {
  /// id for each notification.
  String id = Uuid().v4();

  /// Value of the key typically in string format. Images, files, etc.,
  /// must be converted to unicode string before storing.
  dynamic value;

  /// time in milliseconds after which a notification expires.
  int? ttln;

  OperationEnum? operation;

  /// priority of the notification
  PriorityEnum? priority;

  /// strategy in processing the notification
  StrategyEnum? strategy;

  /// type of notification
  MessageTypeEnum? messageType;

  /// The notifier of the notification. Defaults to system.
  String notifier = SYSTEM;

  /// Latest N notifications to notify. Defaults to 1
  int? latestN;

  @override
  String buildCommand() {
    StringBuffer sb = StringBuffer();
    sb.write('notify:id:$id');

    if (operation != null) {
      sb.write(':${getOperationName(operation)}');
    }
    if (messageType != null) {
      sb.write(':messageType:${getMessageType(messageType)}');
    }
    if (priority != null) {
      sb.write(':priority:${getPriority(priority)}');
    }
    if (strategy != null) {
      sb.write(':strategy:${getStrategy(strategy)}');
    }
    if (latestN != null) {
      sb.write(':latestN:$latestN');
    }
    sb.write(':notifier:$notifier');
    if (ttln != null) {
      sb.write(':ttln:$ttln');
    }

    // Add in all of the metadata parameters in atProtocol command format
    sb.write(metadata.toAtProtocolFragment());

    if (sharedWith != null) {
      sb.write(':${VerbUtil.formatAtSign(sharedWith)}');
    }

    if (isPublic) {
      sb.write(':public');
    }
    sb.write(':${atKey!}');

    if (sharedBy != null) {
      sb.write('${VerbUtil.formatAtSign(sharedBy)}');
    }
    if (value != null) {
      sb.write(':$value');
    }

    sb.write('\n');

    return sb.toString();
  }

  @override
  bool checkParams() {
    var isValid = true;
    if ((atKey == null) || (isPublic == true && sharedWith != null)) {
      isValid = false;
    }
    return isValid;
  }
}

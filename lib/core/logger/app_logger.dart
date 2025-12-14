import 'package:flutter/foundation.dart';
import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init(
  settings: TalkerSettings(
    enabled: kDebugMode,
    useHistory: kDebugMode,
    maxHistoryItems: 500,
    useConsoleLogs: kDebugMode,
  ),
  logger: TalkerLogger(
    output: debugPrint,
    settings: TalkerLoggerSettings(
      enableColors: true,
      maxLineWidth: 120,
    ),
  ),
);

/// Custom log type for success messages (green colored)
class GoodLog extends TalkerLog {
  GoodLog(String message) : super(message);

  @override
  String get title => 'good';

  @override
  AnsiPen get pen => AnsiPen()..green();
}

/// Extension to add `good()` method for success logging
extension TalkerGoodExtension on Talker {
  /// Log a success message with green color
  void good(String message) {
    logTyped(GoodLog(message));
  }
}

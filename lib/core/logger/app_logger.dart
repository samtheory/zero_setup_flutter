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
    settings:  TalkerLoggerSettings(
      enableColors: true,
      maxLineWidth: 120,
    ),
  ),
);

import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

import 'app_logger.dart';

/// Riverpod Observer برای لاگ کردن state changes
final talkerRiverpodObserver = TalkerRiverpodObserver(
  talker: talker,
  settings: const TalkerRiverpodLoggerSettings(
    enabled: true,
    printStateFullData: false,
    printProviderAdded: true,
    printProviderDisposed: true,
    printProviderUpdated: true,
    printProviderFailed: true,
  ),
);

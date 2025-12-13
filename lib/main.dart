import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zero_setup_flutter/app/app.dart';
import 'package:zero_setup_flutter/core/logger/logger_provider.dart';
import 'package:zero_setup_flutter/core/providers/core_providers.dart';
import 'package:zero_setup_flutter/core/storage/preferences_service.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferencesService = PreferencesService();
  await preferencesService.init();

  runApp(
    ProviderScope(
      observers: [talkerRiverpodObserver],
      overrides: [
        preferencesServiceProvider.overrideWithValue(preferencesService),
      ],
      child: const App(),
    ),
  );
}
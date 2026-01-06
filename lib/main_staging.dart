import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zero_setup_flutter/app/config/env/env_staging.dart';
import 'package:zero_setup_flutter/app/bootstrap/bootstrap.dart';
import 'package:zero_setup_flutter/app/app.dart';
import 'package:zero_setup_flutter/core/logger/logger_provider.dart';
import 'package:zero_setup_flutter/core/providers/core_providers.dart';

void main() async {
  // Initialize app with Staging environment
  final bootstrapData = await Bootstrap.initialize(environment: EnvStaging());

  runApp(
    ProviderScope(
      observers: [talkerRiverpodObserver],
      overrides: [
        preferencesServiceProvider.overrideWithValue(bootstrapData.preferencesService),
        secureStorageProvider.overrideWithValue(bootstrapData.secureStorage),
      ],
      child: const App(),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zero_setup_flutter/app/config/env/env_prod.dart';
import 'package:zero_setup_flutter/app/bootstrap/bootstrap.dart';
import 'package:zero_setup_flutter/app/app.dart';
import 'package:zero_setup_flutter/core/logger/logger_provider.dart';
import 'package:zero_setup_flutter/core/providers/core_providers.dart';

void main() async {
  // Initialize app with Production environment
  final bootstrapData = await Bootstrap.initialize(environment: EnvProd());

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

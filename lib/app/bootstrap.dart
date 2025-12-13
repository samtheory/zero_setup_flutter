// lib/app/bootstrap.dart

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:zero_setup_flutter/app/app.dart';
import 'package:zero_setup_flutter/core/storage/storage_provider.dart';
import 'package:zero_setup_flutter/core/storage/storage_service_impl.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Storage
  final storageService = StorageServiceImpl();
  await storageService.init();

  // Initialize Talker
  final talker = TalkerFlutter.init();

  // Initialize Dio
  // final dio = createDioClient(talker, storageService);

  runApp(
    ProviderScope(
      overrides: [
        storageServiceProvider.overrideWithValue(storageService),
        // talkerProvider.overrideWithValue(talker),
        // dioProvider.overrideWithValue(dio),
      ],
      child: const App(),
    ),
  );
}

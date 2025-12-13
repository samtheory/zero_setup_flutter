import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../logger/app_logger.dart';
import '../network/dio_client.dart';
import '../storage/preferences_service.dart';
import '../storage/secure_storage_service.dart';

// ═══════════════════════════════════════════════════════════════
// Logger Provider
// ═══════════════════════════════════════════════════════════════

final talkerProvider = Provider<Talker>((ref) => talker);

// ═══════════════════════════════════════════════════════════════
// Storage Providers
// ═══════════════════════════════════════════════════════════════

final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

final preferencesServiceProvider = Provider<PreferencesService>((ref) {
  return PreferencesService();
});

// ═══════════════════════════════════════════════════════════════
// Network Providers
// ═══════════════════════════════════════════════════════════════

final dioClientProvider = Provider<DioClient>((ref) {
  final storage = ref.watch(secureStorageProvider);
  return DioClient(storage);
});

final dioProvider = Provider<Dio>((ref) {
  return ref.watch(dioClientProvider).dio;
});

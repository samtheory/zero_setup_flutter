import 'package:zero_setup_flutter/core/storage/secure_storage_service.dart';

import '../../../../core/logger/app_logger.dart';

import '../repositories/user_repository.dart';

/// UseCase: Logout user
///
/// UseCases encapsulate a single business operation.
/// They orchestrate multiple repositories/services if needed.
///
/// Benefits:
/// - Single responsibility
/// - Reusable across different UI components
/// - Easy to test
/// - Clear business logic separation
class LogoutUseCase {
  final UserRepository _userRepository;
  final SecureStorageService _secureStorage;

  LogoutUseCase(this._userRepository, this._secureStorage);

  /// Execute logout:
  /// 1. Call server to invalidate token
  /// 2. Clear local secure storage
  Future<void> call() async {
    talker.info('LogoutUseCase: Starting logout process');

    try {
      // Step 1: Server-side logout (optional - may fail if token expired)
      await _userRepository.logout();
    } catch (e) {
      talker.warning('LogoutUseCase: Server logout failed (continuing anyway)', e);
    }

    // Step 2: Always clear local storage
    await _secureStorage.clearAll();

    talker.good('LogoutUseCase: Logout completed');
  }
}

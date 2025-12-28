import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/logger/app_logger.dart';
import '../../../../core/providers/core_providers.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../data/services/user_api_service.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/logout_usecase.dart';
import 'user_state.dart';

// ═══════════════════════════════════════════════════════════════════════════
// DEPENDENCY PROVIDERS (Infrastructure layer)
// ═══════════════════════════════════════════════════════════════════════════

/// API Service provider
final userApiServiceProvider = Provider<UserApiService>((ref) {
  final dio = ref.watch(dioProvider);
  talker.debug('Creating UserApiService');
  return UserApiService(dio);
});

/// Repository provider
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final apiService = ref.watch(userApiServiceProvider);
  return UserRepositoryImpl(apiService);
});

/// UseCase provider
final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  final secureStorage = ref.watch(secureStorageProvider);
  return LogoutUseCase(repository, secureStorage);
});

// ═══════════════════════════════════════════════════════════════════════════
// ASYNC NOTIFIER (Controller with async state)
//
// This is your "Controller" - it contains:
// - Current state wrapped in AsyncValue (loading/error/data)
// - All actions the user can perform
//
// Pattern: AsyncNotifier<State> = Auto-load + Actions
// Benefits:
// - Auto-loads data when first watched (no useEffect needed)
// - Built-in loading/error states via AsyncValue
// - ref.invalidate() to refresh
// ═══════════════════════════════════════════════════════════════════════════

class UserNotifier extends AsyncNotifier<UserState> {
  // Use getters instead of late final to avoid re-initialization error
  UserRepository get _repository => ref.read(userRepositoryProvider);
  LogoutUseCase get _logoutUseCase => ref.read(logoutUseCaseProvider);

  @override
  Future<UserState> build() async {
    // Auto-load user on first watch
    talker.info('UserNotifier: Auto-loading user');
    final user = await _repository.getCurrentUser();
    talker.good('UserNotifier: User loaded - ${user.name}');

    return UserState(user: user);
  }

  // ═══════════════════════════════════════════════════════════════════════
  // ACTIONS (Methods that modify state)
  // ═══════════════════════════════════════════════════════════════════════

  /// Refresh user data (pull-to-refresh)
  Future<void> refresh() async {
    talker.info('UserNotifier: Refreshing user');
    ref.invalidateSelf();
  }

  /// Update user profile
  Future<bool> updateProfile(UpdateUserRequest request) async {
    final currentState = state.asData?.value;
    if (currentState == null || currentState.isUpdating) return false;

    // Set updating flag
    state = AsyncData(currentState.copyWith(isUpdating: true, actionError: null));

    try {
      final updatedUser = await _repository.updateUser(request);

      // Merge only specific fields from response into existing user
      // final mergedUser = currentState.user.copyWith(name: updatedUser.name, phone: updatedUser.phone);

      state = AsyncData(currentState.copyWith(user: updatedUser, isUpdating: false));
      talker.good('UserNotifier: Profile updated');
      return true;
    } catch (e) {
      talker.error('UserNotifier: Failed to update profile', e);
      state = AsyncData(currentState.copyWith(isUpdating: false, actionError: 'Failed to update profile'));
      return false;
    }
  }

  /// Logout user
  Future<bool> logout() async {
    final currentState = state.asData?.value;
    if (currentState == null || currentState.isLoggingOut) return false;

    // Set logging out flag
    state = AsyncData(currentState.copyWith(isLoggingOut: true, actionError: null));

    try {
      await _logoutUseCase.call();
      talker.good('UserNotifier: Logged out successfully');
      // Don't update state - navigation will happen and provider will be disposed
      return true;
    } catch (e) {
      talker.error('UserNotifier: Failed to logout', e);
      state = AsyncData(currentState.copyWith(isLoggingOut: false, actionError: 'Failed to logout'));
      return false;
    }
  }

  /// Clear action error
  void clearActionError() {
    final currentState = state.asData?.value;
    if (currentState != null) {
      state = AsyncData(currentState.copyWith(actionError: null));
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN PROVIDER
// ═══════════════════════════════════════════════════════════════════════════

final userProvider = AsyncNotifierProvider.autoDispose<UserNotifier, UserState>(UserNotifier.new);

// ═══════════════════════════════════════════════════════════════════════════
// SELECTOR PROVIDERS (Optional - for fine-grained rebuilds)
// ═══════════════════════════════════════════════════════════════════════════

/// Watch only user data (rebuilds only when user changes)
final currentUserProvider = Provider<UserModel?>((ref) {
  return ref.watch(userProvider).asData?.value.user;
});

/// Watch only loading state (initial load)
final isUserLoadingProvider = Provider<bool>((ref) {
  return ref.watch(userProvider).isLoading;
});

/// Watch if user data is available
final hasUserDataProvider = Provider<bool>((ref) {
  return ref.watch(userProvider).hasValue;
});

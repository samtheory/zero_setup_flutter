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
// NOTIFIER (Controller)
// 
// This is your "Controller" - it contains:
// - Current state (UserState)
// - All actions the user can perform
// 
// Pattern: Notifier<State> = State + Actions combined
// ═══════════════════════════════════════════════════════════════════════════

class UserNotifier extends Notifier<UserState> {
  late final UserRepository _repository;
  late final LogoutUseCase _logoutUseCase;

  @override
  UserState build() {
    // Inject dependencies in build() method
    _repository = ref.watch(userRepositoryProvider);
    _logoutUseCase = ref.watch(logoutUseCaseProvider);
    return const UserState();
  }

  // ═══════════════════════════════════════════════════════════════════════
  // ACTIONS (Methods that modify state)
  // ═══════════════════════════════════════════════════════════════════════

  /// Load current user profile
  Future<void> loadUser() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = await _repository.getCurrentUser();
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      talker.error('Failed to load user', e);
      state = state.copyWith(isLoading: false, error: 'Failed to load profile');
    }
  }

  /// Update user profile
  Future<bool> updateProfile(UpdateUserRequest request) async {
    if (state.isUpdating) return false;

    state = state.copyWith(isUpdating: true, error: null);

    try {
      final user = await _repository.updateUser(request);
      state = state.copyWith(user: user, isUpdating: false);
      return true;
    } catch (e) {
      talker.error('Failed to update user', e);
      state = state.copyWith(isUpdating: false, error: 'Failed to update profile');
      return false;
    }
  }

  /// Logout user
  Future<void> logout() async {
    if (state.isLoggingOut) return;

    state = state.copyWith(isLoggingOut: true, error: null);

    try {
      await _logoutUseCase.call();
      state = const UserState(); // Reset to initial state
    } catch (e) {
      talker.error('Failed to logout', e);
      state = state.copyWith(isLoggingOut: false, error: 'Failed to logout');
    }
  }

  /// Clear any error
  void clearError() {
    state = state.copyWith(error: null);
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN PROVIDER
// ═══════════════════════════════════════════════════════════════════════════

final userProvider = NotifierProvider<UserNotifier, UserState>(UserNotifier.new);

// ═══════════════════════════════════════════════════════════════════════════
// SELECTOR PROVIDERS (Optional - for fine-grained rebuilds)
// ═══════════════════════════════════════════════════════════════════════════

/// Watch only user data (rebuilds only when user changes)
final currentUserProvider = Provider<UserModel?>((ref) {
  return ref.watch(userProvider.select((state) => state.user));
});

/// Watch only loading state
final isUserLoadingProvider = Provider<bool>((ref) {
  return ref.watch(userProvider.select((state) => state.isLoading));
});

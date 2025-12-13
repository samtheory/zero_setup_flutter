// ⭐ (قلب سیستم)

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';

import '../entities/user.dart';

/// وضعیت احراز هویت
class AuthState {
  final User? user;
  final bool isLoading;

  const AuthState({this.user, this.isLoading = false});

  bool get isAuthenticated => user != null;

  AuthState copyWith({User? user, bool? isLoading, bool clearUser = false}) {
    return AuthState(user: clearUser ? null : (user ?? this.user), isLoading: isLoading ?? this.isLoading);
  }
}

/// Auth Notifier - مدیریت Login/Logout
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  /// Fake Login - فقط برای تست
  Future<void> login() async {
    state = state.copyWith(isLoading: true);

    // شبیه‌سازی delay شبکه
    await Future.delayed(const Duration(seconds: 1));

    state = AuthState(user: User.fake(), isLoading: false);
  }

  /// Logout
  Future<void> logout() async {
    state = state.copyWith(isLoading: true);

    await Future.delayed(const Duration(milliseconds: 500));

    state = const AuthState();
  }
}

/// Provider اصلی Auth
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

/// Provider ساده برای چک کردن وضعیت Login
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isAuthenticated;
});

/// Provider برای دسترسی به User فعلی
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authProvider).user;
});

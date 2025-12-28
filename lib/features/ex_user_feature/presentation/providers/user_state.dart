import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/user_model.dart';

part 'user_state.freezed.dart';

/// User profile state
///
/// This is a pure DATA class - it only holds state, no logic.
/// All state mutations happen in the Notifier (controller).
@freezed
sealed class UserState with _$UserState {
  const factory UserState({
    /// Current user data (null if not loaded)
    UserModel? user,

    /// Loading states for different operations
    @Default(false) bool isLoading,
    @Default(false) bool isUpdating,
    @Default(false) bool isLoggingOut,

    /// Error message (null if no error)
    String? error,
  }) = _UserState;

  const UserState._();

  // ═══════════════════════════════════════════════════════════════════════
  // Computed properties (derived from state)
  // ═══════════════════════════════════════════════════════════════════════

  /// Whether user data is available
  bool get hasUser => user != null;

  /// Whether any operation is in progress
  bool get isBusy => isLoading || isUpdating || isLoggingOut;

  /// Whether there's an error
  bool get hasError => error != null;
}

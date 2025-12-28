import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/user_model.dart';

part 'user_state.freezed.dart';

/// User profile state for AsyncNotifier
///
/// Note: Main loading/error is handled by AsyncValue wrapper.
/// This state only tracks action-specific states (updating, logging out).
@freezed
sealed class UserState with _$UserState {
  const factory UserState({
    /// Current user data
    required UserModel user,

    /// Loading state for update operation
    @Default(false) bool isUpdating,

    /// Loading state for logout operation
    @Default(false) bool isLoggingOut,

    /// Action-specific error (update/logout failures)
    String? actionError,
  }) = _UserState;

  const UserState._();

  // ═══════════════════════════════════════════════════════════════════════
  // Computed properties
  // ═══════════════════════════════════════════════════════════════════════

  /// Whether any action is in progress
  bool get isBusy => isUpdating || isLoggingOut;

  /// Whether there's an action error
  bool get hasActionError => actionError != null;
}

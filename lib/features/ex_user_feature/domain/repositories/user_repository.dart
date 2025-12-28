import 'package:zero_setup_flutter/features/ex_user_feature/data/models/user_model.dart';

/// Abstract repository interface for user operations
/// This allows easy mocking for tests and decouples domain from data layer
abstract class UserRepository {
  /// Get current logged-in user
  Future<UserModel> getCurrentUser();

  /// Update user profile
  Future<UserModel> updateUser(UpdateUserRequest request);

  /// Delete user account permanently
  Future<void> deleteAccount();

  /// Logout user (server-side token invalidation)
  Future<void> logout();
}

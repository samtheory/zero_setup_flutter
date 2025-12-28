import '../../../../core/logger/app_logger.dart';
import '../../domain/repositories/user_repository.dart';
import '../models/user_model.dart';
import '../services/user_api_service.dart';

/// Implementation of UserRepository
class UserRepositoryImpl implements UserRepository {
  final UserApiService _apiService;

  UserRepositoryImpl(this._apiService);

  @override
  Future<UserModel> getCurrentUser() async {
    talker.info('Fetching current user');
    final user = await _apiService.getCurrentUser();
    talker.good('User fetched: ${user.name}');
    return user;
  }

  @override
  Future<UserModel> updateUser(UpdateUserRequest request) async {
    talker.info('Updating user: ${request.name}');
    talker.log('Updating user: ${request.name}');
    final user = await _apiService.updateUser(request);
    talker.log('Updating userrrrr: ${user.name}');
    talker.good('User updated: ${user.name}');
    return user;
  }

  @override
  Future<void> deleteAccount() async {
    talker.info('Deleting user account');
    await _apiService.deleteAccount();
    talker.good('Account deleted');
  }

  @override
  Future<void> logout() async {
    talker.info('Logging out');
    await _apiService.logout();
    talker.good('Logged out successfully');
  }
}

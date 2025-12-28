import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/user_model.dart';

part 'user_api_service.g.dart';

/// Retrofit API service for user operations
@RestApi()
abstract class UserApiService {
  factory UserApiService(Dio dio, {String baseUrl}) = _UserApiService;

  /// Get current user profile
  @GET('/user/me')
  Future<UserModel> getCurrentUser();

  /// Update user profile
  @PATCH('/user/me')
  Future<UserModel> updateUser(@Body() UpdateUserRequest request);

  /// Delete user account
  @DELETE('/user/me')
  Future<void> deleteAccount();

  /// Logout (invalidate token on server)
  @POST('/auth/logout')
  Future<void> logout();
}

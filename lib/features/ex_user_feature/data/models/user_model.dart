import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// User data model
@freezed
sealed class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String email,
    required String name,
    String? avatarUrl,
    String? phone,
    DateTime? createdAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

/// Request model for updating user profile
@freezed
sealed class UpdateUserRequest with _$UpdateUserRequest {
  const factory UpdateUserRequest({required String name, String? phone, String? avatarUrl}) = _UpdateUserRequest;

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) => _$UpdateUserRequestFromJson(json);
}

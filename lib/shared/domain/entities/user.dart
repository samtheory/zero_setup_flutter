import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
sealed class User with _$User {
  const factory User({required String id, required String name, required String email, String? avatarUrl}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Fake user برای تست
  // ✅ حالا می‌تونی static method داشته باشی
  static User fake() => const User(id: 'fake-user-001', name: 'کاربر تستی', email: 'test@example.com');
}

# ❄️ Code Generation Architecture Decision Record

> **Document:** `06-code-generation.md`  
> **Status:** ✅ Approved  
> **Decision Date:** 1404/09/22 (2025/12/13)  
> **Selected Solution:** Freezed (Manual Providers)  
> **Confidence Level:** 94%

---

## 📋 Table of Contents

| # | Section |
|---|---------|
| 1 | [Executive Summary](#executive-summary) |
| 2 | [Strategy Overview](#strategy-overview) |
| 3 | [What We Use vs. Avoid](#what-we-use-vs-avoid) |
| 4 | [Freezed Implementation](#freezed-implementation) |
| 5 | [Build Runner Config](#build-runner-config) |

---

## 🎯 Executive Summary

### Final Decision

| Tool | Decision | Reason |
|------|----------|--------|
| **Freezed** | ✅ Use | Immutable models, unions, copyWith |
| **json_serializable** | ✅ Use | JSON serialization (via Freezed) |
| **Isar Generator** | ✅ Use | Database entities |
| **Retrofit Generator** | ✅ Use | API client generation |
| **riverpod_generator** | ❌ Avoid | Unnecessary complexity |

### Philosophy

> **"Generate what's tedious. Write what's logical."**

Models = Generated ✅  
Providers = Manual ✅  
Business Logic = Manual ✅

---

## 🧠 Strategy Overview

### Code Generation Map

| Layer | Tool | Generated? |
|-------|------|------------|
| **Models/DTOs** | Freezed | ✅ Yes |
| **JSON Parsing** | json_serializable | ✅ Yes |
| **API Clients** | Retrofit | ✅ Yes |
| **Database** | Isar | ✅ Yes |
| **Providers** | Manual | ❌ No |
| **Business Logic** | Manual | ❌ No |

### Why No riverpod_generator?

| Aspect | Manual | Generated |
|--------|--------|-----------|
| **Readability** | 🟢 Clear | 🟡 Magic |
| **Debugging** | 🟢 Easy | 🔴 Hard |
| **Build Time** | 🟢 Fast | 🔴 Slow |
| **Learning Curve** | 🟢 Low | 🟡 Medium |
| **Flexibility** | 🟢 Full | 🟡 Limited |

**Verdict:** Manual providers = **6 lines of obvious code** vs. annotations + generated files.

---

## ✅ What We Use vs. ❌ Avoid

### ✅ USE: Freezed for Models
```dart
// lib/features/user/domain/models/user.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const User._(); // Required for custom methods

  const factory User({
required String id,
required String email,
required String name,
@Default(false) bool isVerified,
DateTime? lastLogin,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // ✅ Custom getters
  bool get hasLoggedIn => lastLogin != null;
  
  // ✅ Static factory for testing
  static User fake({String? id, String? email}) => User(
id: id ?? 'fake-id',
email: email ?? 'test@example.com',
name: 'Test User',
  );
}

### ✅ USE: Freezed Unions for State

dart
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error(String message) = _Error;
}

### ❌ AVOID: riverpod_generator

dart
// ❌ DON'T DO THIS
@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  Future<User> build() async => fetchUser();
}

// ✅ DO THIS INSTEAD
final userProvider = AsyncNotifierProvider<UserNotifier, User>(
  UserNotifier.new,
);

class UserNotifier extends AsyncNotifier<User> {
  @override
  Future<User> build() async => fetchUser();
}

---

## ⚙️ Build Runner Configuration

### Installation

yaml
dependencies:
  freezed_annotation: ^2.4.0
  json_annotation: ^4.8.0

dev_dependencies:
  freezed: ^2.4.0
  json_serializable: ^6.7.0
  build_runner: ^2.4.0

### build.yaml (Optimization)

yaml
targets:
  $default:
builders:
freezed:
options:
# Generate copyWith
copy_with: true
# Generate == and hashCode
equal: true
# Generate toString
to_string: true

json_serializable:
options:
explicit_to_json: true
include_if_null: false

### Commands

bash
# One-time generation
dart run build_runner build --delete-conflicting-outputs

# Watch mode (development)
dart run build_runner watch --delete-conflicting-outputs

---

## ✅ Final Verdict

| Decision | Rationale |
|----------|-----------|
| Freezed for models | Eliminates 90% boilerplate |
| Manual providers | Keeps logic transparent |
| Minimal codegen | Fast builds, easy debugging |

> *"The best generated code is the code you don't have to debug."*

---

End of `06-code-generation.md`


---

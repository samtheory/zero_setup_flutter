/// API Constants - همه URL‌ها و Endpoint‌ها یه جا
abstract final class ApiConstants {
  // ═══════════════════════════════════════════════════════════
  // Base URLs
  // ═══════════════════════════════════════════════════════════
  
  /// Production
  static const String prodBaseUrl = 'https://api.example.com/v1';
  
  /// Development (Mockoon)
  static const String devBaseUrl = 'http://localhost:3000';
  
  /// فعلاً Development استفاده می‌کنیم
  static const String baseUrl = devBaseUrl;

  // ═══════════════════════════════════════════════════════════
  // Timeouts
  // ═══════════════════════════════════════════════════════════
  
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // ═══════════════════════════════════════════════════════════
  // Endpoints - Auth
  // ═══════════════════════════════════════════════════════════
  
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh';
  static const String logout = '/auth/logout';

  // ═══════════════════════════════════════════════════════════
  // Endpoints - User
  // ═══════════════════════════════════════════════════════════
  
  static const String userProfile = '/user/profile';
  static const String updateProfile = '/user/profile';

  // ═══════════════════════════════════════════════════════════
  // Headers
  // ═══════════════════════════════════════════════════════════
  
  static const String authHeader = 'Authorization';
  static const String bearerPrefix = 'Bearer';
  static const String contentType = 'application/json';
}

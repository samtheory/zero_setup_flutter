import 'env/env.dart';
import 'env/env_dev.dart';
import 'env/env_prod.dart';
import 'env/env_staging.dart';

/// Global app configuration
/// مدیریت تنظیمات کلی اپلیکیشن و محیط فعلی
class AppConfig {
  AppConfig._();

  /// Instance سینگلتون
  static final AppConfig instance = AppConfig._();

  /// محیط فعلی
  static late Env _env;

  /// دسترسی به محیط فعلی
  static Env get env => _env;

  /// مقداردهی اولیه با محیط مشخص
  static void initialize(Env environment) {
    _env = environment;
  }

  /// Helper برای ایجاد محیط بر اساس نام
  static Env fromString(String envName) {
    switch (envName.toLowerCase()) {
      case 'development':
      case 'dev':
        return const EnvDev();
      case 'staging':
      case 'stg':
        return const EnvStaging();
      case 'production':
      case 'prod':
        return const EnvProd();
      default:
        throw ArgumentError('Unknown environment: $envName');
    }
  }
}

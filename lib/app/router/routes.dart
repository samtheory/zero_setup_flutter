// lib/app/router/routes.dart

/// تعریف مسیرها به صورت متمرکز
abstract class Routes {
  // Auth
  static const login = '/login';

  // Main Shell
  static const home = '/home';
  static const profile = '/profile';
  static const settings = '/settings';

  //plugin feature
  static const map = '/map';

  // Test Feature
  static const testFeature = '/test-feature';
  static const testFeatureDetail = '/test-feature/detail';
  static const testFeatureForm = '/test-feature/form';
}

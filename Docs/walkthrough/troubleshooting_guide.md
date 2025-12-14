# 🔧 Troubleshooting Guide

## 🚨 **COMMON ISSUES & SOLUTIONS**

### **1. App Won't Start**
**Symptoms:** `flutter run` fails or app crashes immediately

**Possible Causes & Solutions:**

**❌ Missing dependencies:**
```bash
flutter clean
flutter pub get
flutter pub run build_runner build
```

**❌ Environment not configured:**
```bash
# Check if .env file exists
ls -la .env

# If missing, copy from example
cp .env.example .env
```

**❌ Database not generated:**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### **2. Navigation Not Working**
**Symptoms:** Routes don't change or auth guard not working

**Check:**
```dart
// In router.dart, verify routes are added
final routes = [
  GoRoute(path: Routes.home, ...),
  GoRoute(path: Routes.login, ...),
];

// Check auth state
final authState = ref.watch(authProvider);
print('Auth state: ${authState.isAuthenticated}');
```

**Common Issues:**
- Route not added to `routes` list
- Auth provider not providing correct state
- Context missing in navigation calls

### **3. API Calls Failing**
**Symptoms:** Network requests return errors

**Debug Steps:**
```dart
// Check Dio client configuration
final dio = DioClient(secureStorage);
print('Base URL: ${dio.dio.options.baseUrl}');

// Check token
final token = await secureStorage.read('access_token');
print('Token exists: ${token != null}');

// Check network connectivity
final connectivity = Connectivity();
final result = await connectivity.checkConnectivity();
print('Connectivity: $result');
```

**Common Issues:**
- Base URL not set correctly
- Missing authentication token
- Network permissions not granted
- SSL certificate issues

### **4. State Not Updating**
**Symptoms:** UI doesn't reflect state changes

**Check:**
```dart
// Verify provider is being watched
final state = ref.watch(myProvider);

// Check if provider is StateNotifier
class MyNotifier extends StateNotifier<MyState> {
  MyNotifier() : super(MyState.initial());

  void updateData() {
    state = state.copyWith(data: newData); // ✅ Correct
    // state.data = newData; // ❌ Wrong - don't mutate
  }
}
```

**Common Issues:**
- Mutating state directly instead of creating new state
- Not using `ref.watch()` in widgets
- Provider not scoped correctly

### **5. Database Issues**
**Symptoms:** Drift queries failing or data not persisting

**Check:**
```bash
# Regenerate database code
flutter pub run build_runner build

# Check database file
ls -la *.db
```

**Common Issues:**
- Database schema not updated
- Migration not applied
- Database file corrupted

### **6. Build Failures**
**Symptoms:** `flutter build` fails

**Solutions:**
```bash
# Clean build
flutter clean
flutter pub get

# For iOS
cd ios
pod install
cd ..

# Regenerate all code
flutter pub run build_runner build --delete-conflicting-outputs

# Check for analysis issues
flutter analyze
```

### **7. Performance Issues**
**Symptoms:** App is slow or laggy

**Debug:**
```dart
// Add performance logging
import 'dart:developer';

Timeline.startSync('operation_name');
// ... your code ...
Timeline.finishSync();
```

**Common Issues:**
- Heavy computations on main thread
- Large images not optimized
- Too many rebuilds
- Memory leaks

---

## 🐛 **DEBUGGING WORKFLOW**

### **Step 1: Enable Debug Logging**
```dart
// In main.dart
import 'package:flutter/foundation.dart';

void main() {
  // Enable all logs in debug mode
  if (kDebugMode) {
    talker.settings.enabled = true;
  }

  runApp(const MyApp());
}
```

### **Step 2: Add Debug Prints**
```dart
// Strategic debug points
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    talker.debug('MyWidget building');

    final state = ref.watch(myProvider);
    talker.debug('State: $state');

    return Container();
  }
}
```

### **Step 3: Use Flutter DevTools**
```bash
flutter pub global activate devtools
flutter pub global run devtools
```

**Check:**
- Widget inspector
- Network profiler
- Performance overlay
- Memory usage

### **Step 4: Test on Different Devices**
- Physical device vs emulator
- Different screen sizes
- Different Android/iOS versions
- Different network conditions

---

## 🔍 **LOGGING & MONITORING**

### **Talker Logs**
```dart
// View logs in app (debug mode only)
import 'package:talker_flutter/talker_flutter.dart';

// In any screen
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => TalkerScreen(talker: talker),
  ),
);
```

### **Network Logs**
```dart
// Dio logs are automatic with TalkerDioLogger
// Check console for:
// [DIO] --> GET /api/users
// [DIO] <-- 200 OK
```

### **State Change Logs**
```dart
// Riverpod changes logged automatically
// Look for: [RIVERPOD] Provider updated
```

---

## 🛠️ **TOOLS & UTILITIES**

### **Essential Commands**
```bash
# Clean everything
flutter clean && flutter pub get

# Regenerate all code
flutter pub run build_runner build --delete-conflicting-outputs

# Run with verbose logging
flutter run --verbose

# Check platform issues
flutter doctor -v

# Analyze code
flutter analyze

# Run tests
flutter test --coverage
```

### **Debug Tools**
```bash
# Android logs
adb logcat

# iOS logs
xcrun simctl spawn booted log stream --level debug

# Network inspection
flutter pub add http_interceptor
```

### **Performance Tools**
```bash
# Profile app
flutter run --profile

# Build app bundle
flutter build appbundle --analyze-size

# Check package sizes
flutter pub run flutter_size_analyzer
```

---

## 🚨 **CRITICAL ISSUES**

### **App Crashes on Startup**
1. Check `flutter doctor`
2. Verify `pubspec.yaml` dependencies
3. Check platform-specific code
4. Review error logs in console

### **Authentication Loop**
1. Check auth provider state
2. Verify token storage
3. Check API endpoints
4. Review redirect logic in router

### **Data Not Syncing**
1. Check network connectivity
2. Verify API responses
3. Check database operations
4. Review sync logic

---

## 📞 **WHEN TO ASK FOR HELP**

### **Good Times to Ask:**
- Stuck for > 2 hours on same issue
- Error you can't understand
- Architecture decision needed
- Performance issue you can't diagnose

### **What to Include:**
```
Issue: Brief description
Error: Exact error message
Code: Relevant code snippet
Steps: How to reproduce
Environment: Flutter version, device, OS
Logs: Relevant log output
```

### **Help Resources:**
- Flutter documentation
- Stack Overflow
- GitHub issues
- Discord communities
- Your team/colleagues

---

## 🎯 **PREVENTION BEST PRACTICES**

### **Code Quality**
- Run `flutter analyze` before commits
- Write tests for new features
- Use proper error handling
- Follow code style guidelines

### **Testing**
- Test on multiple devices
- Test different network conditions
- Test offline scenarios
- Test edge cases

### **Monitoring**
- Set up crash reporting early
- Monitor performance metrics
- Track user analytics
- Set up alerts for critical issues

---

## 🚀 **QUICK FIXES**

### **Hot Reload Not Working**
```bash
# Kill and restart
Ctrl+C (in terminal)
flutter run
```

### **Dependencies Conflict**
```bash
flutter pub cache repair
flutter pub get
```

### **iOS Build Issues**
```bash
cd ios
pod deintegrate
pod install
cd ..
```

### **Android Build Issues**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

---

**Remember:** Most issues have been solved before. Search existing documentation and community resources first! 🔍</content>
<parameter name="filePath">e:\Projects\______ALTERS_____\__Template__Zone\zero_setup_flutter\Docs\walkthrough\troubleshooting_guide.md
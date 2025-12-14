# ⚡ Quick Start Guide

## 🎯 **WHAT YOU CAN DO RIGHT NOW** (5 minutes)

### 1. **Run the App**
```bash
flutter run
```
- ✅ App starts with login screen
- ✅ Persian RTL layout works
- ✅ Navigation between tabs works

### 2. **Test Authentication Flow**
1. Open app → See login screen
2. Click "ورود (Fake Login)" button
3. ✅ Logs in with fake user
4. ✅ Redirects to home screen
5. ✅ Can navigate between Home/Profile/Settings tabs

### 3. **Explore Working Code**
```bash
# Check these files to understand what's working:
code lib/shared/domain/providers/auth_provider.dart  # Auth logic
code lib/app/router/router.dart                      # Navigation
code lib/core/network/dio_client.dart               # API client
code lib/core/logger/app_logger.dart                # Logging
```

---

## 🚀 **FIRST DEVELOPMENT STEPS** (1 hour)

### **Step 1: Add a New Screen** (10 minutes)
```bash
# Create a new feature
mkdir -p lib/features/dashboard/presentation/screens

# Create dashboard_screen.dart
code lib/features/dashboard/presentation/screens/dashboard_screen.dart
```

**Copy this code:**
```dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/domain/providers/auth_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('داشبورد')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('سلام ${user?.name ?? 'مهمان'}! 👋'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => ref.read(authProvider.notifier).logout(),
              child: const Text('خروج'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### **Step 2: Add Route** (5 minutes)
```dart
# Edit lib/app/router/routes.dart
static const dashboard = '/dashboard';
```

```dart
# Edit lib/app/router/router.dart - Add to StatefulShellBranch
GoRoute(
  path: Routes.dashboard,
  pageBuilder: (context, state) => const NoTransitionPage(
    child: DashboardScreen(),
  ),
),
```

### **Step 3: Navigate to New Screen** (5 minutes)
```dart
# In any screen, add navigation
ElevatedButton(
  onPressed: () => context.go('/dashboard'),
  child: const Text('رفتن به داشبورد'),
)
```

### **Step 4: Test Your Changes** (5 minutes)
```bash
flutter run
```
- ✅ New screen should work
- ✅ Navigation should work
- ✅ Persian text displays correctly

---

## 📊 **WHAT'S WORKING vs WHAT'S NOT**

### ✅ **WORKING NOW:**
- App startup and initialization
- Persian RTL layout and fonts
- Authentication (fake login/logout)
- Navigation between screens
- Bottom tab navigation
- Theme switching (light/dark)
- Logging system (Talker)
- Storage services (ready to use)
- Network client (Dio configured)

### ❌ **NOT WORKING YET:**
- Real API calls (need API services)
- Database operations (need Drift setup)
- Form validation
- Error handling UI
- Offline data caching

---

## 🎯 **YOUR NEXT 3 TASKS** (This Week)

### **Task 1: Database Setup** (2-3 hours)
```bash
# Follow this guide
code Docs/roadmap/architectural_components_guide.md
```
**Goal:** Create User table and basic queries

### **Task 2: API Integration** (3-4 hours)
```bash
# Create auth API service
mkdir -p lib/core/network/services
code lib/core/network/services/auth_api.dart
```
**Goal:** Connect login to real API

### **Task 3: Complete Auth Flow** (2-3 hours)
- Replace fake login with real API call
- Add token storage and refresh
- Handle login errors properly

---

## 🔧 **USEFUL COMMANDS**

```bash
# Run app
flutter run

# Check dependencies
flutter pub get

# Generate code (Freezed, Retrofit, etc.)
flutter pub run build_runner build

# Run tests
flutter test

# Clean and rebuild
flutter clean && flutter pub get
```

---

## 📞 **WHEN YOU GET STUCK**

1. **Check existing code** - Look at `lib/features/auth/` for examples
2. **Read documentation** - `Docs/roadmap/` has implementation guides
3. **Use Talker logging** - Add `talker.info('debug message')` anywhere
4. **Test small changes** - Make one change at a time

---

## 🎉 **YOU'RE READY TO BUILD!**

Your foundation is solid. Start with small features and gradually add complexity. The architecture will support your growth! 🚀</content>
<parameter name="filePath">e:\Projects\______ALTERS_____\__Template__Zone\zero_setup_flutter\Docs\walkthrough\quick_start_guide.md
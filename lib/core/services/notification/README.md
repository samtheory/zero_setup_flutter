# 🔔 Notification Service

A comprehensive, centralized notification system for Flutter apps that handles all types of user notifications with consistent styling and behavior.

## 📦 Features

- **Multiple notification types**: Toast, Snackbar, Dialog, Bottom Sheet, Banner
- **Severity levels**: Success, Error, Warning, Info
- **Easy-to-use API**: Context extension for widgets, Riverpod provider for business logic
- **Customizable**: Colors, icons, actions, duration, positioning
- **Consistent styling**: Material Design compliant
- **Type-safe**: Full Dart type safety with enums and sealed classes

## 🚀 Quick Start

### 1. Import the service

```dart
import 'package:zero_setup_flutter/core/core.dart';
```

### 2. Use in widgets (Recommended)

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Show success toast
        context.notify.showSuccess('Profile updated!');

        // Show error with retry
        context.notify.showError(
          'Failed to save',
          onRetry: () => saveData(),
        );

        // Show confirmation dialog
        context.notify.showConfirmation(
          title: 'Delete item?',
          message: 'This cannot be undone.',
        ).then((confirmed) {
          if (confirmed) deleteItem();
        });
      },
      child: Text('Save'),
    );
  }
}
```

## 📋 API Reference

### Quick Methods

| Method | Description | Example |
|--------|-------------|---------|
| `showSuccess()` | Green success notification | `context.notify.showSuccess('Done!')` |
| `showError()` | Red error notification | `context.notify.showError('Failed')` |
| `showWarning()` | Orange warning notification | `context.notify.showWarning('Careful!')` |
| `showInfo()` | Blue info notification | `context.notify.showInfo('Tip')` |
| `showConfirmation()` | Dialog with Yes/No | `await context.notify.showConfirmation(...)` |
| `showLoading()` | Loading indicator | `final dismiss = context.notify.showLoading()` |

### Notification Types

```dart
enum NotificationType {
  toast,      // Quick top/bottom message
  snackbar,   // Material snackbar
  dialog,     // Alert dialog
  bottomSheet,// Modal bottom sheet
  banner,     // Persistent top banner
}
```

### Severity Levels

```dart
enum NotificationSeverity {
  success,  // Green
  error,    // Red
  warning,  // Orange
  info,     // Blue
}
```

## 🎯 Usage Examples

### Basic Notifications

```dart
// Success toast
context.notify.showSuccess('Data saved successfully!');

// Error with custom title
context.notify.showError(
  'Network connection failed',
  title: 'Connection Error',
);

// Warning dialog
context.notify.showWarning('This action cannot be undone');

// Info message
context.notify.showInfo('Swipe left to delete items');
```

### Confirmation Dialogs

```dart
// Simple confirmation
final confirmed = await context.notify.showConfirmation(
  title: 'Delete account?',
  message: 'This will permanently delete your account.',
);

if (confirmed) {
  // Delete account
}

// Custom labels
final result = await context.notify.showConfirmation(
  title: 'Exit app?',
  message: 'Unsaved changes will be lost.',
  confirmLabel: 'Exit',
  cancelLabel: 'Stay',
  severity: NotificationSeverity.warning,
);
```

### Loading Indicators

```dart
// Show loading
final dismiss = context.notify.showLoading(message: 'Saving...');

// Do async work
await saveData();

// Dismiss loading
dismiss();
```

### Custom Notifications

```dart
// Bottom sheet notification
context.notify.show(NotificationConfig.bottomSheet(
  title: 'New Message',
  message: 'You have a new message from John',
  icon: Icons.message,
  primaryAction: () => openMessage(),
  primaryActionLabel: 'View Message',
));

// Snackbar with action
context.notify.show(NotificationConfig(
  type: NotificationType.snackbar,
  title: 'File downloaded',
  severity: NotificationSeverity.success,
  primaryAction: () => openFile(),
  primaryActionLabel: 'Open',
));

// Banner notification
context.notify.show(NotificationConfig(
  type: NotificationType.banner,
  title: 'No internet connection',
  message: 'Please check your connection and try again',
  severity: NotificationSeverity.warning,
  primaryAction: () => checkConnection(),
  primaryActionLabel: 'Retry',
  dismissible: false,
));
```

### In Business Logic (Use Cases/Repositories)

```dart
// Wrap your screen with NotificationScope
class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NotificationScope(
      child: Scaffold(
        body: MyContent(),
      ),
    );
  }
}

// Use in use case
class SaveProfileUseCase {
  final Ref ref;

  Future<bool> call(ProfileData data) async {
    try {
      await _repository.save(data);
      ref.read(notificationServiceProvider).showSuccess('Profile saved!');
      return true;
    } catch (e) {
      ref.read(notificationServiceProvider).showError(
        'Failed to save profile',
        onRetry: () => call(data),
      );
      return false;
    }
  }
}
```

### Error Handling in API Calls

```dart
class UserRepositoryImpl implements UserRepository {
  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final response = await _apiService.getUser();
      return response;
    } on DioException catch (e) {
      // Show error notification
      final notificationService = ref.read(notificationServiceProvider);
      notificationService.showError(
        'Failed to load profile',
        onRetry: () => getCurrentUser(),
      );
      rethrow;
    }
  }
}
```

## 🎨 Customization

### NotificationConfig Properties

```dart
NotificationConfig(
  type: NotificationType.toast,           // UI type
  title: 'Custom Title',                  // Required
  message: 'Optional message',            // Optional
  severity: NotificationSeverity.info,    // Affects colors
  icon: Icons.star,                       // Custom icon
  duration: Duration(seconds: 5),         // Auto-dismiss duration
  primaryAction: () => doSomething(),     // Main action
  primaryActionLabel: 'Action',           // Action button text
  secondaryAction: () => cancel(),        // Secondary action
  secondaryActionLabel: 'Cancel',         // Secondary button text
  dismissible: true,                      // Can be dismissed
  showAtTop: true,                        // Position (toast only)
)
```

### Factory Constructors

```dart
// Success toast
NotificationConfig.success(
  title: 'Success!',
  message: 'Operation completed',
  duration: Duration(seconds: 3),
)

// Error with retry
NotificationConfig.error(
  title: 'Error',
  message: 'Something went wrong',
  onRetry: () => retry(),
)

// Warning dialog
NotificationConfig.warning(
  title: 'Warning',
  message: 'Are you sure?',
  onConfirm: () => proceed(),
)

// Info toast
NotificationConfig.info(
  title: 'Info',
  message: 'Here's a tip',
)

// Confirmation dialog
NotificationConfig.confirm(
  title: 'Confirm',
  message: 'Delete this item?',
  onConfirm: () => delete(),
  onCancel: () => cancel(),
)

// Bottom sheet
NotificationConfig.bottomSheet(
  title: 'New Feature',
  message: 'Check out this new feature!',
  primaryAction: () => explore(),
  primaryActionLabel: 'Explore',
)
```

## 🔧 Dismiss Methods

```dart
// Dismiss all toasts
context.notify.dismissAllToasts();

// Dismiss current snackbar
context.notify.dismissSnackbar();

// Dismiss current banner
context.notify.dismissBanner();
```

## 📁 File Structure

```
lib/core/services/notification/
├── notification.dart                    # Barrel export
├── notification_types.dart              # Types & config
├── notification_service.dart            # Main service
├── notification_provider.dart           # Riverpod provider
└── widgets/
    ├── notification_dialog.dart         # Dialog widget
    └── notification_bottom_sheet.dart   # Bottom sheet widget
```

## 🏗️ Architecture

### Context Extension (Widgets)

- **Best for**: UI components, screens, dialogs
- **Usage**: `context.notify.showSuccess(...)`
- **Pros**: Simple, no setup required
- **Cons**: Only works in widget context

### Riverpod Provider (Business Logic)

- **Best for**: Use cases, repositories, services
- **Usage**: `ref.read(notificationServiceProvider).showSuccess(...)`
- **Pros**: Works in any Riverpod scope
- **Cons**: Requires `NotificationScope` wrapper

### Direct Instantiation (Advanced)

- **Best for**: Custom contexts, testing
- **Usage**: `NotificationService(context).showSuccess(...)`
- **Pros**: Full control
- **Cons**: Manual context management

## 🎨 Styling

The service uses Material Design colors and follows platform conventions:

- **Success**: Green (#4CAF50)
- **Error**: Red (#F44336)
- **Warning**: Orange (#FF9800)
- **Info**: Blue (#2196F3)

Icons are automatically selected based on severity, but can be customized.

## 🧪 Testing

```dart
// Mock the service for testing
final mockNotificationService = MockNotificationService();

// Override in test
ProviderScope(
  overrides: [
    notificationServiceProvider.overrideWithValue(mockNotificationService),
  ],
  child: MyWidget(),
)

// Verify calls
verify(mockNotificationService.showSuccess('Done!')).called(1);
```

## 📋 Best Practices

1. **Use context extension** for widget notifications
2. **Use Riverpod provider** for business logic notifications
3. **Handle errors gracefully** with retry actions
4. **Keep messages concise** and actionable
5. **Use appropriate severity** levels
6. **Test notification flows** in integration tests

## 🔄 Migration Guide

### From Custom Solutions

```dart
// Before
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text('Error!')),
);

// After
context.notify.showError('Error!');
```

### From Other Packages

```dart
// Before (fluttertoast)
Fluttertoast.showToast(msg: 'Success!');

// After
context.notify.showSuccess('Success!');
```

## 🚨 Troubleshooting

### Common Issues

**"NotificationService must be overridden"**

- Use `context.notify` extension instead of `ref.read(notificationServiceProvider)`

**Notifications not showing**

- Ensure you're in a valid `BuildContext`
- Check if `toastification` is properly initialized in `main.dart`

**Colors not matching theme**

- The service uses hardcoded colors for consistency
- Override `NotificationConfig.getColor()` for custom theming

## 📝 Changelog

### v1.0.0

- Initial release
- Support for all notification types
- Context extension API
- Riverpod provider integration
- Comprehensive documentation

---

For more examples and advanced usage, check the inline documentation in the source code.

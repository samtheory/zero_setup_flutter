# 📡 Method Channels & Platform Integration Guide

## Overview

Method Channels are Flutter's mechanism for communicating between Dart code (Flutter) and platform-specific code (Android/iOS). This guide covers best practices for implementing Method Channels and building reusable Flutter packages that encapsulate platform functionality.

## 🔍 What Are Method Channels?

### Platform Channel Types

**1. MethodChannel** - Bidirectional method calls
```dart
// Flutter → Platform
final result = await _channel.invokeMethod('getBatteryLevel');

// Platform → Flutter (callback)
_channel.setMethodCallHandler(_handleMethodCall);
```

**2. EventChannel** - Stream of events from platform
```dart
// Continuous data stream (GPS, sensors)
final stream = EventChannel('battery_status').receiveBroadcastStream();
```

**3. BasicMessageChannel** - Simple message passing
```dart
// JSON/binary message exchange
_channel.send('Hello from Flutter');
```

### When to Use Method Channels

| Use Case | Channel Type | Example |
|----------|--------------|---------|
| One-time data request | MethodChannel | Get device info, check permissions |
| Continuous data stream | EventChannel | GPS location, sensor data, Bluetooth |
| Simple messaging | BasicMessageChannel | Custom binary protocols |
| File operations | MethodChannel | Read/write files, media access |
| Hardware access | MethodChannel/EventChannel | Camera, microphone, NFC |
| System services | MethodChannel | Notifications, alarms, system settings |

---

## 🏗️ Method Channel Implementation

### Step 1: Define Channel Constants

**📍 Core Constants** (`lib/core/platform_channels.dart`)
```dart
abstract class PlatformChannels {
  // Battery & Device Info
  static const batteryChannel = 'com.example.zero_setup_flutter/battery';
  static const deviceInfoChannel = 'com.example.zero_setup_flutter/device_info';

  // File Operations
  static const fileOperationsChannel = 'com.example.zero_setup_flutter/file_ops';

  // Sensors
  static const sensorChannel = 'com.example.zero_setup_flutter/sensors';

  // Custom Hardware
  static const hardwareChannel = 'com.example.zero_setup_flutter/hardware';
}

abstract class MethodNames {
  // Battery methods
  static const getBatteryLevel = 'getBatteryLevel';
  static const getBatteryStatus = 'getBatteryStatus';
  static const isBatteryCharging = 'isBatteryCharging';

  // Device info methods
  static const getDeviceModel = 'getDeviceModel';
  static const getOsVersion = 'getOsVersion';
  static const getDeviceId = 'getDeviceId';

  // File operations
  static const readFile = 'readFile';
  static const writeFile = 'writeFile';
  static const deleteFile = 'deleteFile';
}
```

### Step 2: Flutter Platform Interface

**📍 Platform Interface** (`lib/core/platform_interfaces/battery_platform.dart`)
```dart
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class BatteryPlatform extends PlatformInterface {
  BatteryPlatform() : super(token: _token);

  static final Object _token = Object();

  static BatteryPlatform _instance = MethodChannelBattery();

  static BatteryPlatform get instance => _instance;

  static set instance(BatteryPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  // Platform methods
  Future<int> getBatteryLevel() {
    throw UnimplementedError('getBatteryLevel() has not been implemented.');
  }

  Future<String> getBatteryStatus() {
    throw UnimplementedError('getBatteryStatus() has not been implemented.');
  }

  Future<bool> isBatteryCharging() {
    throw UnimplementedError('isBatteryCharging() has not been implemented.');
  }

  // Event streams
  Stream<int> get batteryLevelStream {
    throw UnimplementedError('batteryLevelStream has not been implemented.');
  }
}
```

### Step 3: Method Channel Implementation

**📍 Flutter Implementation** (`lib/core/method_channels/battery_channel.dart`)
```dart
import 'dart:async';
import 'package:flutter/services.dart';

import '../platform_interfaces/battery_platform.dart';
import '../platform_channels.dart';

class MethodChannelBattery extends BatteryPlatform {
  final MethodChannel _methodChannel = const MethodChannel(PlatformChannels.batteryChannel);
  final EventChannel _eventChannel = const EventChannel('${PlatformChannels.batteryChannel}/events');

  @override
  Future<int> getBatteryLevel() async {
    try {
      final result = await _methodChannel.invokeMethod<int>(MethodNames.getBatteryLevel);
      return result ?? 0;
    } on PlatformException catch (e) {
      throw BatteryException('Failed to get battery level: ${e.message}');
    }
  }

  @override
  Future<String> getBatteryStatus() async {
    try {
      final result = await _methodChannel.invokeMethod<String>(MethodNames.getBatteryStatus);
      return result ?? 'unknown';
    } on PlatformException catch (e) {
      throw BatteryException('Failed to get battery status: ${e.message}');
    }
  }

  @override
  Future<bool> isBatteryCharging() async {
    try {
      final result = await _methodChannel.invokeMethod<bool>(MethodNames.isBatteryCharging);
      return result ?? false;
    } on PlatformException catch (e) {
      throw BatteryException('Failed to check charging status: ${e.message}');
    }
  }

  @override
  Stream<int> get batteryLevelStream {
    return _eventChannel.receiveBroadcastStream().map<int>((event) {
      if (event is int) return event;
      return 0;
    });
  }
}
```

### Step 4: Error Handling

**📍 Custom Exceptions** (`lib/core/exceptions/platform_exceptions.dart`)
```dart
class PlatformException implements Exception {
  final String code;
  final String message;
  final dynamic details;

  const PlatformException({
    required this.code,
    required this.message,
    this.details,
  });

  @override
  String toString() => 'PlatformException($code): $message';
}

class BatteryException extends PlatformException {
  const BatteryException(String message)
      : super(code: 'BATTERY_ERROR', message: message);
}

class FileOperationException extends PlatformException {
  const FileOperationException(String message, {String? path})
      : super(code: 'FILE_ERROR', message: message, details: path);
}

class PermissionException extends PlatformException {
  const PermissionException(String message)
      : super(code: 'PERMISSION_ERROR', message: message);
}
```

### Step 5: Riverpod Integration

**📍 Provider** (`lib/shared/domain/providers/platform_providers.dart`)
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/method_channels/battery_channel.dart';
import '../../../core/platform_interfaces/battery_platform.dart';

part 'platform_providers.g.dart';

// Platform interface provider
@riverpod
BatteryPlatform batteryPlatform(BatteryPlatformRef ref) {
  return BatteryPlatform.instance;
}

// Battery service provider
@riverpod
class BatteryNotifier extends _$BatteryNotifier {
  @override
  Future<BatteryState> build() async {
    final platform = ref.watch(batteryPlatformProvider);

    // Listen to battery level changes
    final stream = platform.batteryLevelStream;
    stream.listen((level) {
      state = AsyncValue.data(
        state.valueOrNull?.copyWith(level: level) ?? BatteryState(level: level),
      );
    });

    // Initial battery level
    final level = await platform.getBatteryLevel();
    return BatteryState(level: level);
  }

  Future<void> refreshBatteryInfo() async {
    state = const AsyncValue.loading();
    try {
      final platform = ref.watch(batteryPlatformProvider);
      final level = await platform.getBatteryLevel();
      final status = await platform.getBatteryStatus();
      final isCharging = await platform.isBatteryCharging();

      state = AsyncValue.data(BatteryState(
        level: level,
        status: status,
        isCharging: isCharging,
      ));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
```

---

## 📦 Building Local Flutter Packages

### Package Structure

```
packages/
├── battery_platform/
│   ├── lib/
│   │   ├── battery_platform.dart          # Platform interface
│   │   ├── battery_platform_method_channel.dart  # Implementation
│   │   ├── battery_platform_web.dart      # Web implementation (optional)
│   │   └── src/
│   │       └── exceptions.dart
│   ├── android/
│   │   └── src/main/kotlin/com/example/battery_platform/
│   │       └── BatteryPlatformPlugin.kt
│   ├── ios/
│   │   └── Classes/
│   │       └── BatteryPlatformPlugin.swift
│   ├── battery_platform.iml
│   ├── pubspec.yaml
│   └── README.md
```

### Step 1: Create Package Structure

**Terminal Commands:**
```bash
# Create package directory
mkdir packages/battery_platform

# Initialize Flutter package
cd packages/battery_platform
flutter create --template=package .

# Create platform-specific directories
mkdir -p android/src/main/kotlin/com/example/battery_platform
mkdir -p ios/Classes
mkdir -p lib/src
```

### Step 2: Package pubspec.yaml

**📍 Package Configuration** (`packages/battery_platform/pubspec.yaml`)
```yaml
name: battery_platform
description: A Flutter plugin for accessing battery information across platforms.
version: 1.0.0
homepage: https://github.com/your-org/battery_platform

environment:
  sdk: '>=3.0.0 <4.0.0'
  flutter: ">=3.10.0"

dependencies:
  flutter:
    sdk: flutter
  plugin_platform_interface: ^2.1.8

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.2

flutter:
  plugin:
    platforms:
      android:
        package: com.example.battery_platform
        pluginClass: BatteryPlatformPlugin
      ios:
        pluginClass: BatteryPlatformPlugin
```

### Step 3: Platform Interface

**📍 Platform Interface** (`packages/battery_platform/lib/battery_platform.dart`)
```dart
import 'package:flutter/foundation.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'src/exceptions.dart';

abstract class BatteryPlatform extends PlatformInterface {
  BatteryPlatform() : super(token: _token);

  static final Object _token = Object();
  static BatteryPlatform _instance = MethodChannelBatteryPlatform();

  static BatteryPlatform get instance => _instance;

  static set instance(BatteryPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<int> getBatteryLevel() {
    throw UnimplementedError('getBatteryLevel() has not been implemented.');
  }

  Future<String> getBatteryStatus() {
    throw UnimplementedError('getBatteryStatus() has not been implemented.');
  }

  Future<bool> isBatteryCharging() {
    throw UnimplementedError('isBatteryCharging() has not been implemented.');
  }

  Stream<int> get batteryLevelStream {
    throw UnimplementedError('batteryLevelStream has not been implemented.');
  }
}
```

### Step 4: Method Channel Implementation

**📍 Implementation** (`packages/battery_platform/lib/battery_platform_method_channel.dart`)
```dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'battery_platform.dart';
import 'src/exceptions.dart';

class MethodChannelBatteryPlatform extends BatteryPlatform {
  static const MethodChannel _methodChannel = MethodChannel('battery_platform');
  static const EventChannel _eventChannel = EventChannel('battery_platform/events');

  @override
  Future<int> getBatteryLevel() async {
    final version = await _methodChannel.invokeMethod<int>('getBatteryLevel');
    return version ?? 0;
  }

  @override
  Future<String> getBatteryStatus() async {
    final status = await _methodChannel.invokeMethod<String>('getBatteryStatus');
    return status ?? 'unknown';
  }

  @override
  Future<bool> isBatteryCharging() async {
    final charging = await _methodChannel.invokeMethod<bool>('isBatteryCharging');
    return charging ?? false;
  }

  @override
  Stream<int> get batteryLevelStream {
    return _eventChannel.receiveBroadcastStream().map<int>((event) {
      if (event is int) return event;
      return 0;
    }).handleError((error) {
      if (kDebugMode) {
        print('Battery stream error: $error');
      }
      throw BatteryException('Stream error: $error');
    });
  }
}
```

### Step 5: Android Implementation

**📍 Android Plugin** (`packages/battery_platform/android/src/main/kotlin/com/example/battery_platform/BatteryPlatformPlugin.kt`)
```kotlin
package com.example.battery_platform

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class BatteryPlatformPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var eventChannel: EventChannel
    private lateinit var applicationContext: Context
    private var batteryReceiver: BroadcastReceiver? = null
    private var eventSink: EventChannel.EventSink? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = flutterPluginBinding.applicationContext

        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "battery_platform")
        channel.setMethodCallHandler(this)

        eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "battery_platform/events")
        eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                eventSink = events
                registerBatteryReceiver()
            }

            override fun onCancel(arguments: Any?) {
                unregisterBatteryReceiver()
                eventSink = null
            }
        })
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getBatteryLevel" -> {
                val batteryLevel = getBatteryLevel()
                result.success(batteryLevel)
            }
            "getBatteryStatus" -> {
                val batteryStatus = getBatteryStatus()
                result.success(batteryStatus)
            }
            "isBatteryCharging" -> {
                val isCharging = isBatteryCharging()
                result.success(isCharging)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun getBatteryLevel(): Int {
        val batteryManager = applicationContext.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }

    private fun getBatteryStatus(): String {
        val intent = applicationContext.registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
        val status = intent?.getIntExtra(BatteryManager.EXTRA_STATUS, -1) ?: -1

        return when (status) {
            BatteryManager.BATTERY_STATUS_CHARGING -> "charging"
            BatteryManager.BATTERY_STATUS_DISCHARGING -> "discharging"
            BatteryManager.BATTERY_STATUS_FULL -> "full"
            BatteryManager.BATTERY_STATUS_NOT_CHARGING -> "not_charging"
            else -> "unknown"
        }
    }

    private fun isBatteryCharging(): Boolean {
        val intent = applicationContext.registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
        val status = intent?.getIntExtra(BatteryManager.EXTRA_STATUS, -1) ?: -1
        return status == BatteryManager.BATTERY_STATUS_CHARGING
    }

    private fun registerBatteryReceiver() {
        batteryReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent?) {
                val level = getBatteryLevel()
                eventSink?.success(level)
            }
        }

        val filter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
        applicationContext.registerReceiver(batteryReceiver, filter)
    }

    private fun unregisterBatteryReceiver() {
        batteryReceiver?.let {
            applicationContext.unregisterReceiver(it)
            batteryReceiver = null
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
        unregisterBatteryReceiver()
    }
}
```

### Step 6: iOS Implementation

**📍 iOS Plugin** (`packages/battery_platform/ios/Classes/BatteryPlatformPlugin.swift`)
```swift
import Flutter
import UIKit

public class BatteryPlatformPlugin: NSObject, FlutterPlugin {
    private var eventSink: FlutterEventSink?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "battery_platform", binaryMessenger: registrar.messenger())
        let eventChannel = FlutterEventChannel(name: "battery_platform/events", binaryMessenger: registrar.messenger())

        let instance = BatteryPlatformPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)

        eventChannel.setStreamHandler(instance)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getBatteryLevel":
            result(getBatteryLevel())
        case "getBatteryStatus":
            result(getBatteryStatus())
        case "isBatteryCharging":
            result(isBatteryCharging())
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func getBatteryLevel() -> Int {
        UIDevice.current.isBatteryMonitoringEnabled = true
        return Int(UIDevice.current.batteryLevel * 100)
    }

    private func getBatteryStatus() -> String {
        UIDevice.current.isBatteryMonitoringEnabled = true

        switch UIDevice.current.batteryState {
        case .charging:
            return "charging"
        case .full:
            return "full"
        case .unplugged:
            return "discharging"
        default:
            return "unknown"
        }
    }

    private func isBatteryCharging() -> Bool {
        UIDevice.current.isBatteryMonitoringEnabled = true
        return UIDevice.current.batteryState == .charging
    }
}

extension BatteryPlatformPlugin: FlutterStreamHandler {
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events

        // Start battery monitoring
        UIDevice.current.isBatteryMonitoringEnabled = true

        // Send initial battery level
        let level = getBatteryLevel()
        eventSink?(level)

        // Set up battery level monitoring (simplified)
        // In a real implementation, you'd use notifications
        Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { _ in
            let currentLevel = self.getBatteryLevel()
            self.eventSink?(currentLevel)
        }

        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
}
```

### Step 7: Package Usage in Main App

**📍 Main App pubspec.yaml**
```yaml
dependencies:
  flutter:
    sdk: flutter

  # Local packages
  battery_platform:
    path: packages/battery_platform

  # Other dependencies...
```

**📍 Usage in App**
```dart
import 'package:battery_platform/battery_platform.dart';

class BatteryService {
  final BatteryPlatform _platform = BatteryPlatform.instance;

  Future<int> getBatteryLevel() => _platform.getBatteryLevel();

  Stream<int> getBatteryUpdates() => _platform.batteryLevelStream;
}
```

---

## 🧪 Testing Method Channels

### Unit Tests for Platform Interface

**📍 Platform Tests** (`packages/battery_platform/test/battery_platform_test.dart`)
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:battery_platform/battery_platform.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBatteryPlatform extends BatteryPlatform {
  @override
  Future<int> getBatteryLevel() async => 75;

  @override
  Future<String> getBatteryStatus() async => 'charging';

  @override
  Future<bool> isBatteryCharging() async => true;

  @override
  Stream<int> get batteryLevelStream => Stream.value(75);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    BatteryPlatform.instance = MockBatteryPlatform();
  });

  test('getBatteryLevel returns correct value', () async {
    final level = await BatteryPlatform.instance.getBatteryLevel();
    expect(level, 75);
  });

  test('batteryLevelStream emits values', () async {
    final stream = BatteryPlatform.instance.batteryLevelStream;
    expect(stream, emits(75));
  });
}
```

### Integration Tests

**📍 Integration Tests** (`integration_test/platform_test.dart`)
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:battery_platform/battery_platform.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('battery level integration test', (tester) async {
    final platform = BatteryPlatform.instance;

    // Test that we can call platform methods without crashing
    final level = await platform.getBatteryLevel();
    expect(level, isA<int>());
    expect(level, greaterThanOrEqualTo(0));
    expect(level, lessThanOrEqualTo(100));
  });
}
```

---

## 📋 Best Practices

### 1. **Error Handling**
```dart
try {
  final result = await _channel.invokeMethod('methodName');
  return result;
} on PlatformException catch (e) {
  // Handle platform-specific errors
  throw PlatformException(
    code: e.code,
    message: 'Platform error: ${e.message}',
    details: e.details,
  );
} on MissingPluginException catch (e) {
  // Handle missing plugin
  throw PlatformException(
    code: 'PLUGIN_NOT_FOUND',
    message: 'Platform implementation not found',
  );
}
```

### 2. **Method Channel Naming**
```dart
// Good: Descriptive and namespaced
const channel = 'com.example.app/feature_name';

// Bad: Generic names
const channel = 'my_channel';
```

### 3. **Type Safety**
```dart
// Good: Explicit types
Future<int> getBatteryLevel() async {
  final result = await _channel.invokeMethod<int>('getBatteryLevel');
  return result ?? 0;
}

// Bad: Dynamic types
Future getBatteryLevel() async {
  return await _channel.invokeMethod('getBatteryLevel');
}
```

### 4. **Resource Management**
```dart
class PlatformService {
  MethodChannel? _channel;
  StreamSubscription? _subscription;

  void initialize() {
    _channel = const MethodChannel('channel_name');
    _channel?.setMethodCallHandler(_handleMethodCall);
  }

  void dispose() {
    _subscription?.cancel();
    _channel?.setMethodCallHandler(null);
  }
}
```

### 5. **Platform-Specific Code**
```dart
// Use conditional imports for platform-specific implementations
import 'platform_service_mobile.dart'
    if (dart.library.html) 'platform_service_web.dart';
```

### 6. **Testing Strategy**
- **Unit Tests**: Mock platform interfaces
- **Integration Tests**: Test actual platform communication
- **Platform Tests**: Test native code separately

### 7. **Documentation**
```dart
/// Gets the current battery level as a percentage (0-100).
///
/// Returns [Future<int>] representing battery level.
/// Throws [PlatformException] if platform call fails.
Future<int> getBatteryLevel();
```

---

## 🚀 Advanced Patterns

### 1. **Generic Platform Bridge**
```dart
abstract class PlatformBridge<T> {
  const PlatformBridge(this.channelName);

  final String channelName;

  Future<T> invokeMethod(String method, [dynamic arguments]);
}

class BatteryBridge extends PlatformBridge<int> {
  const BatteryBridge() : super('battery_channel');

  Future<int> getLevel() => invokeMethod('getLevel');
}
```

### 2. **Event Channel with Backpressure**
```dart
class BufferedEventChannel {
  final StreamController<int> _controller = StreamController<int>.broadcast();
  late final StreamSubscription _subscription;

  BufferedEventChannel(String channelName) {
    final eventChannel = EventChannel(channelName);
    _subscription = eventChannel.receiveBroadcastStream().listen(
      (event) {
        if (!_controller.isClosed) {
          _controller.add(event as int);
        }
      },
      onError: (error) {
        _controller.addError(error);
      },
    );
  }

  Stream<int> get stream => _controller.stream;

  void dispose() {
    _subscription.cancel();
    _controller.close();
  }
}
```

### 3. **Plugin Architecture**
```dart
abstract class PlatformPlugin {
  String get channelName;
  Map<String, Function> get methodHandlers;

  void register() {
    final channel = MethodChannel(channelName);
    channel.setMethodCallHandler((call) async {
      final handler = methodHandlers[call.method];
      if (handler != null) {
        return await handler(call.arguments);
      }
      throw PlatformException(
        code: 'METHOD_NOT_IMPLEMENTED',
        message: 'Method ${call.method} not implemented',
      );
    });
  }
}
```

---

## 📊 Performance Considerations

### 1. **Channel Reuse**
```dart
// Good: Reuse channels
class PlatformService {
  static const MethodChannel _channel = MethodChannel('service_channel');

  static Future<String> getData() => _channel.invokeMethod('getData');
}

// Bad: Create new channels
Future<String> getData() {
  final channel = MethodChannel('service_channel');
  return channel.invokeMethod('getData');
}
```

### 2. **Batch Operations**
```dart
// Good: Batch related operations
Future<Map<String, dynamic>> getDeviceInfo() async {
  return await _channel.invokeMethod('getDeviceInfo');
}

// Contains: model, osVersion, batteryLevel, etc.
```

### 3. **Stream Optimization**
```dart
// Use buffers for high-frequency events
stream.transform(BufferTransformer(100)); // Buffer 100ms
```

---

## 🔧 Troubleshooting

### Common Issues

**1. MissingPluginException**
```
Solution: Ensure plugin is properly registered in AndroidManifest.xml and Info.plist
```

**2. PlatformException**
```
Solution: Check platform-specific error codes and handle gracefully
```

**3. MethodChannel not responding**
```
Solution: Verify channel names match between Dart and native code
```

**4. Memory leaks**
```
Solution: Properly dispose channels and stream subscriptions
```

### Debug Tips

**1. Channel Logging**
```dart
class DebugMethodChannel extends MethodChannel {
  @override
  Future<T?> invokeMethod<T>(String method, [dynamic arguments]) async {
    print('→ $method: $arguments');
    final result = await super.invokeMethod<T>(method, arguments);
    print('← $method: $result');
    return result;
  }
}
```

**2. Platform Channel Inspector**
```dart
// Add to dev menu for debugging
void inspectChannels() {
  // List all active channels
  // Show method call history
  // Monitor event streams
}
```

This comprehensive guide provides everything needed to implement robust Method Channels and build reusable Flutter packages for platform integration, following best practices and architectural patterns.</content>
<parameter name="filePath">e:\Projects\______ALTERS_____\__Template__Zone\zero_setup_flutter\Docs\roadmap\method_channels_guide.md
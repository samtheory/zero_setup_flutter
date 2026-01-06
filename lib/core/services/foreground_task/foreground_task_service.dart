// lib/core/services/foreground_task/foreground_task_service.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

/// Configuration for the driver reminder foreground task
class DriverReminderConfig {
  /// Interval between reminders in seconds
  static const int reminderIntervalSeconds = 10;

  /// List of reminder messages to show randomly
  static const List<String> reminderMessages = [
    'Be careful, driver! 🚗',
    'Stay focused on the road! 👀',
    'We are watching you! 👁️',
    'Drive safely! 🛡️',
    'Keep your eyes on the road! 🛣️',
    'Safety first! ⚠️',
    'Stay alert, stay alive! 🚨',
    'Focus on driving! 🎯',
  ];
}

/// Service to manage foreground tasks for driver reminders
class ForegroundTaskService {
  ForegroundTaskService._();
  static final ForegroundTaskService instance = ForegroundTaskService._();

  /// Initialize foreground task settings
  Future<void> init() async {
    FlutterForegroundTask.initCommunicationPort();

    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'driver_reminder_channel',
        channelName: 'Driver Reminder Service',
        channelDescription: 'Shows reminders while driving',
        channelImportance: NotificationChannelImportance.HIGH,
        priority: NotificationPriority.HIGH,
        playSound: false,
        enableVibration: false,
        visibility: NotificationVisibility.VISIBILITY_PUBLIC,
      ),
      iosNotificationOptions: const IOSNotificationOptions(showNotification: true, playSound: false),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(DriverReminderConfig.reminderIntervalSeconds * 1000),
        autoRunOnBoot: false,
        autoRunOnMyPackageReplaced: false,
        allowWakeLock: true,
        allowWifiLock: false,
      ),
    );
  }

  /// Request necessary permissions for foreground task
  Future<bool> requestPermissions() async {
    // Android 12+: Request notification permission
    final notificationPermission = await FlutterForegroundTask.checkNotificationPermission();
    if (notificationPermission != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }

    // Android 13+: Request "ignore battery optimization" permission
    if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
      await FlutterForegroundTask.requestIgnoreBatteryOptimization();
    }

    return await FlutterForegroundTask.checkNotificationPermission() == NotificationPermission.granted;
  }

  /// Start the foreground task
  Future<ServiceRequestResult> startTask() async {
    if (await FlutterForegroundTask.isRunningService) {
      return FlutterForegroundTask.restartService();
    } else {
      return FlutterForegroundTask.startService(
        notificationTitle: 'Driver Reminder Active',
        notificationText: 'Monitoring your drive...',
        notificationIcon: null,
        notificationButtons: [const NotificationButton(id: 'stop', text: 'Stop')],
        callback: startCallback,
      );
    }
  }

  /// Stop the foreground task
  Future<ServiceRequestResult> stopTask() async {
    return FlutterForegroundTask.stopService();
  }

  /// Check if task is running
  Future<bool> get isRunning async => await FlutterForegroundTask.isRunningService;

  /// Set up listener for task data
  void setTaskDataCallback(void Function(Object data) callback) {
    FlutterForegroundTask.addTaskDataCallback(callback);
  }

  /// Remove task data callback
  void removeTaskDataCallback(void Function(Object data) callback) {
    FlutterForegroundTask.removeTaskDataCallback(callback);
  }

  /// Send data to the task handler
  void sendDataToTask(Object data) {
    FlutterForegroundTask.sendDataToTask(data);
  }
}

/// Top-level callback function for foreground task
@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(DriverReminderTaskHandler());
}

/// Task handler that runs in the background
class DriverReminderTaskHandler extends TaskHandler {
  int _tickCount = 0;

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    debugPrint('DriverReminderTaskHandler started at: $timestamp');
    _tickCount = 0;
  }

  @override
  void onRepeatEvent(DateTime timestamp) {
    _tickCount++;

    // Get a random message
    final messageIndex = _tickCount % DriverReminderConfig.reminderMessages.length;
    final message = DriverReminderConfig.reminderMessages[messageIndex];

    // Update notification
    FlutterForegroundTask.updateService(notificationTitle: 'Driver Reminder', notificationText: message);

    // Send data to main isolate to trigger PiP
    FlutterForegroundTask.sendDataToMain({
      'type': 'show_pip_reminder',
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'tickCount': _tickCount,
    });

    debugPrint('DriverReminderTaskHandler tick #$_tickCount: $message at $timestamp');
  }

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {
    debugPrint('DriverReminderTaskHandler destroyed at: $timestamp, timeout: $isTimeout');
  }

  @override
  void onNotificationButtonPressed(String id) {
    if (id == 'stop') {
      FlutterForegroundTask.stopService();
    }
  }

  @override
  void onNotificationPressed() {
    // When notification is pressed, send data to bring app to foreground
    FlutterForegroundTask.sendDataToMain({'type': 'notification_pressed'});
  }

  @override
  void onNotificationDismissed() {
    debugPrint('Notification dismissed');
  }

  @override
  void onReceiveData(Object data) {
    debugPrint('Received data from main: $data');
  }
}

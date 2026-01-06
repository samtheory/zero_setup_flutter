// lib/core/services/foreground_task/pip_reminder_controller.dart

import 'dart:async';
import 'dart:math';

import 'package:floating/floating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:zero_setup_flutter/core/logger/app_logger.dart';
import 'package:zero_setup_flutter/core/services/foreground_task/foreground_task_service.dart';

/// Controller for managing PiP (Picture-in-Picture) reminders
///
/// This controller listens for foreground task events and triggers
/// PiP mode with reminder messages for the driver.
class PipReminderController with WidgetsBindingObserver {
  PipReminderController._() {
    WidgetsBinding.instance.addObserver(this);
  }
  static final PipReminderController instance = PipReminderController._();

  final Floating _floating = Floating();

  BuildContext? _context;
  bool _isEnabled = false;
  bool _isAppInBackground = false;
  String _currentMessage = '';

  /// Current reminder message
  String get currentMessage => _currentMessage;

  /// Whether the PiP reminder is enabled
  bool get isEnabled => _isEnabled;

  /// Check if PiP is available on this device
  Future<bool> get isPipAvailable => _floating.isPipAvailable;

  /// Check if currently in PiP mode
  Future<PiPStatus> get pipStatus => _floating.pipStatus;

  /// Initialize the controller with context
  void init(BuildContext context) {
    _context = context;
    _setupTaskListener();
  }

  /// Handle app lifecycle changes
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_isEnabled) return;

    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        // App is going to background
        if (!_isAppInBackground) {
          _isAppInBackground = true;
          _notifyTaskOfLifecycleChange(true);
          talker.info('App moved to background - notifications enabled');
        }
        break;

      case AppLifecycleState.resumed:
        // App is coming back to foreground
        if (_isAppInBackground) {
          _isAppInBackground = false;
          _notifyTaskOfLifecycleChange(false);
          talker.info('App moved to foreground - notifications paused');
        }
        break;

      case AppLifecycleState.detached:
        // App is being terminated
        break;
    }
  }

  /// Notify the foreground task of lifecycle change
  void _notifyTaskOfLifecycleChange(bool isInBackground) {
    ForegroundTaskService.instance.sendDataToTask({'type': 'app_lifecycle', 'isInBackground': isInBackground});
  }

  /// Set up listener for foreground task data
  void _setupTaskListener() {
    ForegroundTaskService.instance.setTaskDataCallback(_onTaskData);
  }

  /// Handle data received from foreground task
  void _onTaskData(Object data) {
    if (data is! Map) return;

    final dataMap = data as Map<String, dynamic>;
    final type = dataMap['type'] as String?;

    switch (type) {
      case 'show_pip_reminder':
        _currentMessage = dataMap['message'] as String? ?? 'Stay safe!';
        _showPipReminder();
        break;
      case 'notification_pressed':
        // App will be brought to foreground automatically
        talker.info('Notification pressed - bringing app to foreground');
        break;
    }
  }

  /// Show PiP with current reminder message
  Future<void> _showPipReminder() async {
    if (_context == null || !_isEnabled) return;

    try {
      final isPipAvailable = await _floating.isPipAvailable;
      if (!isPipAvailable) {
        talker.warning('PiP not available on this device');
        return;
      }

      // Check if already in PiP mode
      final status = await _floating.pipStatus;
      if (status == PiPStatus.enabled) {
        talker.info('Already in PiP mode');
        return;
      }

      // Enable PiP with appropriate settings
      await _enablePip();
      talker.good('PiP reminder shown: $_currentMessage');
    } catch (e) {
      talker.error('Failed to show PiP reminder: $e');
    }
  }

  /// Enable PiP mode
  Future<PiPStatus> _enablePip() async {
    if (_context == null) return PiPStatus.disabled;

    final mediaQuery = MediaQuery.of(_context!);
    final screenSize = mediaQuery.size * mediaQuery.devicePixelRatio;
    final width = (screenSize.width * 0.8).toInt();
    final height = (screenSize.height * 0.8).toInt();

    final arguments = ImmediatePiP(
      aspectRatio: const Rational(4, 3),
      sourceRectHint: Rectangle<int>(0, (screenSize.height ~/ 2) - (height ~/ 2), width, height),
    );

    return await _floating.enable(arguments);
  }

  /// Start the reminder service
  Future<void> start(BuildContext context) async {
    _context = context;
    _isEnabled = true;
    _isAppInBackground = false; // Start assuming app is in foreground

    // Initialize the foreground task service first
    await ForegroundTaskService.instance.init();

    // Request permissions
    final hasPermission = await ForegroundTaskService.instance.requestPermissions();
    if (!hasPermission) {
      talker.warning('Foreground task permissions not granted');
      _isEnabled = false;
      return;
    }

    // Start the foreground task
    final result = await ForegroundTaskService.instance.startTask();

    if (result is ServiceRequestSuccess) {
      talker.good('Foreground task started successfully');
      // Notify task that app is currently in foreground
      _notifyTaskOfLifecycleChange(false);
    } else {
      talker.error('Foreground task failed to start: $result');
      _isEnabled = false;
    }
  }

  /// Stop the reminder service
  Future<void> stop() async {
    _isEnabled = false;
    final result = await ForegroundTaskService.instance.stopTask();
    talker.info('Foreground task stopped: $result');
  }

  /// Toggle the reminder service
  Future<void> toggle(BuildContext context) async {
    final isRunning = await ForegroundTaskService.instance.isRunning;
    if (!context.mounted) return;

    if (isRunning) {
      await stop();
    } else {
      await start(context);
    }
  }

  /// Clean up resources
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    ForegroundTaskService.instance.removeTaskDataCallback(_onTaskData);
    _context = null;
    _isEnabled = false;
    _isAppInBackground = false;
  }
}

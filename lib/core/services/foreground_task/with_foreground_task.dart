// lib/core/services/foreground_task/with_foreground_task.dart

import 'package:floating/floating.dart';
import 'package:flutter/material.dart';
import 'package:zero_setup_flutter/core/services/foreground_task/foreground_task.dart';

/// A wrapper widget that enables foreground task and PiP functionality
///
/// Wrap your root app widget with this to enable:
/// - Foreground task for background processing
/// - Automatic PiP on app minimize (when enabled)
/// - Lifecycle-aware reminder service
///
/// Example:
/// ```dart
/// WithForegroundTask(
///   child: MaterialApp(...),
/// )
/// ```
class WithForegroundTask extends StatefulWidget {
  final Widget child;

  /// Whether to auto-start the foreground task when app is minimized
  final bool autoStartOnMinimize;

  /// Whether to show PiP automatically when reminder fires
  final bool enablePipReminders;

  const WithForegroundTask({
    super.key,
    required this.child,
    this.autoStartOnMinimize = true,
    this.enablePipReminders = true,
  });

  @override
  State<WithForegroundTask> createState() => _WithForegroundTaskState();
}

class _WithForegroundTaskState extends State<WithForegroundTask> with WidgetsBindingObserver {
  final _pipController = PipReminderController.instance;
  bool _wasInBackground = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initForegroundTask();
  }

  Future<void> _initForegroundTask() async {
    await ForegroundTaskService.instance.init();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        // App is going to background
        if (widget.autoStartOnMinimize && !_wasInBackground) {
          _wasInBackground = true;
          _startBackgroundReminder();
        }
        break;

      case AppLifecycleState.resumed:
        // App is coming back to foreground
        if (_wasInBackground) {
          _wasInBackground = false;
          // Optionally stop the task when app resumes
          // _pipController.stop();
        }
        break;

      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        // App is being destroyed
        break;
    }
  }

  Future<void> _startBackgroundReminder() async {
    if (widget.enablePipReminders && mounted) {
      await _pipController.start(context);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize pip controller with context
    _pipController.init(context);

    return PiPSwitcher(
      childWhenEnabled: const PipReminderScreen(message: 'Stay focused on the road!'),
      childWhenDisabled: widget.child,
    );
  }
}

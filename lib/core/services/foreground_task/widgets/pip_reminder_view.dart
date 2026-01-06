// lib/core/services/foreground_task/widgets/pip_reminder_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Widget displayed in PiP mode showing driver reminders
class PipReminderView extends StatelessWidget {
  final String message;
  final Color? backgroundColor;
  final Color? textColor;

  const PipReminderView({super.key, required this.message, this.backgroundColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? const Color(0xFF1E1E2E);
    final txtColor = textColor ?? Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 20, spreadRadius: 5)],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildWarningIcon(txtColor),
              const Gap(12),
              _buildMessage(txtColor),
              const Gap(8),
              _buildPulsingDot(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWarningIcon(Color color) {
    return Icon(LucideIcons.triangleAlert, size: 48, color: Colors.amber)
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 1500.ms)
        .then()
        .shake(hz: 2, duration: 500.ms);
  }

  Widget _buildMessage(Color color) {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.5),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildPulsingDot() {
    return Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
        )
        .animate(onPlay: (controller) => controller.repeat())
        .scale(begin: const Offset(1, 1), end: const Offset(1.5, 1.5), duration: 800.ms)
        .then()
        .scale(begin: const Offset(1.5, 1.5), end: const Offset(1, 1), duration: 800.ms);
  }
}

/// Full-screen variant for PiP mode
class PipReminderScreen extends StatelessWidget {
  final String message;

  const PipReminderScreen({super.key, this.message = 'Stay safe on the road!'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      body: PipReminderView(message: message),
    );
  }
}

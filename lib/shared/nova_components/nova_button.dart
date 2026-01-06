import 'package:flutter/material.dart';

import '../../core/theme/nova.dart';

enum NovaButtonVariant { filled, outlined, text }

enum NovaButtonColor { primary, secondary, error, success, warning }

enum NovaButtonSize { sm, md, lg }

/// NOVA Button - All button variants
class NovaButton extends StatelessWidget {
  const NovaButton._({
    super.key,
    required this.child,
    required this.onPressed,
    required this.variant,
    required this.colorType,
    this.icon,
    this.isLoading = false,
    this.isExpanded = false,
    this.size = NovaButtonSize.md,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final NovaButtonVariant variant;
  final NovaButtonColor colorType;
  final Widget? icon;
  final bool isLoading;
  final bool isExpanded;
  final NovaButtonSize size;

  // ═══════════════════════════════════════════════════════════════════════════
  // FILLED VARIANTS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Primary filled button (blue)
  factory NovaButton.filled({
    Key? key,
    required Widget child,
    required VoidCallback? onPressed,
    Widget? icon,
    bool isLoading = false,
    bool isExpanded = false,
    NovaButtonSize size = NovaButtonSize.md,
  }) {
    return NovaButton._(
      key: key,
      onPressed: onPressed,
      variant: NovaButtonVariant.filled,
      colorType: NovaButtonColor.primary,
      icon: icon,
      isLoading: isLoading,
      isExpanded: isExpanded,
      size: size,
      child: child,
    );
  }

  /// Error filled button (red)
  factory NovaButton.filledError({
    Key? key,
    required Widget child,
    required VoidCallback? onPressed,
    Widget? icon,
    bool isLoading = false,
    bool isExpanded = false,
    NovaButtonSize size = NovaButtonSize.md,
  }) {
    return NovaButton._(
      key: key,
      onPressed: onPressed,
      variant: NovaButtonVariant.filled,
      colorType: NovaButtonColor.error,
      icon: icon,
      isLoading: isLoading,
      isExpanded: isExpanded,
      size: size,
      child: child,
    );
  }

  /// Success filled button (green)
  factory NovaButton.filledSuccess({
    Key? key,
    required Widget child,
    required VoidCallback? onPressed,
    Widget? icon,
    bool isLoading = false,
    bool isExpanded = false,
    NovaButtonSize size = NovaButtonSize.md,
  }) {
    return NovaButton._(
      key: key,
      onPressed: onPressed,
      variant: NovaButtonVariant.filled,
      colorType: NovaButtonColor.success,
      icon: icon,
      isLoading: isLoading,
      isExpanded: isExpanded,
      size: size,
      child: child,
    );
  }

  /// Warning filled button (yellow)
  factory NovaButton.filledWarning({
    Key? key,
    required Widget child,
    required VoidCallback? onPressed,
    Widget? icon,
    bool isLoading = false,
    bool isExpanded = false,
    NovaButtonSize size = NovaButtonSize.md,
  }) {
    return NovaButton._(
      key: key,
      onPressed: onPressed,
      variant: NovaButtonVariant.filled,
      colorType: NovaButtonColor.warning,
      icon: icon,
      isLoading: isLoading,
      isExpanded: isExpanded,
      size: size,
      child: child,
    );
  }

  /// Secondary filled button (ocean)
  factory NovaButton.filledSecondary({
    Key? key,
    required Widget child,
    required VoidCallback? onPressed,
    Widget? icon,
    bool isLoading = false,
    bool isExpanded = false,
    NovaButtonSize size = NovaButtonSize.md,
  }) {
    return NovaButton._(
      key: key,
      onPressed: onPressed,
      variant: NovaButtonVariant.filled,
      colorType: NovaButtonColor.secondary,
      icon: icon,
      isLoading: isLoading,
      isExpanded: isExpanded,
      size: size,
      child: child,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // OUTLINED VARIANTS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Primary outlined button
  factory NovaButton.outlined({
    Key? key,
    required Widget child,
    required VoidCallback? onPressed,
    Widget? icon,
    bool isLoading = false,
    bool isExpanded = false,
    NovaButtonSize size = NovaButtonSize.md,
  }) {
    return NovaButton._(
      key: key,
      onPressed: onPressed,
      variant: NovaButtonVariant.outlined,
      colorType: NovaButtonColor.primary,
      icon: icon,
      isLoading: isLoading,
      isExpanded: isExpanded,
      size: size,
      child: child,
    );
  }

  /// Error outlined button
  factory NovaButton.outlinedError({
    Key? key,
    required Widget child,
    required VoidCallback? onPressed,
    Widget? icon,
    bool isLoading = false,
    bool isExpanded = false,
    NovaButtonSize size = NovaButtonSize.md,
  }) {
    return NovaButton._(
      key: key,
      onPressed: onPressed,
      variant: NovaButtonVariant.outlined,
      colorType: NovaButtonColor.error,
      icon: icon,
      isLoading: isLoading,
      isExpanded: isExpanded,
      size: size,
      child: child,
    );
  }

  /// Success outlined button
  factory NovaButton.outlinedSuccess({
    Key? key,
    required Widget child,
    required VoidCallback? onPressed,
    Widget? icon,
    bool isLoading = false,
    bool isExpanded = false,
    NovaButtonSize size = NovaButtonSize.md,
  }) {
    return NovaButton._(
      key: key,
      onPressed: onPressed,
      variant: NovaButtonVariant.outlined,
      colorType: NovaButtonColor.success,
      icon: icon,
      isLoading: isLoading,
      isExpanded: isExpanded,
      size: size,
      child: child,
    );
  }

  /// Warning outlined button
  factory NovaButton.outlinedWarning({
    Key? key,
    required Widget child,
    required VoidCallback? onPressed,
    Widget? icon,
    bool isLoading = false,
    bool isExpanded = false,
    NovaButtonSize size = NovaButtonSize.md,
  }) {
    return NovaButton._(
      key: key,
      onPressed: onPressed,
      variant: NovaButtonVariant.outlined,
      colorType: NovaButtonColor.warning,
      icon: icon,
      isLoading: isLoading,
      isExpanded: isExpanded,
      size: size,
      child: child,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // TEXT/GHOST VARIANTS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Primary text button
  factory NovaButton.text({
    Key? key,
    required Widget child,
    required VoidCallback? onPressed,
    Widget? icon,
    bool isLoading = false,
    bool isExpanded = false,
    NovaButtonSize size = NovaButtonSize.md,
  }) {
    return NovaButton._(
      key: key,
      onPressed: onPressed,
      variant: NovaButtonVariant.text,
      colorType: NovaButtonColor.primary,
      icon: icon,
      isLoading: isLoading,
      isExpanded: isExpanded,
      size: size,
      child: child,
    );
  }

  /// Error text button
  factory NovaButton.textError({
    Key? key,
    required Widget child,
    required VoidCallback? onPressed,
    Widget? icon,
    bool isLoading = false,
    bool isExpanded = false,
    NovaButtonSize size = NovaButtonSize.md,
  }) {
    return NovaButton._(
      key: key,
      onPressed: onPressed,
      variant: NovaButtonVariant.text,
      colorType: NovaButtonColor.error,
      icon: icon,
      isLoading: isLoading,
      isExpanded: isExpanded,
      size: size,
      child: child,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD
  // ═══════════════════════════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    final colors = context.nova.colors;
    final typography = context.nova.text;

    // Get colors based on colorType
    final (bgColor, fgColor, borderColor) = _getColors(colors);

    // Get size properties
    final (padding, minHeight, textStyle) = _getSizeProps(typography);

    // Build button content
    Widget content = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(fgColor)),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                IconTheme(
                  data: IconThemeData(color: fgColor, size: textStyle.fontSize! + 4),
                  child: icon!,
                ),
                const SizedBox(width: 8),
              ],
              DefaultTextStyle(
                style: textStyle.copyWith(color: fgColor),
                child: child,
              ),
            ],
          );

    // Build button style
    final ButtonStyle buttonStyle;
    switch (variant) {
      case NovaButtonVariant.filled:
        buttonStyle = ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          elevation: 0,
          padding: padding,
          minimumSize: Size(isExpanded ? double.infinity : 0, minHeight),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        );
        return ElevatedButton(onPressed: isLoading ? null : onPressed, style: buttonStyle, child: content);

      case NovaButtonVariant.outlined:
        buttonStyle = OutlinedButton.styleFrom(
          foregroundColor: fgColor,
          padding: padding,
          minimumSize: Size(isExpanded ? double.infinity : 0, minHeight),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          side: BorderSide(color: borderColor, width: 1.5),
        );
        return OutlinedButton(onPressed: isLoading ? null : onPressed, style: buttonStyle, child: content);

      case NovaButtonVariant.text:
        buttonStyle = TextButton.styleFrom(
          foregroundColor: fgColor,
          padding: padding,
          minimumSize: Size(isExpanded ? double.infinity : 0, minHeight),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        );
        return TextButton(onPressed: isLoading ? null : onPressed, style: buttonStyle, child: content);
    }
  }

  (Color bg, Color fg, Color border) _getColors(NovaColors colors) {
    switch (colorType) {
      case NovaButtonColor.primary:
        return (colors.blue.shade60, colors.blue.shade0, colors.blue.shade60);
      case NovaButtonColor.secondary:
        return (colors.ocean.shade60, colors.ocean.shade0, colors.ocean.shade60);
      case NovaButtonColor.error:
        return (colors.red.shade60, colors.red.shade0, colors.red.shade60);
      case NovaButtonColor.success:
        return (colors.green.shade60, colors.green.shade0, colors.green.shade60);
      case NovaButtonColor.warning:
        return (colors.yellow.shade60, colors.yellow.shade10, colors.yellow.shade60);
    }
  }

  (EdgeInsets, double, TextStyle) _getSizeProps(NovaTypography typography) {
    switch (size) {
      case NovaButtonSize.sm:
        return (const EdgeInsets.symmetric(horizontal: 12, vertical: 8), 36.0, typography.labelSm);
      case NovaButtonSize.md:
        return (const EdgeInsets.symmetric(horizontal: 16, vertical: 12), 44.0, typography.labelMd);
      case NovaButtonSize.lg:
        return (const EdgeInsets.symmetric(horizontal: 24, vertical: 16), 52.0, typography.labelLg);
    }
  }
}

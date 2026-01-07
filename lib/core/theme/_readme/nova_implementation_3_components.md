# NOVA Implementation: Part 3 - UI Components

## File Structure

```
lib/shared/nova_components/
├── nova_components.dart      # Barrel export
├── nova_text.dart            # Auto-size text
├── nova_button.dart          # Button variants
├── nova_input.dart           # Input variants
└── nova_card.dart            # Card variants
```

---

## File: `lib/shared/nova_components/nova_text.dart`

```dart
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:zero_setup_flutter/core/theme/nova.dart';

/// Text extension for NOVA Design System with auto-size support
extension NovaTextExtension on Text {
  /// Standard auto-size text with body style
  static Widget nova(
    String text, {
    Key? key,
    TextStyle? style,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
    double minFontSize = 12,
    double maxFontSize = double.infinity,
    double stepGranularity = 1,
  }) {
    return Builder(
      builder: (context) {
        final defaultStyle = context.nova.text.bodyMd;
        return AutoSizeText(
          text,
          key: key,
          style: style ?? defaultStyle,
          maxLines: maxLines,
          textAlign: textAlign,
          overflow: overflow,
          minFontSize: minFontSize,
          maxFontSize: maxFontSize,
          stepGranularity: stepGranularity,
        );
      },
    );
  }

  /// Display text (largest)
  static Widget novaDisplay(
    String text, {
    Key? key,
    NovaDisplaySize size = NovaDisplaySize.md,
    TextStyle? style,
    int? maxLines,
    TextAlign? textAlign,
    Color? color,
  }) {
    return Builder(
      builder: (context) {
        final typography = context.nova.text;
        TextStyle baseStyle;
        switch (size) {
          case NovaDisplaySize.lg:
            baseStyle = typography.displayLg;
            break;
          case NovaDisplaySize.md:
            baseStyle = typography.displayMd;
            break;
          case NovaDisplaySize.sm:
            baseStyle = typography.displaySm;
            break;
        }
        return AutoSizeText(
          text,
          key: key,
          style: baseStyle.copyWith(color: color).merge(style),
          maxLines: maxLines ?? 1,
          textAlign: textAlign,
          minFontSize: 20,
        );
      },
    );
  }

  /// Heading text
  static Widget novaHeading(
    String text, {
    Key? key,
    NovaHeadingSize size = NovaHeadingSize.md,
    TextStyle? style,
    int? maxLines,
    TextAlign? textAlign,
    Color? color,
  }) {
    return Builder(
      builder: (context) {
        final typography = context.nova.text;
        TextStyle baseStyle;
        switch (size) {
          case NovaHeadingSize.lg:
            baseStyle = typography.headingLg;
            break;
          case NovaHeadingSize.md:
            baseStyle = typography.headingMd;
            break;
          case NovaHeadingSize.sm:
            baseStyle = typography.headingSm;
            break;
        }
        return AutoSizeText(
          text,
          key: key,
          style: baseStyle.copyWith(color: color).merge(style),
          maxLines: maxLines ?? 2,
          textAlign: textAlign,
          minFontSize: 16,
        );
      },
    );
  }

  /// Title text
  static Widget novaTitle(
    String text, {
    Key? key,
    NovaTitleSize size = NovaTitleSize.md,
    TextStyle? style,
    int? maxLines,
    TextAlign? textAlign,
    Color? color,
  }) {
    return Builder(
      builder: (context) {
        final typography = context.nova.text;
        TextStyle baseStyle;
        switch (size) {
          case NovaTitleSize.lg:
            baseStyle = typography.titleLg;
            break;
          case NovaTitleSize.md:
            baseStyle = typography.titleMd;
            break;
          case NovaTitleSize.sm:
            baseStyle = typography.titleSm;
            break;
        }
        return AutoSizeText(
          text,
          key: key,
          style: baseStyle.copyWith(color: color).merge(style),
          maxLines: maxLines ?? 2,
          textAlign: textAlign,
          minFontSize: 12,
        );
      },
    );
  }

  /// Body text
  static Widget novaBody(
    String text, {
    Key? key,
    NovaBodySize size = NovaBodySize.md,
    TextStyle? style,
    int? maxLines,
    TextAlign? textAlign,
    Color? color,
  }) {
    return Builder(
      builder: (context) {
        final typography = context.nova.text;
        TextStyle baseStyle;
        switch (size) {
          case NovaBodySize.lg:
            baseStyle = typography.bodyLg;
            break;
          case NovaBodySize.md:
            baseStyle = typography.bodyMd;
            break;
          case NovaBodySize.sm:
            baseStyle = typography.bodySm;
            break;
        }
        return AutoSizeText(
          text,
          key: key,
          style: baseStyle.copyWith(color: color).merge(style),
          maxLines: maxLines,
          textAlign: textAlign,
          minFontSize: 10,
        );
      },
    );
  }

  /// Label text
  static Widget novaLabel(
    String text, {
    Key? key,
    NovaLabelSize size = NovaLabelSize.md,
    TextStyle? style,
    int? maxLines,
    TextAlign? textAlign,
    Color? color,
  }) {
    return Builder(
      builder: (context) {
        final typography = context.nova.text;
        TextStyle baseStyle;
        switch (size) {
          case NovaLabelSize.lg:
            baseStyle = typography.labelLg;
            break;
          case NovaLabelSize.md:
            baseStyle = typography.labelMd;
            break;
          case NovaLabelSize.sm:
            baseStyle = typography.labelSm;
            break;
        }
        return AutoSizeText(
          text,
          key: key,
          style: baseStyle.copyWith(color: color).merge(style),
          maxLines: maxLines ?? 1,
          textAlign: textAlign,
          minFontSize: 8,
        );
      },
    );
  }

  /// Caption text (smallest)
  static Widget novaCaption(
    String text, {
    Key? key,
    TextStyle? style,
    int? maxLines,
    TextAlign? textAlign,
    Color? color,
  }) {
    return Builder(
      builder: (context) {
        return AutoSizeText(
          text,
          key: key,
          style: context.nova.text.caption.copyWith(color: color).merge(style),
          maxLines: maxLines ?? 1,
          textAlign: textAlign,
          minFontSize: 8,
        );
      },
    );
  }
}

// Size enums
enum NovaDisplaySize { lg, md, sm }
enum NovaHeadingSize { lg, md, sm }
enum NovaTitleSize { lg, md, sm }
enum NovaBodySize { lg, md, sm }
enum NovaLabelSize { lg, md, sm }
```

---

## File: `lib/shared/nova_components/nova_button.dart`

```dart
import 'package:flutter/material.dart';
import 'package:zero_setup_flutter/core/theme/nova.dart';

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
      child: child,
      onPressed: onPressed,
      variant: NovaButtonVariant.filled,
      colorType: NovaButtonColor.primary,
      icon: icon,
      isLoading: isLoading,
      isExpanded: isExpanded,
      size: size,
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
      child: child,
      onPressed: onPressed,
      variant: NovaButtonVariant.filled,
      colorType: NovaButtonColor.error,
      icon: icon,
      isLoading: isLoading,
      isExpanded: isExpanded,
      size: size,
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
      child: child,
      onPressed: onPressed,
      variant: NovaButtonVariant.filled,
      colorType: NovaButtonColor.success,
      icon: icon,
      isLoading: isLoading,
      isExpanded: isExpanded,
      size: size,
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
      child: child,
      onPressed: onPressed,
      variant: NovaButtonVariant.filled,
      colorType: NovaButtonColor.warning,
      icon: icon,
      isLoading: isLoading,
      isExpanded: isExpanded,
      size: size,
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
      child: child,
      onPressed: onPressed,
      variant: NovaButtonVariant.filled,
      colorType: NovaButtonColor.secondary,
      icon: icon,
      isLoading: isLoading,
      isExpanded: isExpanded,
      size: size,
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
      child: child,
      onPressed: onPressed,
      variant: NovaButtonVariant.outlined,
      colorType: NovaButtonColor.primary,
      icon: icon,
      isLoading: isLoading,
      isExpanded: isExpanded,
      size: size,
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
      child: child,
      onPressed: onPressed,
      variant: NovaButtonVariant.outlined,
      colorType: NovaButtonColor.error,
      icon: icon,
      isLoading: isLoading,
      isExpanded: isExpanded,
      size: size,
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
      child: child,
      onPressed: onPressed,
      variant: NovaButtonVariant.outlined,
      colorType: NovaButtonColor.success,
      icon: icon,
      isLoading: isLoading,
      isExpanded: isExpanded,
      size: size,
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
      child: child,
      onPressed: onPressed,
      variant: NovaButtonVariant.outlined,
      colorType: NovaButtonColor.warning,
      icon: icon,
      isLoading: isLoading,
      isExpanded: isExpanded,
      size: size,
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
      child: child,
      onPressed: onPressed,
      variant: NovaButtonVariant.text,
      colorType: NovaButtonColor.primary,
      icon: icon,
      isLoading: isLoading,
      isExpanded: isExpanded,
      size: size,
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
      child: child,
      onPressed: onPressed,
      variant: NovaButtonVariant.text,
      colorType: NovaButtonColor.error,
      icon: icon,
      isLoading: isLoading,
      isExpanded: isExpanded,
      size: size,
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
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(fgColor),
            ),
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
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: content,
        );

      case NovaButtonVariant.outlined:
        buttonStyle = OutlinedButton.styleFrom(
          foregroundColor: fgColor,
          padding: padding,
          minimumSize: Size(isExpanded ? double.infinity : 0, minHeight),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          side: BorderSide(color: borderColor, width: 1.5),
        );
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: content,
        );

      case NovaButtonVariant.text:
        buttonStyle = TextButton.styleFrom(
          foregroundColor: fgColor,
          padding: padding,
          minimumSize: Size(isExpanded ? double.infinity : 0, minHeight),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        );
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: content,
        );
    }
  }

  (Color bg, Color fg, Color border) _getColors(NovaColors colors) {
    switch (colorType) {
      case NovaButtonColor.primary:
        return (
          colors.blue.shade60,
          colors.blue.shade0,
          colors.blue.shade60,
        );
      case NovaButtonColor.secondary:
        return (
          colors.ocean.shade60,
          colors.ocean.shade0,
          colors.ocean.shade60,
        );
      case NovaButtonColor.error:
        return (
          colors.red.shade60,
          colors.red.shade0,
          colors.red.shade60,
        );
      case NovaButtonColor.success:
        return (
          colors.green.shade60,
          colors.green.shade0,
          colors.green.shade60,
        );
      case NovaButtonColor.warning:
        return (
          colors.yellow.shade60,
          colors.yellow.shade10,
          colors.yellow.shade60,
        );
    }
  }

  (EdgeInsets, double, TextStyle) _getSizeProps(NovaTypography typography) {
    switch (size) {
      case NovaButtonSize.sm:
        return (
          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          36.0,
          typography.labelSm,
        );
      case NovaButtonSize.md:
        return (
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          44.0,
          typography.labelMd,
        );
      case NovaButtonSize.lg:
        return (
          const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          52.0,
          typography.labelLg,
        );
    }
  }
}

enum NovaButtonVariant { filled, outlined, text }
enum NovaButtonColor { primary, secondary, error, success, warning }
enum NovaButtonSize { sm, md, lg }
```

---

## File: `lib/shared/nova_components/nova_input.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zero_setup_flutter/core/theme/nova.dart';

/// NOVA Input - All input variants
class NovaInput extends StatelessWidget {
  const NovaInput._({
    super.key,
    required this.variant,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helper,
    this.error,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
  });

  final NovaInputVariant variant;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final String? helper;
  final String? error;
  final Widget? prefix;
  final Widget? suffix;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final bool autofocus;
  final TextCapitalization textCapitalization;

  // ═══════════════════════════════════════════════════════════════════════════
  // FACTORIES
  // ═══════════════════════════════════════════════════════════════════════════

  /// Standard outlined input
  factory NovaInput.outlined({
    Key? key,
    TextEditingController? controller,
    FocusNode? focusNode,
    String? label,
    String? hint,
    String? helper,
    String? error,
    Widget? prefix,
    Widget? suffix,
    IconData? prefixIcon,
    IconData? suffixIcon,
    bool obscureText = false,
    bool enabled = true,
    bool readOnly = false,
    int maxLines = 1,
    int? minLines,
    int? maxLength,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    List<TextInputFormatter>? inputFormatters,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    VoidCallback? onTap,
    bool autofocus = false,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return NovaInput._(
      key: key,
      variant: NovaInputVariant.outlined,
      controller: controller,
      focusNode: focusNode,
      label: label,
      hint: hint,
      helper: helper,
      error: error,
      prefix: prefix,
      suffix: suffix,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTap: onTap,
      autofocus: autofocus,
      textCapitalization: textCapitalization,
    );
  }

  /// Filled background input
  factory NovaInput.filled({
    Key? key,
    TextEditingController? controller,
    FocusNode? focusNode,
    String? label,
    String? hint,
    String? helper,
    String? error,
    Widget? prefix,
    Widget? suffix,
    IconData? prefixIcon,
    IconData? suffixIcon,
    bool obscureText = false,
    bool enabled = true,
    bool readOnly = false,
    int maxLines = 1,
    int? minLines,
    int? maxLength,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    List<TextInputFormatter>? inputFormatters,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    VoidCallback? onTap,
    bool autofocus = false,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return NovaInput._(
      key: key,
      variant: NovaInputVariant.filled,
      controller: controller,
      focusNode: focusNode,
      label: label,
      hint: hint,
      helper: helper,
      error: error,
      prefix: prefix,
      suffix: suffix,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTap: onTap,
      autofocus: autofocus,
      textCapitalization: textCapitalization,
    );
  }

  /// Underline input
  factory NovaInput.underline({
    Key? key,
    TextEditingController? controller,
    FocusNode? focusNode,
    String? label,
    String? hint,
    String? helper,
    String? error,
    Widget? prefix,
    Widget? suffix,
    IconData? prefixIcon,
    IconData? suffixIcon,
    bool obscureText = false,
    bool enabled = true,
    bool readOnly = false,
    int maxLines = 1,
    int? minLines,
    int? maxLength,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    List<TextInputFormatter>? inputFormatters,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    VoidCallback? onTap,
    bool autofocus = false,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return NovaInput._(
      key: key,
      variant: NovaInputVariant.underline,
      controller: controller,
      focusNode: focusNode,
      label: label,
      hint: hint,
      helper: helper,
      error: error,
      prefix: prefix,
      suffix: suffix,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTap: onTap,
      autofocus: autofocus,
      textCapitalization: textCapitalization,
    );
  }

  /// Search input with search icon
  factory NovaInput.search({
    Key? key,
    TextEditingController? controller,
    FocusNode? focusNode,
    String? hint,
    Widget? suffix,
    bool enabled = true,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    bool autofocus = false,
  }) {
    return NovaInput._(
      key: key,
      variant: NovaInputVariant.filled,
      controller: controller,
      focusNode: focusNode,
      hint: hint ?? 'Search...',
      prefixIcon: Icons.search,
      suffix: suffix,
      enabled: enabled,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      autofocus: autofocus,
      textInputAction: TextInputAction.search,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD
  // ═══════════════════════════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    final colors = context.nova.colors;
    final typography = context.nova.text;

    final hasError = error != null && error!.isNotEmpty;
    final borderColor = hasError ? colors.red.shade60 : colors.gray.shade80;
    final focusColor = hasError ? colors.red.shade60 : colors.blue.shade60;
    final fillColor = colors.gray.shade95;

    InputBorder border;
    InputBorder focusedBorder;
    InputBorder errorBorder;
    Color? backgroundColor;

    switch (variant) {
      case NovaInputVariant.outlined:
        border = OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor, width: 1.5),
        );
        focusedBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: focusColor, width: 2),
        );
        errorBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.red.shade60, width: 2),
        );
        break;

      case NovaInputVariant.filled:
        border = OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        );
        focusedBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: focusColor, width: 2),
        );
        errorBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.red.shade60, width: 2),
        );
        backgroundColor = fillColor;
        break;

      case NovaInputVariant.underline:
        border = UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 1.5),
        );
        focusedBorder = UnderlineInputBorder(
          borderSide: BorderSide(color: focusColor, width: 2),
        );
        errorBorder = UnderlineInputBorder(
          borderSide: BorderSide(color: colors.red.shade60, width: 2),
        );
        break;
    }

    return TextField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTap: onTap,
      autofocus: autofocus,
      textCapitalization: textCapitalization,
      style: typography.bodyMd.copyWith(color: colors.onSurface),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        helperText: helper,
        errorText: error,
        prefix: prefix,
        suffix: suffix,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        filled: backgroundColor != null,
        fillColor: backgroundColor,
        border: border,
        enabledBorder: border,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: typography.bodyMd.copyWith(color: colors.gray.shade60),
        hintStyle: typography.bodyMd.copyWith(color: colors.gray.shade60),
        helperStyle: typography.bodySm.copyWith(color: colors.gray.shade60),
        errorStyle: typography.bodySm.copyWith(color: colors.red.shade60),
      ),
    );
  }
}

enum NovaInputVariant { outlined, filled, underline }
```

---

## File: `lib/shared/nova_components/nova_components.dart`

```dart
/// NOVA UI Components
/// 
/// Ready-to-use components with design system integration.
library nova_components;

export 'nova_text.dart';
export 'nova_button.dart';
export 'nova_input.dart';
```

---

## Usage Examples

```dart
import 'package:your_app/shared/nova_components/nova_components.dart';
import 'package:your_app/core/theme/nova.dart';

class ExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text
        Text.novaHeading('Welcome', size: NovaHeadingSize.lg),
        Text.novaBody('This is body text'),
        Text.novaLabel('Label'),
        
        // Buttons
        NovaButton.filled(
          onPressed: () {},
          child: Text('Submit'),
        ),
        NovaButton.filledError(
          onPressed: () {},
          child: Text('Delete'),
        ),
        NovaButton.outlined(
          onPressed: () {},
          child: Text('Cancel'),
        ),
        NovaButton.outlinedSuccess(
          onPressed: () {},
          child: Text('Approve'),
        ),
        
        // Inputs
        NovaInput.outlined(
          label: 'Email',
          hint: 'Enter your email',
          prefixIcon: Icons.email,
        ),
        NovaInput.filled(
          label: 'Password',
          obscureText: true,
          suffixIcon: Icons.visibility,
        ),
        NovaInput.search(
          hint: 'Search products...',
          onChanged: (value) {},
        ),
        
        // Access colors/typography directly
        Container(
          decoration: BoxDecoration(
            gradient: context.nova.gradients.primary,
            boxShadow: context.nova.shadows.md,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            'Styled container',
            style: context.nova.text.titleMd.copyWith(
              color: context.nova.colors.blue.shade0,
            ),
          ),
        ),
      ],
    );
  }
}
```

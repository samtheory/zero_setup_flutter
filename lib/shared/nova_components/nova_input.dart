import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/nova.dart';

enum NovaInputVariant { outlined, filled, underline }

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

      case NovaInputVariant.filled:
        border = OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none);
        focusedBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: focusColor, width: 2),
        );
        errorBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.red.shade60, width: 2),
        );
        backgroundColor = fillColor;

      case NovaInputVariant.underline:
        border = UnderlineInputBorder(borderSide: BorderSide(color: borderColor, width: 1.5));
        focusedBorder = UnderlineInputBorder(borderSide: BorderSide(color: focusColor, width: 2));
        errorBorder = UnderlineInputBorder(borderSide: BorderSide(color: colors.red.shade60, width: 2));
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

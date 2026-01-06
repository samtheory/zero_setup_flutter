import 'package:flutter/material.dart';

/// NOVA Typography System - ThemeExtension
class NovaTypography extends ThemeExtension<NovaTypography> {
  const NovaTypography({
    required this.displayLg,
    required this.displayMd,
    required this.displaySm,
    required this.headingLg,
    required this.headingMd,
    required this.headingSm,
    required this.titleLg,
    required this.titleMd,
    required this.titleSm,
    required this.bodyLg,
    required this.bodyMd,
    required this.bodySm,
    required this.labelLg,
    required this.labelMd,
    required this.labelSm,
    required this.caption,
  });

  final TextStyle displayLg;
  final TextStyle displayMd;
  final TextStyle displaySm;
  final TextStyle headingLg;
  final TextStyle headingMd;
  final TextStyle headingSm;
  final TextStyle titleLg;
  final TextStyle titleMd;
  final TextStyle titleSm;
  final TextStyle bodyLg;
  final TextStyle bodyMd;
  final TextStyle bodySm;
  final TextStyle labelLg;
  final TextStyle labelMd;
  final TextStyle labelSm;
  final TextStyle caption;

  static const String _fontFamily = 'IRANSansX';

  static const standard = NovaTypography(
    // Display
    displayLg: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 57,
      fontWeight: FontWeight.w700,
      height: 1.12,
      letterSpacing: -0.25,
    ),
    displayMd: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 45,
      fontWeight: FontWeight.w700,
      height: 1.16,
    ),
    displaySm: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 36,
      fontWeight: FontWeight.w600,
      height: 1.22,
    ),
    // Heading
    headingLg: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.w600,
      height: 1.25,
    ),
    headingMd: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 28,
      fontWeight: FontWeight.w600,
      height: 1.29,
    ),
    headingSm: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 1.33,
    ),
    // Title
    titleLg: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 22,
      fontWeight: FontWeight.w500,
      height: 1.27,
    ),
    titleMd: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      height: 1.33,
    ),
    titleSm: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.43,
    ),
    // Body
    bodyLg: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
    bodyMd: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.43,
    ),
    bodySm: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.33,
    ),
    // Label
    labelLg: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.43,
    ),
    labelMd: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.33,
    ),
    labelSm: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 11,
      fontWeight: FontWeight.w500,
      height: 1.45,
    ),
    // Caption
    caption: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 10,
      fontWeight: FontWeight.w400,
      height: 1.4,
    ),
  );

  @override
  NovaTypography copyWith({
    TextStyle? displayLg,
    TextStyle? displayMd,
    TextStyle? displaySm,
    TextStyle? headingLg,
    TextStyle? headingMd,
    TextStyle? headingSm,
    TextStyle? titleLg,
    TextStyle? titleMd,
    TextStyle? titleSm,
    TextStyle? bodyLg,
    TextStyle? bodyMd,
    TextStyle? bodySm,
    TextStyle? labelLg,
    TextStyle? labelMd,
    TextStyle? labelSm,
    TextStyle? caption,
  }) {
    return NovaTypography(
      displayLg: displayLg ?? this.displayLg,
      displayMd: displayMd ?? this.displayMd,
      displaySm: displaySm ?? this.displaySm,
      headingLg: headingLg ?? this.headingLg,
      headingMd: headingMd ?? this.headingMd,
      headingSm: headingSm ?? this.headingSm,
      titleLg: titleLg ?? this.titleLg,
      titleMd: titleMd ?? this.titleMd,
      titleSm: titleSm ?? this.titleSm,
      bodyLg: bodyLg ?? this.bodyLg,
      bodyMd: bodyMd ?? this.bodyMd,
      bodySm: bodySm ?? this.bodySm,
      labelLg: labelLg ?? this.labelLg,
      labelMd: labelMd ?? this.labelMd,
      labelSm: labelSm ?? this.labelSm,
      caption: caption ?? this.caption,
    );
  }

  @override
  NovaTypography lerp(ThemeExtension<NovaTypography>? other, double t) {
    if (other is! NovaTypography) return this;
    return NovaTypography(
      displayLg: TextStyle.lerp(displayLg, other.displayLg, t)!,
      displayMd: TextStyle.lerp(displayMd, other.displayMd, t)!,
      displaySm: TextStyle.lerp(displaySm, other.displaySm, t)!,
      headingLg: TextStyle.lerp(headingLg, other.headingLg, t)!,
      headingMd: TextStyle.lerp(headingMd, other.headingMd, t)!,
      headingSm: TextStyle.lerp(headingSm, other.headingSm, t)!,
      titleLg: TextStyle.lerp(titleLg, other.titleLg, t)!,
      titleMd: TextStyle.lerp(titleMd, other.titleMd, t)!,
      titleSm: TextStyle.lerp(titleSm, other.titleSm, t)!,
      bodyLg: TextStyle.lerp(bodyLg, other.bodyLg, t)!,
      bodyMd: TextStyle.lerp(bodyMd, other.bodyMd, t)!,
      bodySm: TextStyle.lerp(bodySm, other.bodySm, t)!,
      labelLg: TextStyle.lerp(labelLg, other.labelLg, t)!,
      labelMd: TextStyle.lerp(labelMd, other.labelMd, t)!,
      labelSm: TextStyle.lerp(labelSm, other.labelSm, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
    );
  }
}

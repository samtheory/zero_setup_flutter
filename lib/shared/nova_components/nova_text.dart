import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../core/theme/nova.dart';

// Size enums
enum NovaDisplaySize { lg, md, sm }

enum NovaHeadingSize { lg, md, sm }

enum NovaTitleSize { lg, md, sm }

enum NovaBodySize { lg, md, sm }

enum NovaLabelSize { lg, md, sm }

/// NOVA Text components with auto-size support
abstract class NovaText {
  /// Standard auto-size text with body style
  static Widget auto(
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
  static Widget display(
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
          case NovaDisplaySize.md:
            baseStyle = typography.displayMd;
          case NovaDisplaySize.sm:
            baseStyle = typography.displaySm;
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
  static Widget heading(
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
          case NovaHeadingSize.md:
            baseStyle = typography.headingMd;
          case NovaHeadingSize.sm:
            baseStyle = typography.headingSm;
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
  static Widget title(
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
          case NovaTitleSize.md:
            baseStyle = typography.titleMd;
          case NovaTitleSize.sm:
            baseStyle = typography.titleSm;
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
  static Widget body(
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
          case NovaBodySize.md:
            baseStyle = typography.bodyMd;
          case NovaBodySize.sm:
            baseStyle = typography.bodySm;
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
  static Widget label(
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
          case NovaLabelSize.md:
            baseStyle = typography.labelMd;
          case NovaLabelSize.sm:
            baseStyle = typography.labelSm;
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
  static Widget caption(String text, {Key? key, TextStyle? style, int? maxLines, TextAlign? textAlign, Color? color}) {
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

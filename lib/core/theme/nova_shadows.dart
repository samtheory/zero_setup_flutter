import 'package:flutter/material.dart';

/// NOVA Shadow System - ThemeExtension
class NovaShadows extends ThemeExtension<NovaShadows> {
  const NovaShadows({
    required this.none,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
  });

  final List<BoxShadow> none;
  final List<BoxShadow> xs;
  final List<BoxShadow> sm;
  final List<BoxShadow> md;
  final List<BoxShadow> lg;
  final List<BoxShadow> xl;
  final List<BoxShadow> xxl;

  static const light = NovaShadows(
    none: [],
    xs: [
      BoxShadow(
        color: Color(0x0D000000),
        blurRadius: 2,
        offset: Offset(0, 1),
      ),
    ],
    sm: [
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 3,
        offset: Offset(0, 1),
      ),
      BoxShadow(
        color: Color(0x0D000000),
        blurRadius: 2,
        offset: Offset(0, 1),
      ),
    ],
    md: [
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 6,
        offset: Offset(0, 4),
      ),
      BoxShadow(
        color: Color(0x0D000000),
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
    lg: [
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 15,
        offset: Offset(0, 10),
      ),
      BoxShadow(
        color: Color(0x0D000000),
        blurRadius: 6,
        offset: Offset(0, 4),
      ),
    ],
    xl: [
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 25,
        offset: Offset(0, 20),
      ),
      BoxShadow(
        color: Color(0x0D000000),
        blurRadius: 10,
        offset: Offset(0, 8),
      ),
    ],
    xxl: [
      BoxShadow(
        color: Color(0x40000000),
        blurRadius: 50,
        offset: Offset(0, 25),
      ),
    ],
  );

  static const dark = NovaShadows(
    none: [],
    xs: [
      BoxShadow(
        color: Color(0x33000000),
        blurRadius: 2,
        offset: Offset(0, 1),
      ),
    ],
    sm: [
      BoxShadow(
        color: Color(0x4D000000),
        blurRadius: 3,
        offset: Offset(0, 1),
      ),
      BoxShadow(
        color: Color(0x33000000),
        blurRadius: 2,
        offset: Offset(0, 1),
      ),
    ],
    md: [
      BoxShadow(
        color: Color(0x4D000000),
        blurRadius: 6,
        offset: Offset(0, 4),
      ),
      BoxShadow(
        color: Color(0x33000000),
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
    lg: [
      BoxShadow(
        color: Color(0x4D000000),
        blurRadius: 15,
        offset: Offset(0, 10),
      ),
      BoxShadow(
        color: Color(0x33000000),
        blurRadius: 6,
        offset: Offset(0, 4),
      ),
    ],
    xl: [
      BoxShadow(
        color: Color(0x4D000000),
        blurRadius: 25,
        offset: Offset(0, 20),
      ),
      BoxShadow(
        color: Color(0x33000000),
        blurRadius: 10,
        offset: Offset(0, 8),
      ),
    ],
    xxl: [
      BoxShadow(
        color: Color(0x80000000),
        blurRadius: 50,
        offset: Offset(0, 25),
      ),
    ],
  );

  @override
  NovaShadows copyWith({
    List<BoxShadow>? none,
    List<BoxShadow>? xs,
    List<BoxShadow>? sm,
    List<BoxShadow>? md,
    List<BoxShadow>? lg,
    List<BoxShadow>? xl,
    List<BoxShadow>? xxl,
  }) {
    return NovaShadows(
      none: none ?? this.none,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
    );
  }

  @override
  NovaShadows lerp(ThemeExtension<NovaShadows>? other, double t) {
    if (other is! NovaShadows) return this;
    return NovaShadows(
      none: BoxShadow.lerpList(none, other.none, t)!,
      xs: BoxShadow.lerpList(xs, other.xs, t)!,
      sm: BoxShadow.lerpList(sm, other.sm, t)!,
      md: BoxShadow.lerpList(md, other.md, t)!,
      lg: BoxShadow.lerpList(lg, other.lg, t)!,
      xl: BoxShadow.lerpList(xl, other.xl, t)!,
      xxl: BoxShadow.lerpList(xxl, other.xxl, t)!,
    );
  }
}

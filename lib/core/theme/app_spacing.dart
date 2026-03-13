import 'package:flutter/material.dart';

class AppSpacing {
  // Spacing Scale (4px base)
  static const double xxs = 4.0;
  static const double xs = 8.0;
  static const double s = 12.0;
  static const double m = 16.0;
  static const double l = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  // Horizontal Spacing
  static const SizedBox hXXS = SizedBox(width: xxs);
  static const SizedBox hXS = SizedBox(width: xs);
  static const SizedBox hS = SizedBox(width: s);
  static const SizedBox hM = SizedBox(width: m);
  static const SizedBox hL = SizedBox(width: l);
  static const SizedBox hXL = SizedBox(width: xl);

  // Vertical Spacing
  static const SizedBox vXXS = SizedBox(height: xxs);
  static const SizedBox vXS = SizedBox(height: xs);
  static const SizedBox vS = SizedBox(height: s);
  static const SizedBox vM = SizedBox(height: m);
  static const SizedBox vL = SizedBox(height: l);
  static const SizedBox vXL = SizedBox(height: xl);

  // Border Radius
  static const double radiusCard = 12.0;
  static const double radiusButton = 8.0;
  static const double radiusInput = 8.0;
  static const double radiusDialog = 16.0;

  static BorderRadius borderRadiusCard = BorderRadius.circular(radiusCard);
  static BorderRadius borderRadiusButton = BorderRadius.circular(radiusButton);
  static BorderRadius borderRadiusInput = BorderRadius.circular(radiusInput);
  static BorderRadius borderRadiusDialog = BorderRadius.circular(radiusDialog);
}

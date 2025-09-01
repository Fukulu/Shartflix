import 'package:flutter/material.dart';

class AppColors {
  // MARK - Main Colors
  static const Color primary = Color(0xFF1B67F3);
  static const Color primaryDark = Color(0xFF6F060B);
  static const Color secondary = Color(0xFF5949E6);

  // MARK - White Tones
  static const Color white90 = Color(0xE6FFFFFF);
  static const Color white80 = Color(0xCCFFFFFF);
  static const Color white70 = Color(0xB3FFFFFF);
  static const Color white60 = Color(0x99FFFFFF);
  static const Color white50 = Color(0x80FFFFFF);
  static const Color white40 = Color(0x66FFFFFF);
  static const Color white30 = Color(0x4DFFFFFF);
  static const Color white20 = Color(0x33FFFFFF);
  static const Color white10 = Color(0x1AFFFFFF);
  static const Color white05 = Color(0x0DFFFFFF);

  // MARK - Alert & Status
  static const Color alertSuccess = Color(0xFF00C247);
  static const Color alertInfo = Color(0xFF004CE8);
  static const Color alertWarning = Color(0xFFFFB816);
  static const Color alertError = Color(0xFFF47171);

  // MARK - Others
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // MARK - Gradients
  static const LinearGradient bgGradient = LinearGradient(
    colors: [Color(0xFF3F0306), Color(0xFF090909)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient popularCard = LinearGradient(
    colors: [Color(0xFF5949E6), Color(0xFFB82F3C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient normalCard = LinearGradient(
    colors: [Color(0xFF6F060B), Color(0xFFB82F3C)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient activeNav = LinearGradient(
    colors: [Color(0xFF6F060B), Color(0xFFB82F3C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

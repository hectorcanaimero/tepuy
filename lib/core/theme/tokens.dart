import 'package:flutter/material.dart';

/// Radios de esquina. Valores de docs/PRD.md §4.
class AppRadius {
  const AppRadius._();
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double full = 9999;
}

/// Paleta de color por tema. Los valores salen 1:1 de docs/PRD.md §4.
/// El oscuro viene del layout; el claro está derivado (mismo acento y tipografía).
class AppPalette {
  final Color bgPrimary;
  final Color bgSecondary;
  final Color bgCard;
  final Color bgCardHover;
  final Color accent;
  final Color accentLight;
  final Color accentGlow;
  final Color success;
  final Color warning;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color border;
  final Color overlay;

  const AppPalette({
    required this.bgPrimary,
    required this.bgSecondary,
    required this.bgCard,
    required this.bgCardHover,
    required this.accent,
    required this.accentLight,
    required this.accentGlow,
    required this.success,
    required this.warning,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.border,
    required this.overlay,
  });

  static const dark = AppPalette(
    bgPrimary: Color(0xFF0A0A0F),
    bgSecondary: Color(0xFF151520),
    bgCard: Color(0xFF1C1C2A),
    bgCardHover: Color(0xFF252538),
    accent: Color(0xFF7C5CFC),
    accentLight: Color(0xFFA78BFA),
    accentGlow: Color(0x337C5CFC),
    success: Color(0xFF34D399),
    warning: Color(0xFFFBBF24),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFF9CA3AF),
    textMuted: Color(0xFF6B7280),
    border: Color(0xFF2A2A3D),
    overlay: Color(0x990A0A0F),
  );

  static const light = AppPalette(
    bgPrimary: Color(0xFFF7F7FB),
    bgSecondary: Color(0xFFFFFFFF),
    bgCard: Color(0xFFFFFFFF),
    bgCardHover: Color(0xFFF0F0F5),
    accent: Color(0xFF7C5CFC),
    accentLight: Color(0xFFA78BFA),
    accentGlow: Color(0x227C5CFC),
    success: Color(0xFF10B981),
    warning: Color(0xFFD97706),
    textPrimary: Color(0xFF0A0A0F),
    textSecondary: Color(0xFF4B5563),
    textMuted: Color(0xFF9CA3AF),
    border: Color(0xFFE5E7EB),
    overlay: Color(0x660A0A0F),
  );
}

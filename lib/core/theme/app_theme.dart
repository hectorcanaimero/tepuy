import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'tokens.dart';

/// Arma los `ThemeData` de Tepuy a partir de la paleta de tokens (PRD §4).
/// El MVP corre en oscuro; el claro queda cableado para cuando se active.
class AppTheme {
  const AppTheme._();

  static final ThemeData dark = _build(AppPalette.dark, Brightness.dark);
  static final ThemeData light = _build(AppPalette.light, Brightness.light);

  static ThemeData _build(AppPalette p, Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: p.accent,
      brightness: brightness,
    ).copyWith(
      primary: p.accent,
      surface: p.bgCard,
      onSurface: p.textPrimary,
      outline: p.border,
      error: p.warning,
    );

    // ponytail: Inter vía google_fonts (fetch en runtime + cache). Si el
    // offline-first lo exige, bundlear el .ttf como asset. Upgrade path claro.
    final textTheme = GoogleFonts.interTextTheme(
      ThemeData(brightness: brightness).textTheme,
    ).apply(bodyColor: p.textPrimary, displayColor: p.textPrimary);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: p.bgPrimary,
      textTheme: textTheme,
      cardTheme: CardThemeData(
        color: p.bgCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),
      dividerColor: p.border,
    );
  }
}

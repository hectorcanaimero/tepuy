import '../core/domain/enums.dart';
import '../l10n/app_localizations.dart';

/// Labels localizados de los enums de dominio (los `.label` del enum son solo
/// para debug/seed; la UI usa estos).
extension CategoryL10n on Category {
  String localized(AppLocalizations l10n) => switch (this) {
    Category.naturaleza => l10n.catNaturaleza,
    Category.playas => l10n.catPlayas,
    Category.montanas => l10n.catMontanas,
    Category.ciudades => l10n.catCiudades,
    Category.islas => l10n.catIslas,
  };
}

extension DifficultyL10n on Difficulty {
  String localized(AppLocalizations l10n) => switch (this) {
    Difficulty.novato => l10n.difNovato,
    Difficulty.facil => l10n.difFacil,
    Difficulty.medio => l10n.difMedio,
    Difficulty.dificil => l10n.difDificil,
    Difficulty.experto => l10n.difExperto,
  };
}

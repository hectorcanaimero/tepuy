// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'TEPUY';

  @override
  String get homeTagline => 'Armá el rompecabezas, descubrí el lugar';

  @override
  String get navHome => 'Inicio';

  @override
  String get navDaily => 'Diario';

  @override
  String get navCollection => 'Colección';

  @override
  String get navProfile => 'Perfil';

  @override
  String get screenPlaceholder => 'Pantalla en construcción';

  @override
  String get retoDiario => 'RETO DIARIO';

  @override
  String get jugarAhora => 'Jugar Ahora';

  @override
  String get categorias => 'Categorías';

  @override
  String get verTodo => 'Ver Todo';

  @override
  String get populares => 'Populares';

  @override
  String get filtroTodos => 'Todos';

  @override
  String piezas(int count) {
    return '$count piezas';
  }

  @override
  String get catNaturaleza => 'Naturaleza';

  @override
  String get catPlayas => 'Playas';

  @override
  String get catMontanas => 'Montañas';

  @override
  String get catCiudades => 'Ciudades';

  @override
  String get catIslas => 'Islas';

  @override
  String get difNovato => 'Novato';

  @override
  String get difFacil => 'Fácil';

  @override
  String get difMedio => 'Media';

  @override
  String get difDificil => 'Difícil';

  @override
  String get difExperto => 'Experto';
}

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
  String get errorCargarLugares => 'No se pudieron cargar los lugares';

  @override
  String get seleccionaDificultad => 'Seleccioná la dificultad';

  @override
  String get jugar => 'Jugar';

  @override
  String mejorTiempo(String time) {
    return 'Mejor $time';
  }

  @override
  String get sinRecord => 'Sin récord';

  @override
  String restantes(int count) {
    return '$count restantes';
  }

  @override
  String piezasColocadas(int placed, int total) {
    return '$placed / $total';
  }

  @override
  String get toolPista => 'Pista';

  @override
  String get toolPreview => 'Vista previa';

  @override
  String get toolDeshacer => 'Deshacer';

  @override
  String get menuReiniciar => 'Reiniciar';

  @override
  String get menuSalir => 'Salir';

  @override
  String get rompecabezasCompletado => 'ROMPECABEZAS COMPLETADO';

  @override
  String get tiempoLabel => 'Tiempo';

  @override
  String get piezasSummary => 'Piezas';

  @override
  String get dificultadLabel => 'Dificultad';

  @override
  String get sobreEsteLugar => 'Sobre este lugar';

  @override
  String get datosClave => 'Datos clave';

  @override
  String get sabiasQue => '¿Sabías que?';

  @override
  String get siguienteRompecabezas => 'Siguiente Rompecabezas';

  @override
  String get guardarEnColeccion => 'Guardar en Colección';

  @override
  String get guardadoEnColeccion => 'Guardado en tu colección';

  @override
  String get compartir => 'Compartir';

  @override
  String get compartirProximamente => 'Compartir — próximamente';

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

  @override
  String get miColeccion => 'Mi Colección';

  @override
  String totalPuzzles(int count) {
    return '$count puzzles';
  }

  @override
  String get filtroCompletados => 'Completados';

  @override
  String get filtroEnProgreso => 'En Progreso';

  @override
  String get filtroFavoritos => 'Favoritos';

  @override
  String get statMejorTiempo => 'Mejor tiempo';

  @override
  String get coleccionVacia => 'Todavía no jugaste ningún rompecabezas';

  @override
  String progresoPct(int pct) {
    return '$pct% completado';
  }
}

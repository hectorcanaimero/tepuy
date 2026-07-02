/// Dominio compartido. La dificultad define el nº de piezas (PRD/TECH §3).
enum Difficulty {
  novato(50, 'Novato'),
  facil(110, 'Fácil'),
  medio(200, 'Medio'),
  dificil(300, 'Difícil'),
  experto(440, 'Experto');

  const Difficulty(this.pieceCount, this.label);

  final int pieceCount;
  final String label;
}

/// Categorías de lugares (filtros de Home).
enum Category {
  naturaleza('Naturaleza'),
  playas('Playas'),
  montanas('Montañas'),
  ciudades('Ciudades'),
  islas('Islas');

  const Category(this.label);

  final String label;
}

/// Estado de un puzzle para el usuario.
enum PuzzleStatus { locked, inProgress, completed }

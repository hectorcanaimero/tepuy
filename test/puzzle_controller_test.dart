import 'dart:ui';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tepuy/core/db/app_database.dart';
import 'package:tepuy/core/domain/enums.dart';
import 'package:tepuy/features/collection/data/user_puzzle_repository.dart';
import 'package:tepuy/features/puzzle/engine/puzzle_engine.dart';
import 'package:tepuy/features/puzzle/puzzle_controller.dart';

void main() {
  ({PuzzleController controller, UserPuzzleRepository repo}) build(int ms) {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final repo = UserPuzzleRepository(db);
    final board = PuzzleBoard.generate(
      cols: 2,
      rows: 2,
      boardSize: const Size(200, 200),
      snapThreshold: 10,
    );
    final c = PuzzleController(
      board: board,
      puzzleId: 'salto-angel-facil',
      repo: repo,
      elapsedMs: () => ms,
    );
    return (controller: c, repo: repo);
  }

  test('starsForTime: oro/plata/bronce por umbrales', () {
    expect(starsForTime(50 * 1000 - 1, 50), 3);
    expect(starsForTime(50 * 1500, 50), 2);
    expect(starsForTime(50 * 3000, 50), 1);
  });

  test('completar guarda status, mejor tiempo y estrellas', () async {
    final (:controller, :repo) = build(5000);
    for (final p in controller.board.pieces) {
      p.pos = p.home;
      await controller.drop(p.index);
    }
    expect(controller.completed, isTrue);

    final up = await repo.byPuzzle('salto-angel-facil');
    expect(up, isNotNull);
    expect(up!.status, PuzzleStatus.completed);
    expect(up.bestTimeMs, 5000);
    expect(up.stars, greaterThanOrEqualTo(1));
    expect(up.progressPct, 1);
  });

  test('progreso parcial persiste board_state para reanudar', () async {
    final (:controller, :repo) = build(3000);
    final first = controller.board.pieces.first;
    first.pos = first.home;
    await controller.drop(first.index);

    expect(controller.completed, isFalse);
    final up = await repo.byPuzzle('salto-angel-facil');
    expect(up!.status, PuzzleStatus.inProgress);
    expect(up.boardState, isNotNull);
    expect(up.progressPct, closeTo(0.25, 0.001));
  });
}

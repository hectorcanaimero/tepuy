import 'package:flutter/material.dart';

import 'puzzle_engine.dart';

/// Construye el `Path` de una pieza (con lengüetas bezier). El path puede
/// sobresalir de `size` en las lengüetas — se dibuja sin recortar.
Path piecePath(Size size, PieceEdges edges) {
  final w = size.width, h = size.height;
  final path = Path()..moveTo(0, 0);
  _side(path, const Offset(0, 0), Offset(w, 0), const Offset(0, -1), edges.top);
  _side(path, Offset(w, 0), Offset(w, h), const Offset(1, 0), edges.right);
  _side(path, Offset(w, h), Offset(0, h), const Offset(0, 1), edges.bottom);
  _side(path, Offset(0, h), const Offset(0, 0), const Offset(-1, 0), edges.left);
  return path..close();
}

void _side(Path p, Offset a, Offset b, Offset outward, Edge edge) {
  if (edge == Edge.flat) {
    p.lineTo(b.dx, b.dy);
    return;
  }
  final dir = b - a;
  final len = dir.distance;
  final u = dir / len; // dirección a lo largo del lado
  final n = outward * (edge == Edge.tabOut ? 1.0 : -1.0); // hacia dónde bombea
  final peak = 0.22 * len; // altura de la lengüeta
  final s1 = a + u * (len * 0.36);
  final s2 = a + u * (len * 0.64);
  final top1 = a + u * (len * 0.42) + n * peak;
  final top2 = a + u * (len * 0.58) + n * peak;

  p.lineTo(s1.dx, s1.dy);
  p.cubicTo(
    s1.dx + n.dx * peak * 0.4, s1.dy + n.dy * peak * 0.4,
    top1.dx - u.dx * len * 0.02, top1.dy - u.dy * len * 0.02,
    top1.dx, top1.dy,
  );
  p.cubicTo(
    top1.dx + u.dx * len * 0.06, top1.dy + u.dy * len * 0.06,
    top2.dx - u.dx * len * 0.06, top2.dy - u.dy * len * 0.06,
    top2.dx, top2.dy,
  );
  p.cubicTo(
    top2.dx + u.dx * len * 0.02, top2.dy + u.dy * len * 0.02,
    s2.dx + n.dx * peak * 0.4, s2.dy + n.dy * peak * 0.4,
    s2.dx, s2.dy,
  );
  p.lineTo(b.dx, b.dy);
}

/// Color placeholder de una pieza — gradiente 2D por posición (hasta que haya
/// fotos reales, esto hace el puzzle resoluble por color).
Color placeholderPieceColor(Piece piece, int cols, int rows, double baseHue) {
  final hue = (baseHue + (piece.col / cols) * 90) % 360;
  final light = 0.30 + 0.40 * (piece.row / rows);
  return HSLColor.fromAHSL(1, hue, 0.45, light).toColor();
}

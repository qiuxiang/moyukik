import 'package:flutter/material.dart';

class TriangleClipper extends CustomClipper<Path> {
  const TriangleClipper();

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 70);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_) => false;
}

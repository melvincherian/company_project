import 'package:flutter/material.dart';
import 'dart:math' as math;


class ShapeScreen extends StatelessWidget {
  const ShapeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shapes = [
      ShapeItem('Circle', const CircleShape()),
      ShapeItem('Square', const SquareShape()),
      ShapeItem('Rectangle', const RectangleShape()),
      ShapeItem('Triangle', const TriangleShape()),
      ShapeItem('Star', const StarShape()),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Select a Shape')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: shapes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final shape = shapes[index];
            return GestureDetector(
              onTap: () {
                // handle tap to use the selected shape
                debugPrint('Selected: ${shape.name}');
              },
              child: Column(
                children: [
                  Expanded(child: shape.widget),
                  const SizedBox(height: 4),
                  Text(shape.name),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ShapeItem {
  final String name;
  final Widget widget;

  ShapeItem(this.name, this.widget);
}

// Basic shapes using Flutter widgets or CustomPainter

class CircleShape extends StatelessWidget {
  const CircleShape({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
    );
  }
}

class SquareShape extends StatelessWidget {
  const SquareShape({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.green);
  }
}

class RectangleShape extends StatelessWidget {
  const RectangleShape({super.key});
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Container(color: Colors.orange),
    );
  }
}

class TriangleShape extends StatelessWidget {
  const TriangleShape({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TrianglePainter(),
      child: Container(),
    );
  }
}

class StarShape extends StatelessWidget {
  const StarShape({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _StarPainter(),
      child: Container(),
    );
  }
}

// Custom Painters

class _TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.purple;
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.amber;
    final path = Path();
    final double r = size.width / 2;
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    for (int i = 0; i < 5; i++) {
      double angle = (i * 72) * 3.1415926 / 180;
      double x = cx + r * math.cos(angle);
      double y = cy + r * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

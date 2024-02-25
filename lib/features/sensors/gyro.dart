import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeScreen extends StatefulWidget {
  const GyroscopeScreen({Key? key}) : super(key: key);

  @override
  State<GyroscopeScreen> createState() => _GyroscopeScreenState();
}

class _GyroscopeScreenState extends State<GyroscopeScreen> {
  double _x = 0.0;
  double _y = 0.0;
  double _lastX = 0.0;
  double _lastY = 0.0;
  late DateTime _lastUpdate;
  late Color _circleColor;
  late Timer _colorChangeTimer;
  late StreamSubscription<GyroscopeEvent> _gyroscopeSubscription;

  @override
  void initState() {
    super.initState();
    _lastUpdate = DateTime.now();
    _circleColor = Colors.blue; // Initial color

    _colorChangeTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _changeCircleColor();
    });

    _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      _updatePosition(event);
    });
  }

  void _updatePosition(GyroscopeEvent event) {
    DateTime now = DateTime.now();
    double dt = now.difference(_lastUpdate).inMilliseconds / 1000.0;
    _x += (_lastX + event.x / 2) * dt;
    _y += (_lastY + event.y / 2) * dt;
    _lastX = event.x;
    _lastY = event.y;
    _lastUpdate = now;
    setState(() {});
  }

  void _changeCircleColor() {
    setState(() {
      _circleColor = _generateRandomColor();
    });
  }

  Color _generateRandomColor() {
    final Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }

  @override
  void dispose() {
    _gyroscopeSubscription.cancel();
    _colorChangeTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gyroscope'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomPaint(
                  painter: GyroscopePainter(
                    x: _x,
                    y: _y,
                    shapeType: ShapeType.circle,
                    circleColor: _circleColor,
                  ),
                  size: Size(80, 80),
                ),
                CustomPaint(
                  painter: GyroscopePainter(
                    x: _x,
                    y: _y,
                    shapeType: ShapeType.square,
                    circleColor: _circleColor,
                  ),
                  size: Size(80, 80),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomPaint(
                  painter: GyroscopePainter(
                    x: _x,
                    y: _y,
                    shapeType: ShapeType.triangle,
                    circleColor: _circleColor,
                  ),
                  size: Size(80, 80),
                ),
                CustomPaint(
                  painter: GyroscopePainter(
                    x: _x,
                    y: _y,
                    shapeType: ShapeType.star,
                    circleColor: _circleColor,
                  ),
                  size: Size(80, 80),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Gyroscope values:\nX: ${_x.toStringAsFixed(2)}, Y: ${_y.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Color changes every 2 seconds',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}

enum ShapeType { circle, square, triangle, star }

class GyroscopePainter extends CustomPainter {
  final double x;
  final double y;
  final Color circleColor;
  final ShapeType shapeType;

  GyroscopePainter({
    required this.x,
    required this.y,
    required this.shapeType,
    required this.circleColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = circleColor;

    switch (shapeType) {
      case ShapeType.circle:
        canvas.drawCircle(Offset(x, y), size.width / 2, paint);
        break;
      case ShapeType.square:
        canvas.drawRect(
          Rect.fromCenter(
            center: Offset(x, y),
            width: size.width,
            height: size.height,
          ),
          paint,
        );
        break;
      case ShapeType.triangle:
        final path = Path()
          ..moveTo(x, y - size.height / 2)
          ..lineTo(x - size.width / 2, y + size.height / 2)
          ..lineTo(x + size.width / 2, y + size.height / 2)
          ..close();
        canvas.drawPath(path, paint);
        break;
      case ShapeType.star:
        final points = _calculateStarPoints(5, x, y, size.width / 2);
        final path = Path()..moveTo(points[0].dx, points[0].dy);
        for (int i = 1; i < points.length; i++) {
          path.lineTo(points[i].dx, points[i].dy);
        }
        path.close();
        canvas.drawPath(path, paint);
        break;
    }
  }

  List<Offset> _calculateStarPoints(
      int arms, double x, double y, double radius) {
    List<Offset> points = [];
    double angle = (2 * pi) / (2 * arms);
    for (int i = 0; i < 2 * arms; i++) {
      double r = (i.isEven) ? radius : radius / 2;
      double dx = x + r * cos(i * angle + pi / 2);
      double dy = y + r * sin(i * angle + pi / 2);
      points.add(Offset(dx, dy));
    }
    return points;
  }

  @override
  bool shouldRepaint(GyroscopePainter oldDelegate) {
    return oldDelegate.x != x ||
        oldDelegate.y != y ||
        oldDelegate.circleColor != circleColor ||
        oldDelegate.shapeType != shapeType;
  }
}

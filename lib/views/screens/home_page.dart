import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  DateTime _now = DateTime.now();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double secondAngle = _now.second * 2 * pi / 60;
    double minuteAngle = (_now.minute + _now.second / 60) * 2 * pi / 60;
    double hourAngle = (_now.hour % 12 + _now.minute / 60) * 2 * pi / 12;

    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Clock background
            CustomPaint(
              size: const Size(300, 300),
              painter: ClockPainter(),
            ),
            // Second hand
            AnimatedRotation(
              duration: const Duration(seconds: 1),
              turns: secondAngle / (2 * pi),
              child: CustomPaint(
                size: const Size(300, 300),
                painter: SecondHandPainter(),
              ),
            ),
            // Minute hand
            AnimatedRotation(
              duration: const Duration(seconds: 1),
              turns: minuteAngle / (2 * pi),
              child: CustomPaint(
                size: const Size(300, 300),
                painter: MinuteHandPainter(),
              ),
            ),
            // Hour hand
            AnimatedRotation(
              duration: const Duration(seconds: 1),
              turns: hourAngle / (2 * pi),
              child: CustomPaint(
                size: const Size(300, 300),
                painter: HourHandPainter(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      110,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class SecondHandPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(size.width / 2, size.height / 2 - 10)
      ..lineTo(size.width / 2, size.height / 2 - 100);

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MinuteHandPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(size.width / 2, size.height / 2 - 10)
      ..lineTo(size.width / 2, size.height / 2 - 80);

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class HourHandPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(size.width / 2, size.height / 2 - 10)
      ..lineTo(size.width / 2, size.height / 2 - 70);

    canvas.drawPath(path, linePaint);

    final pointPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 10, pointPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

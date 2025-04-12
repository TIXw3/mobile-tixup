import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _arcAnimation;
  late Animation<double> _arcLengthAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _arcAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi,
    ).animate(_controller);

    _arcLengthAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: math.pi * 0.3, end: 0.1),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.1, end: math.pi * 0.3),
        weight: 50,
      ),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 247, 245),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  size: const Size(120, 120),
                  painter: LogoPainter(
                    arcProgress: _arcAnimation.value,
                    arcLength: _arcLengthAnimation.value,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Carregando...',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontFamily: 'sans-serif',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Por favor, aguarde',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
                fontFamily: 'sans-serif',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LogoPainter extends CustomPainter {
  final double arcProgress;
  final double arcLength;

  LogoPainter({required this.arcProgress, required this.arcLength});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.45;

    final ticketPaint =
        Paint()
          ..color = Colors.black87
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(math.pi * 0.15);
    canvas.translate(15, -8);
    drawTicketBehind(canvas, size.width * 0.7, size.height * 0.35, ticketPaint);
    canvas.restore();

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(math.pi * 0.08);
    drawTicketFront(canvas, size.width * 0.7, size.height * 0.35, ticketPaint);
    canvas.restore();

    final orangePaint =
        Paint()
          ..color = Color.fromARGB(206, 231, 87, 47)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0
          ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      arcProgress,
      arcLength,
      false,
      orangePaint,
    );
  }

  void drawTicketFront(
    Canvas canvas,
    double width,
    double height,
    Paint paint,
  ) {
    final path = Path();
    final radius = height * 0.25;

    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset.zero, width: width, height: height),
        Radius.circular(radius),
      ),
    );

    final dashPath = Path();
    final dashWidth = 4.0;
    final dashSpace = 4.0;
    double startX = -width / 2;

    while (startX < width / 2) {
      dashPath.moveTo(startX, 0);
      dashPath.lineTo(startX + dashWidth, 0);
      startX += dashWidth + dashSpace;
    }

    canvas.drawPath(path, paint);
    canvas.drawPath(dashPath, paint);
  }

  void drawTicketBehind(
    Canvas canvas,
    double width,
    double height,
    Paint paint,
  ) {
    final path = Path();
    final radius = height * 0.25;

    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset.zero, width: width, height: height),
        Radius.circular(radius),
      ),
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(LogoPainter oldDelegate) {
    return oldDelegate.arcProgress != arcProgress ||
        oldDelegate.arcLength != arcLength;
  }
}

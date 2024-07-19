// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class AnimatedLineAndBorder extends StatefulWidget {
  @override
  _AnimatedLineAndBorderState createState() => _AnimatedLineAndBorderState();
}

class _AnimatedLineAndBorderState extends State<AnimatedLineAndBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _lineAnimation;
  late Animation<double> _borderAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _lineAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5),
      ),
    );

    _borderAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.5, 1.0)),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              child: AnimatedBuilder(
                animation: _lineAnimation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: LinePainter(
                      borderColor: Colors.blue,
                      animationValue: _lineAnimation.value,
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: 200,
              height: 200,
              child: AnimatedBuilder(
                animation: _borderAnimation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: BoxPainter(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final Color borderColor;
  final double animationValue;

  LinePainter({required this.borderColor, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = borderColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    canvas.drawLine(Offset(size.width / 2, 0),
        Offset(size.width / 2, size.height * animationValue), paint);
    canvas.drawCircle(Offset(size.width / 2, 0), 8.0, paint);
    if (animationValue >= 0.88) {
      canvas.drawCircle(Offset(size.width / 2, size.height), 8, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class BoxPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    paint.color = Colors.black;
    var leftSidePath = Path();
    leftSidePath.lineTo(size.width, 0);
    leftSidePath.lineTo(size.width, size.height);
    leftSidePath.lineTo(0, size.height);
    leftSidePath.lineTo(0, 0);
    leftSidePath.lineTo(0, size.height);
    canvas.drawPath(leftSidePath, paint);

    paint.color = Colors.black;
    var rightSidePath = Path();
    rightSidePath.moveTo(size.width / 2, 0);
    rightSidePath.lineTo(size.width, 0);
    rightSidePath.lineTo(size.width, size.height);
    rightSidePath.lineTo(size.width / 2, size.height);
    canvas.drawPath(rightSidePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class BorderPainter extends CustomPainter {
  final double animationValue;
  final Color borderColor;

  BorderPainter(this.animationValue, {required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    double perimeter = 2 * (size.width + size.height);

    // Calculate the progress of the border drawing based on animationValue
    double progress = animationValue * perimeter;

    // Draw the border segment by segment based on progress
    if (progress <= size.width) {
      path.moveTo(0, 0);
      path.lineTo(progress, 0);
    } else if (progress <= size.width + size.height) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, progress - size.width);
    } else if (progress <= 2 * size.width + size.height) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(
          size.width - (progress - size.width - size.height), size.height);
    } else if (progress <= perimeter) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.lineTo(0, size.height - (progress - 2 * size.width - size.height));
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Border Animation')),
        body: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAnimationShow = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  isAnimationShow = true;
                  setState(() {});
                },
                child: Text("Click"),
              ),
            ),
            isAnimationShow ? const BorderAnimationWidget(borderColor: Colors.amber) : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class BorderAnimationWidget extends StatefulWidget {
  final Color borderColor;
  const BorderAnimationWidget({super.key, required this.borderColor});

  @override
  BorderAnimationWidgetState createState() => BorderAnimationWidgetState();
}

class BorderAnimationWidgetState extends State<BorderAnimationWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1200).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: BorderPainter(
          _animation.value,
          borderColor: widget.borderColor,
        ),
        child: Container(
          width: 300,
          height: 300,
        ),
      ),
    );
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

    if (animationValue <= size.width) {
      path.moveTo(0, 0);
      path.lineTo(animationValue, 0);
    } else if (animationValue <= size.width + size.height) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, animationValue - size.width);
    } else if (animationValue <= 2 * size.width + size.height) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width - (animationValue - size.width - size.height), size.height);
    } else if (animationValue <= perimeter) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.lineTo(0, size.height - (animationValue - 2 * size.width - size.height));
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

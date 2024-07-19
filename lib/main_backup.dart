import 'package:animation_create/text_animation_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
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
            isAnimationShow
                ? BorderAnimationWidget(
                    borderColor: Colors.amber,
                    onTapForBarier: () {
                      isAnimationShow = false;
                      setState(() {});
                    },
                    onTapForBox: () {
                      print("========++Hello");
                    },
                    style: TextStyle(color: Colors.amber),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class BorderAnimationWidget extends StatefulWidget {
  final Color borderColor;
  final void Function() onTapForBarier;
  final void Function() onTapForBox;
  final TextStyle? style;

  const BorderAnimationWidget({
    super.key,
    required this.borderColor,
    required this.onTapForBarier,
    required this.onTapForBox,
    this.style,
  });

  @override
  BorderAnimationWidgetState createState() => BorderAnimationWidgetState();
}

class BorderAnimationWidgetState extends State<BorderAnimationWidget> with SingleTickerProviderStateMixin {
  late AnimationController boxController;
  late Animation<double> boxAnimation;

  @override
  void initState() {
    super.initState();
    boxAnimationCreate();
  }

  void boxAnimationCreate() {
    boxController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    boxAnimation = Tween<double>(begin: 0, end: 1200).animate(boxController)
      ..addListener(() {
        setState(() {});
      });

    boxController.forward();
  }

  @override
  void dispose() {
    boxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTapForBarier,
      child: Container(
        height: double.infinity,
        color: Colors.white30,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextAnimationView(style: widget.style, text: "Hello"),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: widget.onTapForBox,
                child: CustomPaint(
                  painter: BorderPainter(
                    boxAnimation.value,
                    borderColor: widget.borderColor,
                  ),
                  child: const SizedBox(width: 300, height: 300),
                ),
              ),
            ],
          ),
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

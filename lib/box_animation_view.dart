import 'package:animation_create/painter.dart';
import 'package:animation_create/text_animation_view.dart';
import 'package:flutter/material.dart';

class BoxAnimationView extends StatefulWidget {
  final Color borderColor;
  final void Function() onTapForBarier;
  final void Function() onTapForBox;
  final TextStyle? style;
  final double xPos;
  final double yPos;
  final String text;
  final bool isTopText;

  const BoxAnimationView({
    super.key,
    required this.borderColor,
    required this.onTapForBarier,
    required this.onTapForBox,
    required this.xPos,
    required this.yPos,
    required this.text,
    this.style,
    this.isTopText = true,
  });

  @override
  State<BoxAnimationView> createState() => _BoxAnimationViewState();
}

class _BoxAnimationViewState extends State<BoxAnimationView> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation1;
  late Animation<double> animation2;

  @override
  void initState() {
    setAnimation1();
    super.initState();
  }

  void setAnimation1() {
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 1),
      ),
    );

    animation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(1, 2),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.xPos,
      top: widget.yPos,
      child: InkWell(
        splashColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        onTap: widget.onTapForBarier,
        child: Column(
          children: [
            widget.isTopText ? TextAnimationView(style: widget.style, text: widget.text) : const SizedBox.shrink(),
            widget.isTopText
                ? InkWell(
                    onTap: widget.onTapForBox,
                    child: AnimatedBuilder(
                      animation: animation1,
                      builder: (context, child) => CustomPaint(
                        painter: LinePainter(borderColor: widget.borderColor, animationValue: controller.value),
                        child: Container(height: 50),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            InkWell(
              onTap: widget.onTapForBox,
              child: AnimatedBuilder(
                animation: animation2,
                builder: (context, child) {
                  return CustomPaint(
                    foregroundPainter: BorderPainter(controller.value, borderColor: widget.borderColor),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.transparent,
                      ),
                      width: 200,
                      height: 200,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  );
                },
              ),
            ),
            !widget.isTopText
                ? InkWell(
                    onTap: widget.onTapForBox,
                    child: AnimatedBuilder(
                      animation: animation1,
                      builder: (context, child) => CustomPaint(
                        painter: LinePainter(borderColor: widget.borderColor, animationValue: controller.value),
                        child: Container(height: 50),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            !widget.isTopText ? TextAnimationView(style: widget.style, text: widget.text) : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

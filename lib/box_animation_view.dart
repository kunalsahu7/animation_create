import 'dart:math';

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

class _BoxAnimationViewState extends State<BoxAnimationView>
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
      CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.5)),
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
            topPartView(),
            boxView(borderColor: widget.borderColor),
            bottomPartView(),
          ],
        ),
      ),
    );
  }

  Widget bottomPartView() {
    return Column(
      children: [
        !widget.isTopText
            ? Transform.rotate(
                angle: pi / 1,
                child: InkWell(
                  onTap: widget.onTapForBox,
                  child: lineView(borderColor: widget.borderColor),
                ),
              )
            : const SizedBox.shrink(),
        !widget.isTopText ? SizedBox(height: 15) : const SizedBox.shrink(),
        !widget.isTopText
            ? TextAnimationView(style: widget.style, text: widget.text)
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget topPartView() {
    return Column(
      children: [
        widget.isTopText
            ? TextAnimationView(style: widget.style, text: widget.text)
            : const SizedBox.shrink(),
        widget.isTopText ? SizedBox(height: 15) : const SizedBox.shrink(),
        widget.isTopText
            ? InkWell(
                onTap: widget.onTapForBox,
                child: lineView(borderColor: widget.borderColor),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  // InkWell(
  //   onTap: widget.onTapForBox,
  //   child: AnimatedBuilder(
  //     animation: animation2,
  //     builder: (context, child) {
  //       return CustomPaint(
  //         foregroundPainter: BorderPainter(controller.value, borderColor: widget.borderColor),
  //         child: Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(15),
  //             color: Colors.transparent,
  //           ),
  //           width: 200,
  //           height: 200,
  //           padding: EdgeInsets.symmetric(horizontal: 10),
  //         ),
  //       );
  //     },
  //   ),
  // ),

  Widget lineView({required Color borderColor}) {
    return SizedBox(
      height: 50,
      child: AnimatedBuilder(
        animation: _lineAnimation,
        builder: (context, child) {
          return CustomPaint(
            painter: LinePainter(
              borderColor: borderColor,
              animationValue: _lineAnimation.value,
            ),
          );
        },
      ),
    );
  }

  Widget boxView({required Color borderColor}) {
    return Transform.rotate(
      angle: widget.isTopText ? pi / 2 : -(pi / 2),
      child: SizedBox(
        width: 200,
        height: 200,
        child: InkWell(
          onTap: widget.onTapForBox,
          child: AnimatedBuilder(
            animation: _borderAnimation,
            builder: (context, child) {
              return CustomPaint(
                painter: BoxPainter(
                  animation: _borderAnimation.value,
                  borderColor: _lineAnimation.value == 1
                      ? borderColor
                      : Colors.transparent,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class BoxPainter extends CustomPainter {
  final double animation;
  final Color borderColor;

  BoxPainter({required this.animation, required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    paint.color = borderColor;
    var leftSidePath = Path();
    leftSidePath.lineTo((size.width * animation), 0);
    leftSidePath.lineTo((size.width * animation), size.height);
    leftSidePath.lineTo(0, size.height);
    leftSidePath.lineTo(0, 0);
    leftSidePath.lineTo(0, size.height);
    canvas.drawPath(leftSidePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

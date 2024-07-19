import 'package:flutter/material.dart';

class TextAnimationView extends StatefulWidget {
  final TextStyle? style;
  final String text;
  const TextAnimationView({super.key, this.style, required this.text});

  @override
  TextAnimationViewState createState() => TextAnimationViewState();
}

class TextAnimationViewState extends State<TextAnimationView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: Text(
              widget.text,
              style: widget.style ?? TextStyle(fontSize: 20),
            ),
          );
        },
      ),
    );
  }
}

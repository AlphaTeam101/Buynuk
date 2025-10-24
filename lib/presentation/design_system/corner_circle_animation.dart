
import 'package:flutter/material.dart';

class CornerCircleAnimation extends StatefulWidget {
  final Widget child;

  const CornerCircleAnimation({super.key, required this.child});

  @override
  State<CornerCircleAnimation> createState() => _CornerCircleAnimationState();
}

class _CornerCircleAnimationState extends State<CornerCircleAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -MediaQuery.of(context).size.width * 0.7,
          right: -MediaQuery.of(context).size.width * 0.7,
          child: ScaleTransition(
            scale: _animation,
            child: Container(
              width: MediaQuery.of(context).size.width * 1.4,
              height: MediaQuery.of(context).size.width * 1.4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withOpacity(0.2),
              ),
            ),
          ),
        ),
        widget.child,
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

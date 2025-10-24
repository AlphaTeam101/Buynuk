
import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedBubblesBackground extends StatefulWidget {
  final Widget child;

  const AnimatedBubblesBackground({super.key, required this.child});

  @override
  State<AnimatedBubblesBackground> createState() => _AnimatedBubblesBackgroundState();
}

class _AnimatedBubblesBackgroundState extends State<AnimatedBubblesBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Bubble> _bubbles;
  final int numberOfBubbles = 10;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _bubbles = List.generate(numberOfBubbles, (index) => Bubble());
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        _updateBubbles();
        return CustomPaint(
          painter: BubblesPainter(bubbles: _bubbles),
          child: widget.child,
        );
      },
      child: widget.child,
    );
  }

  void _updateBubbles() {
    for (var bubble in _bubbles) {
      bubble.y -= bubble.speed;
      if (bubble.y < -bubble.size) {
        bubble.reset(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Bubble {
  late double x;
  late double y;
  late double size;
  late double speed;
  late Color color;
  late double opacity;

  Bubble() {
    reset(0, 0); // Initial reset, will be updated with actual screen size
  }

  void reset(double screenWidth, double screenHeight) {
    Random random = Random();
    x = random.nextDouble() * screenWidth;
    y = screenHeight + random.nextDouble() * screenHeight; // Start below the screen
    size = random.nextDouble() * 50 + 20; // Size between 20 and 70
    speed = random.nextDouble() * 2 + 0.5; // Speed between 0.5 and 2.5
    color = Colors.white; // Or any color you prefer
    opacity = random.nextDouble() * 0.5 + 0.2; // Opacity between 0.2 and 0.7
  }
}

class BubblesPainter extends CustomPainter {
  final List<Bubble> bubbles;

  BubblesPainter({required this.bubbles});

  @override
  void paint(Canvas canvas, Size size) {
    for (var bubble in bubbles) {
      final paint = Paint()
        ..color = bubble.color.withOpacity(bubble.opacity)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(bubble.x, bubble.y), bubble.size / 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

import 'dart:math' as pi;

import 'package:flutter/material.dart';

class AnimationManager {
  AnimatedBuilder tabTransition({
    required AnimationController controller,
    required Widget child,
    required Size size,
  }) {
    Animation<double> animation =
        Tween(begin: -3.14 / 4, end: 0.0).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut, // Use the desired easing curve
    ));
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        return Transform.rotate(
          angle: -2 * pi.pi * animation.value,
          origin: Offset(0, size.height),
          child: child,
        );
      },
    );
  }
}

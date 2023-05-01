import 'package:flutter/material.dart';

class AnimationManager {
  Animation<double> tabTransition(AnimationController controller) {
    return CurvedAnimation(parent: controller, curve: Curves.easeInCirc);
    //Tween<double>(begin: 0, end: -2 * pi).animate();
    // return Tween<double>(begin: -1 * pi, end: -2 * pi);
  }
}

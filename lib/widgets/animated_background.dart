import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimatedBackground extends StatelessWidget {
  final bool isGlitched;
  const AnimatedBackground({super.key, required this.isGlitched});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Lottie.asset(
        isGlitched
            ? 'lib/utils/animations/glitched_game_bg_animation.json'
            : 'lib/utils/animations/game_bg_animation.json',
        fit: BoxFit.cover,
        repeat: true,
      ),
    );
  }
}

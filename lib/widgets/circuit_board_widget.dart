import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: library_private_types_in_public_api
final GlobalKey<_CircuitBoardState> circuitBoardKey = GlobalKey<_CircuitBoardState>();

class CircuitBoard extends StatefulWidget {
  final bool isCorrectMore;
  const CircuitBoard({super.key, required this.isCorrectMore});

  @override
  State<CircuitBoard> createState() =>
      _CircuitBoardState();
}

class _CircuitBoardState extends State<CircuitBoard> {
  final GlobalKey<_CircuitBoardState> circuitBoardKey = GlobalKey();
  double smokeOpacity = 1.0;

  void reduceSmoke() {
    setState(() {
      smokeOpacity = (smokeOpacity - 0.15).clamp(0.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (_, constraints) {
          final screenWidth = constraints.maxWidth;
          final boardAspectRatio = 1080 / 1920;
          final imageWidth = screenWidth;
          final imageHeight = screenWidth / boardAspectRatio;

          final ramOffsetX = imageWidth * 0.41;
          final ramOffsetY = imageHeight * 0.88;

          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  'lib/utils/images/circuit_board.png',
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                left: ramOffsetX + 20,
                top: ramOffsetY - 80,
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: widget.isCorrectMore ? Opacity(
                    opacity: smokeOpacity,
                    child: Lottie.asset(
                      'lib/utils/animations/smoke_animation.json',
                      fit: BoxFit.contain,
                      repeat: true,
                    ),
                  ) : Lottie.asset(
                      'lib/utils/animations/ram_on_fire.json',
                      fit: BoxFit.contain,
                      repeat: true,
                    ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: library_private_types_in_public_api
final GlobalKey<_GameViewWithCircuitBoardState> circuitBoardKey = GlobalKey<_GameViewWithCircuitBoardState>();

class GameViewWithCircuitBoard extends StatefulWidget {
  const GameViewWithCircuitBoard({super.key});

  @override
  State<GameViewWithCircuitBoard> createState() =>
      _GameViewWithCircuitBoardState();
}

class _GameViewWithCircuitBoardState extends State<GameViewWithCircuitBoard> {
  final GlobalKey<_GameViewWithCircuitBoardState> circuitBoardKey = GlobalKey();
  double smokeOpacity = 1.0;

  void reduceSmoke() {
    setState(() {
      smokeOpacity = (smokeOpacity - 0.1).clamp(0.0, 1.0);
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
                  child: Opacity(
                    opacity: smokeOpacity,
                    child: Lottie.asset(
                      'lib/utils/animations/smoke_animation.json',
                      fit: BoxFit.contain,
                      repeat: true,
                    ),
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

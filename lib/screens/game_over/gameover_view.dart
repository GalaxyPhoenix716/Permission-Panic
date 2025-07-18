import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:permission_panic/screens/game_over/loser.dart';
import 'package:permission_panic/screens/game_over/winner.dart';
import 'package:permission_panic/screens/game_screen/game_view.dart';
import 'package:permission_panic/screens/main_menu/main_menu_view.dart';
import 'package:permission_panic/widgets/animated_background.dart';
import 'package:permission_panic/widgets/cartoon_button.dart';

class GameOver extends StatelessWidget {
  final bool isWinner;
  final int rightSwipes;
  final int wrongSwipes;
  const GameOver({
    super.key,
    required this.isWinner,
    required this.rightSwipes,
    required this.wrongSwipes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          AnimatedBackground(isGlitched: !isWinner),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: const Color.fromARGB(
                255,
                255,
                255,
                255,
              ).withValues(alpha: 0.5),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isWinner
                  ? GameWin(rightSwipes: rightSwipes, wrongSwipes: wrongSwipes)
                  : GameLost(
                      rightSwipes: rightSwipes,
                      wrongSwipes: wrongSwipes,
                    ),
              const SizedBox(height: 20,),
              CartoonButton(
                label: "Main Menu",
                size: 20,
                spacing: 2,
                isboxShadow: false,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => MainMenuView()),
                    (_) => false,
                  );
                },
              ),
              const SizedBox(height: 20,),
              CartoonButton(
                label: "Replay",
                size: 20,
                spacing: 2,
                isboxShadow: false,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => GameView()),
                    (_) => false,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

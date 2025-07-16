import 'package:flutter/material.dart';
import 'package:permission_panic/screens/game_over/loser.dart';
import 'package:permission_panic/screens/game_over/winner.dart';

class GameOver extends StatelessWidget {
  final bool isWinner;
  const GameOver({super.key, required this.isWinner});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [isWinner ? GameWin() : GameLost()]),
    );
  }
}

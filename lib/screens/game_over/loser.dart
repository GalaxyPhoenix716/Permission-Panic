import 'package:flutter/material.dart';

class GameLost extends StatelessWidget {
  const GameLost({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text('Loser'),
    );
  }
}
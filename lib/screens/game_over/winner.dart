import 'package:flutter/material.dart';

class GameWin extends StatelessWidget {
  const GameWin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text('Winner'),
    );
  }
}
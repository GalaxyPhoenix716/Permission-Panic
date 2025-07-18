import 'package:flutter/material.dart';
import 'package:permission_panic/screens/game_over/gameover_view.dart';
import 'package:permission_panic/screens/main_menu/main_menu_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Permission Panic',
      debugShowCheckedModeBanner: false,
      home: GameOver(isWinner: true, rightSwipes: 10, wrongSwipes: 2),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:permission_panic/screens/game_screen/game_view.dart';
import 'package:permission_panic/widgets/animated_background.dart';
import 'package:permission_panic/widgets/cartoon_button.dart';
import 'package:permission_panic/widgets/cartoon_text.dart';

class MainMenuView extends StatelessWidget {
  const MainMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBackground(isGlitched: false),
          Positioned.fill(
            child: Image(
              image: AssetImage('lib/utils/images/main_menu_items.png'),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 130),
                Transform.rotate(
                  angle: -0.08,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 16),
                    child: CartoonTextLogo(
                      title: "PERMISSION\nPANIC!!",
                      size: 70,
                      strokeWidth: 15,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
                SizedBox(height: 70),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CartoonTextLogo(title: "Can you survive the\napp-ocalypse?", size: 35, strokeWidth: 8, color: Colors.white),
                ),
                SizedBox(height: 40,),
                Center(
                  child: CartoonButton(
                    label: "START",
                    size: 35,
                    spacing: 5,
                    isboxShadow: true,
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => GameView()),
                        (_) => false,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

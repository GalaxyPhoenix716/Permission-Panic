import 'package:flutter/material.dart';

class CartoonTextLogo extends StatelessWidget {
  final String title;
  final double size;
  final double strokeWidth;
  final Color color;

  const CartoonTextLogo({
    super.key,
    required this.title,
    required this.size,
    required this.strokeWidth,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background shadow text
        Positioned(
          child: FittedBox(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size,
                fontFamily: 'Luckiest guy',
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = strokeWidth
                  ..color = const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
        ),
        // Foreground filled text
        FittedBox(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: size,
              fontFamily: 'Luckiest guy',
              color: color,
              letterSpacing: 2,
            ),
          ),
        ),
      ],
    );
  }
}

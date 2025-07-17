import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class GlitchOverlay extends StatefulWidget {
  const GlitchOverlay({super.key});

  @override
  State<GlitchOverlay> createState() => _GlitchOverlayState();
}

class _GlitchOverlayState extends State<GlitchOverlay> {
  final Random _random = Random();

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startLineTimer();
  }

  void _startLineTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 120), (_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  List<Widget> _generateLines(BoxConstraints constraints) {
    return List.generate(15, (_) {
      double top = _random.nextDouble() * constraints.maxHeight;
      double width = _random.nextDouble() * constraints.maxWidth;
      double thickness = _random.nextBool() ? 1.0 : 2.0;
      Color color = _random.nextBool()
          ? Colors.white.withValues(alpha: 0.15)
          : Colors.redAccent.withValues(alpha: 0.1);

      return Positioned(
        top: top,
        left: 0,
        child: Container(width: width, height: thickness, color: color),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              ..._generateLines(constraints),

              // Optional soft flicker overlay
              Positioned.fill(
                child: Container(color: Colors.black.withValues(alpha: 0.02)),
              ),
            ],
          );
        },
      ),
    );
  }
}

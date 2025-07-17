import 'dart:math';
import 'package:flutter/material.dart';

class ClockWithHand extends StatefulWidget {
  final int remainingTime;
  final int totalTime;

  const ClockWithHand({
    super.key,
    required this.remainingTime,
    this.totalTime = 60,
  });

  @override
  State<ClockWithHand> createState() => _ClockWithHandState();
}

class _ClockWithHandState extends State<ClockWithHand>
    with TickerProviderStateMixin {
  late AnimationController _shakeController;
  late Animation<Offset> _shakeAnimation;

  @override
  void initState() {
    super.initState();

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..repeat(reverse: true);

    _shakeAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.03, 0),
    ).animate(CurvedAnimation(
      parent: _shakeController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(covariant ClockWithHand oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.remainingTime < 10 && !_shakeController.isAnimating) {
      _shakeController.repeat(reverse: true);
    } else if (widget.remainingTime >= 10 && _shakeController.isAnimating) {
      _shakeController.stop();
    }
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = 1 - (widget.remainingTime / widget.totalTime);
    final angle = 2 * pi * progress;

    return SlideTransition(
      position: widget.remainingTime < 10 ? _shakeAnimation : AlwaysStoppedAnimation(Offset.zero),
      child: SizedBox(
        width: 40,
        height: 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.access_time, size: 40, color: Colors.white),
            Transform.rotate(
              angle: angle,
              child: Container(
                width: 2,
                height: 14,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

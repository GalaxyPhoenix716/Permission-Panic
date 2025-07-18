import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_panic/utils/constants/helpers.dart';

final GlobalKey<_WrongSwipeOverlayState> wrongSwipeKey = GlobalKey();

class WrongSwipeOverlay extends StatefulWidget {
  const WrongSwipeOverlay({super.key});

  @override
  State<WrongSwipeOverlay> createState() => _WrongSwipeOverlayState();
}

class _WrongSwipeOverlayState extends State<WrongSwipeOverlay>
    with TickerProviderStateMixin {
  bool _visible = false;

  late AnimationController _textSlideController;
  late Animation<Offset> _textSlideRight;
  late Animation<Offset> _textSlideLeft;
  late AnimationController _shakeController;

  Future<void> showOverlay() async {
    setState(() => _visible = true);
    _textSlideController.forward();
    _shakeController.repeat(reverse: true);

    Timer(const Duration(seconds: 2), () {
      _shakeController.stop();
    });

    Timer(const Duration(seconds: 2), () {
      _textSlideController.reverse();
      setState(() => _visible = false);
    });
  }

  @override
  void initState() {
    super.initState();

    _textSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    );

    _textSlideRight =
        Tween<Offset>(begin: const Offset(1.0, 0), end: Offset.zero).animate(
          CurvedAnimation(parent: _textSlideController, curve: Curves.easeInOut),
        );

    _textSlideLeft =
        Tween<Offset>(begin: const Offset(-1.0, 0), end: Offset.zero).animate(
          CurvedAnimation(parent: _textSlideController, curve: Curves.easeInOut),
        );
  }

  @override
  void dispose() {
    _textSlideController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !_visible,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: _visible ? 1.0 : 0.0,
        child: Stack(
          children: [
            // Blurred background
            BackdropFilter(
              filter: _visible
                  ? ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0)
                  : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(color: Colors.black.withValues(alpha: 0.5)),
            ),

            // Content
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Danger Lottie
                  Transform.rotate(
                    angle: -0.1,
                    child: Transform.scale(
                      scale: 1.3,
                      child: Lottie.asset(
                        'lib/utils/animations/wrongswipe_dangersign.json',
                        width: PPHelpers.getScreenWidth(context)*0.7,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Sliding Text: "This app crashed the cores"
                  SlideTransition(
                    position: _textSlideRight,
                    child: FittedBox(
                      child: Text(
                        "This app crashed the cores",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 255, 17, 0),
                          fontSize: 50,
                          fontFamily: 'Spirit Fox'
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Loader animation
                  Lottie.asset(
                    'lib/utils/animations/wrongswipe_dangerstrip.json',
                    width: PPHelpers.getScreenWidth(context),
                    height: 60,
                    fit: BoxFit.fill,
                    repeat: true,
                  ),

                  // Sliding Text: "-3 seconds"
                  SlideTransition(
                    position: _textSlideLeft,
                    child: FittedBox(
                      child: Text(
                        "-5 seconds",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 255, 17, 0),
                          fontSize: 50,
                          fontFamily: 'Spirit Fox'
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Background shaking "WRONG"
            AnimatedBuilder(
              animation: _shakeController,
              builder: (_, child) {
                double offsetX = 3 * (_shakeController.value - 0.5);
                return Transform.translate(
                  offset: Offset((offsetX * 10)+5, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Transform.rotate(
                      angle: -0.2,
                      child: FittedBox(
                        child: Text(
                          "WRONG!!",
                          style: TextStyle(
                            fontSize: 400,
                            color: const Color.fromARGB(255, 160, 11, 0),
                            letterSpacing: 10,
                            fontFamily: 'Spirit Fox'
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

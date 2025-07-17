import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:permission_panic/models/permission_card.dart';
import 'package:permission_panic/screens/game_over/gameover_view.dart';
import 'package:permission_panic/utils/controllers/game_controller.dart';
import 'package:permission_panic/widgets/glitch_overlay_widget.dart';
import 'package:permission_panic/widgets/permission_card_widget.dart';
import 'package:permission_panic/widgets/sussy_offer_widget.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  final GameController _gameController = GameController();
  double swipeOffset = 0;

  late Timer _timer;
  bool _isPaused = false;

  //Game state
  bool showsussyOffer = false;
  int? sussyOfferTriggerTime;
  bool isGlitching = false;
  bool freezeUI = false;
  Color glitchBgColor = Colors.blue;
  bool isShaking = false;
  double _shakeOffsetX = 0;
  double _shakeOffsetY = 0;
  double _shakeRotation = 0;

  @override
  void initState() {
    super.initState();

    startGameTimer();
    Future.microtask(() async {
      await _gameController.loadCardsFromJson('lib/data/cards.json');
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  ///TIMER FUNCTIONS///
  void startGameTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    if (_isPaused) return;

    setState(() {
      _gameController.remainingTime--;
    });

    //check for timer over
    if (_gameController.remainingTime <= 0) {
      _timer.cancel();
      endGame();
      return;
    }

    //check for sussy offer
    if (_gameController.checkIfSussyOfferShouldShow()) {
      showSussyOfferPopup(context, (choice) {
        if (choice == SussyOfferAction.cancel) {} 
        else if (choice == SussyOfferAction.install) {
          handleSussyInstall(context);
        }
      });
      setState(() {
        showsussyOffer = true;
      });
    }
  }

  void _pauseGameTimer() {
    _isPaused = true;
    _timer.cancel();
  }

  void _resumeGameTimer() {
    if (!_isPaused || _gameController.remainingTime <= 0) return;
    _isPaused = false;
    startGameTimer();
  }

  ///GAME FUNCTIONING///

  //Handles swiping logic
  void handleSwipeEnd() {
    const swipeThreshold = 100;

    if (swipeOffset.abs() > swipeThreshold) {
      final swipedRight = swipeOffset > 0;
      animateSwipeAway(swipedRight);
    } else {
      // reset card if swipe was too less
      setState(() {
        swipeOffset = 0;
      });
    }
  }

  //Card swipe animation
  Future<void> animateSwipeAway(bool swipedRight) async {
    final direction = swipedRight ? 1.0 : -1.0;

    //animate card sliding out off the screen
    for (int i = 0; i < 10; i++) {
      setState(() {
        swipeOffset += 20 * direction;
      });
      await Future.delayed(Duration(milliseconds: 10));
    }

    //evaluate result after each swipe
    final result = _gameController.evaluateSwipe(swipedRight);

    if (result) {
      //correct swipe
      movetoNextCardWithAnimation();
    } else {
      //wrong swipe
      // await triggerPenaltyAnimation();
      movetoNextCardWithAnimation();
    }
  }

  //Popping next card with pop animation
  Future<void> movetoNextCardWithAnimation() async {
    //reset swipe
    setState(() {
      swipeOffset = 0.0;
    });

    await Future.delayed(
      Duration(milliseconds: 100),
    ); //a little delay for smooth animation

    final hasNext = _gameController.moveToNextCard();

    if (!hasNext || _gameController.remainingTime <= 0) {
      endGame();
    } else {
      setState(() {});
    }
  }

  //Handling sussy offer decision
  void handleSussyInstall(BuildContext context) async {
    setState(() {
      _gameController.remainingTime += 10; //added the 10 seconds for the bait
    });

    await Future.delayed(
      Duration(seconds: 3),
    ); //let the game run normal for a few seonds

    await showGlitchAnimation(); //boooommm ram crashed
  }

  //Glitch animation
  Future<void> showGlitchAnimation() async {
    setState(() {
      isGlitching = true;
      glitchBgColor = Colors.blue.shade700; //change bg color
      freezeUI = true;
    });

    await Future.delayed(Duration(seconds: 1));

    startShakeAnimation(); //shake screen

    await Future.delayed(const Duration(seconds: 2));

    //show crash dialog
    if (!mounted) return;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black87,
        title: const Text(
          '💥 System Crashed!',
          style: TextStyle(color: Colors.redAccent),
        ),
        content: const Text(
          'You should never download untrusted files.\n\nfishy.exe crashed the system.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (builder) => GameOver(isWinner: false),
                ),
                (_) => false,
              );
            },
            child: const Text(
              'Okay',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isGlitching = false;
      freezeUI = false;
    });
  }

  //Screen Shake animation
  void startShakeAnimation() {
    const int shakeDuration = 1000; // 1 second
    const int interval = 40; // more frequent = smoother
    int elapsed = 0;
    final random = Random();

    isShaking = true;

    Timer.periodic(const Duration(milliseconds: interval), (timer) {
      if (elapsed >= shakeDuration) {
        timer.cancel();
        setState(() {
          _shakeOffsetX = 0;
          _shakeOffsetY = 0;
          _shakeRotation = 0;
          isShaking = false;
        });
        return;
      }

      setState(() {
        // Random between -15 and 15 px for X/Y
        _shakeOffsetX = (random.nextDouble() * 30 - 15);
        _shakeOffsetY = (random.nextDouble() * 30 - 15);

        // Random rotation between -0.03 and 0.03 radians (~±1.7°)
        _shakeRotation = (random.nextDouble() * 0.06) - 0.03;
      });

      elapsed += interval;
    });
  }

  //End game
  void endGame() {
    final isWinner = _gameController.didPlayerWin();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => GameOver(isWinner: isWinner)),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_gameController.cards.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF0D1117),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    PermissionCard currentCard = _gameController.currentCard;

    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(),
      body: Stack(
        children: [
          AbsorbPointer(
            //used to handle screen freeze feature
            absorbing: freezeUI,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              color: isGlitching ? glitchBgColor : const Color(0xFF0D1117),
              child: Transform.translate(
                //used to handle screen shake feature
                offset: Offset(
                  _shakeOffsetX,
                  _shakeOffsetY,
                ),
                child: Transform.rotate(        //screen rotate along with shake
                  angle: _shakeRotation,
                  child: Column(
                    children: [
                      Text(
                        '${_gameController.remainingTime}s',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            if (freezeUI) return;
                            setState(() {
                              swipeOffset += details.delta.dx;
                            });
                          },
                          onPanEnd: (details) {
                            if (freezeUI) return;
                            handleSwipeEnd();
                          },
                          child: Transform.translate(       //used for swipe feature
                            offset: Offset(swipeOffset, 0),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              transitionBuilder: (child, animation) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              },
                              child: PermissionCardWidget(
                                permissionCard: currentCard,
                                key: ValueKey(_gameController.currentCard.id),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          if (isGlitching) const GlitchOverlay(),
        ],
      ),
    );
  }
}

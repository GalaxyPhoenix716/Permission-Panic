import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_panic/models/permission_card.dart';
import 'package:permission_panic/utils/controllers/game_controller.dart';
import 'package:permission_panic/widgets/permission_card_widget.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  final GameController _gameController = GameController();
  double swipeOffset = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _gameController.decrementTimer();
      if (_gameController.remainingTime <= 0) {
        _timer.cancel();
        endGame();
      }
      setState(() {});
    });

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
      Duration(milliseconds: 400),
    ); //a little delay for smooth animation

    final hasNext = _gameController.moveToNextCard();

    if (!hasNext || _gameController.remainingTime <= 0) {
      endGame();
    } else {
      setState(() {});
    }
  }

  //End game
  void endGame() {
    // final isWinner = _gameController.didPlayerWin();
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
      body: Column(
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
                setState(() {
                  swipeOffset += details.delta.dx;
                });
              },
              onPanEnd: (details) {
                handleSwipeEnd();
              },
              child: Transform.translate(
                offset: Offset(swipeOffset, 0),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(scale: animation, child: child);
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
    );
  }
}

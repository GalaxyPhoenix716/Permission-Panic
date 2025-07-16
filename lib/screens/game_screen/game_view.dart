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
  double cardX = 0;

  @override
  void initState() {
    super.initState();

    // You can make init async using Future.microtask:
    Future.microtask(() async {
      await _gameController.loadCardsFromJson('lib/data/cards.json');
    });
  }

  void handleSwipe(bool approved) {
    // Advance to the next card
    // bool hasNext = _controller.moveToNextCard();

    // if (!hasNext) {
    //   // Go to result screen or show dialog
    //   // Navigator.pushReplacementNamed(context, '/result');
    // } else {
    //   setState(() {
    //     cardX = 0;
    //     cardY = 0;
    //   });
    // }
  }

  void resetCardPosition() {
    setState(() {
      cardX = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_gameController.cards.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF0D1117),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // PermissionCard currentCard = _controller.currentCard;

    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: Center(
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              cardX += details.delta.dx;
            });
          },
          onPanEnd: (details) {
            if (cardX > 100) {
              handleSwipe(true); // Swipe right → approve
            } else if (cardX < -100) {
              handleSwipe(false); // Swipe left → deny
            } else {
              resetCardPosition();
            }
          },
          // child: Transform.translate(
          //   offset: Offset(cardX, cardY),
          //   child: PermissionCardWidget(permissionCard: currentCard),
          // ),
        ),
      ),
    );
  }
}

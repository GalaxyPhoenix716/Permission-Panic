import 'dart:convert';
// import 'dart:developer' as devtools show log;
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:permission_panic/models/permission_card.dart';

class GameController {
  //Game Cards
  List<PermissionCard> cards = [];
  int currentCardIndex = 0;

  //Timer
  int totalTime = 30;
  int remainingTime = 30;

  //Score
  int correctAnswers = 0;

  //Suspicious Download Offer
  bool enableSussyOffer = false;
  bool sussyOfferShown = false;

  //Getter for the cards
  PermissionCard get currentCard => cards[currentCardIndex];

  //Load cards from cards.json
  Future<void> loadCardsFromJson(String path) async {
    final String cardJsonString = await rootBundle.loadString(path);    //extracts json in string form
    final List<dynamic> cardJsonData = jsonDecode(cardJsonString);      //decode json in string form to list
    final List<PermissionCard> allCards = cardJsonData.map((item) {
      return PermissionCard.fromJson(item);
    }).toList();      //Convert json list of items to permission card objects

    ///We loaded our permission cards. Now we have to shuffle and select any random 12 of those///
    
    allCards.shuffle();
    final selectedCards = allCards.take(12).toList();   //shuffled and took 12 cards at random

    ///Now we have to assign which side is allow swiped on///
    
    final random = Random();
    cards = selectedCards.map((card) {
      return card.copyWith(allowOnRight: random.nextBool());
    }).toList();    //randomly assign side where the user should swpie to allow the permission

    //Reset game values
    currentCardIndex = 0;
    correctAnswers = 0;
    remainingTime = totalTime;
    enableSussyOffer = Random().nextInt(5) == 0;    //20% chance of this popping up
    sussyOfferShown = false;

  }

  //Decrease time
  void decrementTimer() {
    if (remainingTime > 0) {
      remainingTime --;
    }
  }

  //Evaluating if the user swiped to the correct side
  bool evaluateSwipe(bool userSelectecdAllow) {
    final card = currentCard;

    if((userSelectecdAllow && card.isSafe) || (!userSelectecdAllow && !card.isSafe)) {
      correctAnswers++;
      return true;
    } else {
      applyPenalty();
      return false;
    }
  }

  //Apply penalty for wrong choice
  void applyPenalty() {
    final penalty = 5;
    remainingTime -= penalty;

    if (remainingTime < 0) {
      remainingTime = 0;
    }
  }

  //Moving to next card after swiping
  bool moveToNextCard() {
    if(currentCardIndex + 1 >= cards.length) {      //checking if cards are over or not
      return false;
    } else {
      currentCardIndex++;
      return true;
    }
  }

  //Popping sussy download offer
  bool checkIfSussyOfferShouldShow() {
    if (!enableSussyOffer || sussyOfferShown) {
      return false;
    } 

    if (remainingTime < 10) {
      sussyOfferShown = true;     //this wil prevent it to occur again
      return true;
    }

    return false;
  }

  //checking if player won
  bool didPlayerWin() {
    return correctAnswers >= (cards.length * 0.75).ceil();
  }
}

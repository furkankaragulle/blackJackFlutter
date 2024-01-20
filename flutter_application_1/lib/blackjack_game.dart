// blackjack_game.dart
import 'deck.dart';
import 'player.dart';
import 'card.dart';

class BlackjackGame {
  Deck deck = Deck();
  Player player = Player();
  Player dealer = Player();

  void startGame() {
    deck.shuffle();

    player.hand.clear();
    dealer.hand.clear();

    hit(player);
    hit(dealer);
    hit(player);
    hit(dealer);
  }

  void hit(Player player) {
    MyCard card = deck.drawCard();
    player.hand.add(card);
  }

  void stand() {
    while (dealer.calculateScore() < 17) {
      hit(dealer);
    }

    determineWinner();
  }

  bool gameIsOngoing = true;
  bool playerWins = false;
  bool dealerWins = false;

  String determineWinner() {
    int playerScore = player.calculateScore();
    int dealerScore = dealer.calculateScore();

    if (playerScore > 21) {
      gameIsOngoing = false;
      dealerWins = true;
      return "Dağıtıcı kazandı!";
    } else if (dealerScore > 21) {
      gameIsOngoing = false;
      playerWins = true;
      return "Oyuncu kazandı!";
    } else if (playerScore == dealerScore) {
      gameIsOngoing = false;
      return "Berabere!";
    } else if (playerScore > dealerScore) {
      gameIsOngoing = false;
      playerWins = true;
      return "Oyuncu kazandı!";
    } else {
      gameIsOngoing = false;
      dealerWins = true;
      return "Dağıtıcı kazandı!";
    }
  }
}

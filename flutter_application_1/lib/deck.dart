// deck.dart
import 'card.dart';

class Deck {
  List<MyCard> cards = [];

  Deck() {
    initializeDeck();
  }

  void initializeDeck() {
    for (var suit in ['Hearts', 'Diamonds', 'Clubs', 'Spades']) {
      for (var rank in [
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10',
        'J',
        'Q',
        'K',
        'A'
      ]) {
        cards.add(MyCard(suit, rank));
      }
    }
  }

  void shuffle() {
    cards.shuffle();
  }

  MyCard drawCard() {
    if (cards.isNotEmpty) {
      return cards.removeLast();
    } else {
      throw Exception("No cards left in the deck");
    }
  }
}
